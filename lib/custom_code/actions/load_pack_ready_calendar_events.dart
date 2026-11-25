// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart' show GZipDecoder, GZipEncoder;
import 'package:flutter/foundation.dart' show kDebugMode;

import '/custom_code/actions/call_pack_ready_apple_calendar.dart'
    show AppleCalendarAdapter, callPackReadyAppleCalendar;
import '/custom_code/actions/connect_google_pack_ready_calendars.dart'
    show GoogleCalendarAdapter;

class CalendarSource {
  const CalendarSource({
    required this.id,
    required this.provider,
    required this.name,
    required this.color,
    this.enabled = true,
  });

  final String id, provider, name, color;
  final bool enabled;

  String get key => '$provider:$id';

  Map<String, Object> toMap() => {
        'id': id,
        'provider': provider,
        'name': name,
        'color': color,
        'enabled': enabled,
      };

  CalendarSource withEnabled(bool value) => CalendarSource(
        id: id,
        provider: provider,
        name: name,
        color: color,
        enabled: value,
      );

  factory CalendarSource.fromMap(Map data) => CalendarSource(
        id: (data['id'] as String?)?.trim() ?? '',
        provider: (data['provider'] as String?)?.trim() ?? 'google',
        name: (data['name'] as String?)?.trim().isNotEmpty == true
            ? (data['name'] as String).trim()
            : 'Calendar',
        color: (data['color'] as String?)?.trim().isNotEmpty == true
            ? (data['color'] as String).trim()
            : '#75A8DF',
        enabled: data['enabled'] != false,
      );
}

const googleCalendarReconnectNotice =
    'Reconnect Google Calendar to refresh events';
const googleCalendarStaleNotice =
    'Reconnect Google Calendar to sync your full schedule';

typedef CalendarRead = ({
  List<PackReadyCalendarEventStruct> events,
  String? warning
});

typedef CalendarSnapshot = ({
  List<PackReadyCalendarEventStruct> events,
  String? warning,
  String? notice,
});

enum CalendarDisconnectChoice { keep, remove }

typedef ConfirmCalendarDisconnect = Future<CalendarDisconnectChoice?> Function(
  List<CalendarSource> sources,
  int count,
);

abstract class CalendarAdapter {
  Future<List<CalendarSource>> sources();
  Future<CalendarRead> events(
    List<CalendarSource> calendars, {
    DateTime? rangeStart,
    DateTime? rangeEnd,
  });
}

/// Permanent Firestore single source of truth for per-calendar sections on
/// `/users/{uid}.calendarSections`. Hiding toggles only `enabled`; adding
/// merges new sections alongside existing ones; only explicit disconnect
/// removes a calendar section.
class CalendarSync {
  CalendarSync(this.user);
  final DocumentReference user;
  final _apple = AppleCalendarAdapter();
  GoogleCalendarAdapter? _google;
  final Set<String> _activeGoogleKeys = {};
  final Map<String, List<({DateTime start, DateTime end})>> _extraRanges = {};
  final Map<String, Map<String, PackReadyCalendarEventStruct>> _extraEvents =
      {};
  Future<void> _writeQueue = Future.value();

  static const _field = 'calendarSections';
  static const _appleImported = 'appleCalendarSectionsImported';
  static const _syncSchemaVersion = 3;
  static const _defaultPastDays = 90;
  static const _defaultFutureDays = 365;
  static const _maxPersistRangeDays = 560;
  static const _maxBlobBytes = 840 * 1024;
  static const _example = CalendarSource(
    id: 'demo',
    provider: 'demo',
    name: 'Example Calendar',
    color: '#AADA70',
    enabled: false,
  );

  Map<String, Map<String, dynamic>> _sections = {};
  bool _importedApple = false;

  CalendarSource get example =>
      _example.withEnabled(_sections[_example.key]?['enabled'] == true);
  bool get hasGoogle => _google != null;
  bool get needsAppleImport => !_importedApple;
  bool hasLiveGoogle(CalendarSource source) =>
      _google != null && _activeGoogleKeys.contains(source.key);
  bool hasSavedEvents(CalendarSource source) =>
      _sections[source.key]?['events'] is Blob;

  static DateTime? _readTimestamp(Object? value) => value is Timestamp
      ? value.toDate().toUtc()
      : value is DateTime
          ? value.toUtc()
          : null;

  bool _isSectionStale(Map<String, dynamic>? section) {
    if (section == null || section['events'] is! Blob) return true;
    final version = (section['syncVersion'] as num?)?.toInt() ?? 0;
    if (version < _syncSchemaVersion) return true;
    final syncEnd = _readTimestamp(section['syncEnd']);
    if (syncEnd == null) return true;
    return syncEnd
        .isBefore(DateTime.now().toUtc().add(const Duration(days: 60)));
  }

  ({DateTime start, DateTime end})? _persistedRange(String key) {
    final section = _sections[key];
    if (section == null || section['events'] is! Blob) return null;
    final start = _readTimestamp(section['syncStart']);
    final end = _readTimestamp(section['syncEnd']);
    if (start == null || end == null) return null;
    return (start: start, end: end);
  }

  bool _coversDate(String key, DateTime probeUtc) {
    final persisted = _persistedRange(key);
    if (persisted != null &&
        !probeUtc.isBefore(persisted.start) &&
        !probeUtc.isAfter(persisted.end)) {
      return true;
    }
    for (final range in _extraRanges[key] ?? const []) {
      if (!probeUtc.isBefore(range.start) && !probeUtc.isAfter(range.end)) {
        return true;
      }
    }
    return false;
  }

  bool needsExpansionFor(DateTime day) {
    final probe = DateTime.utc(day.year, day.month, day.day, 12);
    return calendars.any(
      (source) =>
          source.enabled &&
          (source.provider == 'apple' || hasLiveGoogle(source)) &&
          !_coversDate(source.key, probe),
    );
  }

  bool hasUncoveredSavedGoogle(DateTime day) {
    final probe = DateTime.utc(day.year, day.month, day.day, 12);
    return calendars.any(
      (source) =>
          source.enabled &&
          source.provider == 'google' &&
          !hasLiveGoogle(source) &&
          !_coversDate(source.key, probe),
    );
  }

  /// Widest saved/loaded [syncStart, syncEnd] span across currently enabled live calendars.
  ({DateTime start, DateTime end})? get syncedRange {
    DateTime? minStart;
    DateTime? maxEnd;
    void include(DateTime start, DateTime end) {
      if (minStart == null || start.isBefore(minStart!)) minStart = start;
      if (maxEnd == null || end.isAfter(maxEnd!)) maxEnd = end;
    }

    for (final source in calendars.where((s) => s.enabled)) {
      final persisted = _persistedRange(source.key);
      if (persisted != null) include(persisted.start, persisted.end);
      for (final extra in _extraRanges[source.key] ?? const []) {
        include(extra.start, extra.end);
      }
    }
    if (minStart == null || maxEnd == null) return null;
    return (start: minStart!.toLocal(), end: maxEnd!.toLocal());
  }

  bool get hasStaleGoogleSync => calendars.any(
        (source) =>
            source.enabled &&
            source.provider == 'google' &&
            !hasLiveGoogle(source) &&
            _isSectionStale(_sections[source.key]),
      );

  List<CalendarSource> get calendars => [
        for (final section in _sections.values)
          if (section['provider'] != 'demo' &&
              section['id'] is String &&
              (section['id'] as String).isNotEmpty)
            CalendarSource.fromMap(section),
      ]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  Future<T> _serialize<T>(Future<T> Function() work) {
    final next = _writeQueue.catchError((_) {}).then((_) => work());
    _writeQueue = next.then((_) {}, onError: (_) {});
    return next;
  }

  static Map<String, Map<String, dynamic>> _readSections(Map data) {
    final result = <String, Map<String, dynamic>>{};
    final saved = data[_field];
    if (saved is Map) {
      for (final entry in saved.entries) {
        if (entry.key is! String || entry.value is! Map) continue;
        final section = Map<String, dynamic>.from(entry.value as Map);
        if (section['id'] is! String || section['provider'] is! String)
          continue;
        result[entry.key as String] = section;
      }
      result.putIfAbsent(
        _example.key,
        () => {..._example.toMap(), 'enabled': false},
      );
      return result;
    }
    final prefs = data['calendarSourceEnabled'] as Map? ?? const {};
    final google = data['googleCalendarConnection'] as Map?;
    result[_example.key] = {
      ..._example.toMap(),
      'enabled': prefs[_example.key] == true,
    };
    for (final source
        in (google?['sources'] as List? ?? const []).whereType<Map>()) {
      final id = source['id'];
      if (id is! String || id.isEmpty) continue;
      final key = 'google:$id';
      result[key] = {
        ...CalendarSource.fromMap({...source, 'provider': 'google'}).toMap(),
        'enabled':
            prefs[key] is bool ? prefs[key] : (source['enabled'] != false),
      };
    }
    return result;
  }

  Future<void> restore({bool migrate = true}) async {
    final snapshot = await user.get();
    final data = snapshot.data() as Map? ?? const {};
    _sections = _readSections(data);
    _importedApple = data[_appleImported] == true;
    if (migrate && !data.containsKey(_field) && snapshot.exists) {
      await _editSections((_, __) {});
    }
    if (kDebugMode) {
      final snap = savedEvents();
      final googleCount =
          snap.events.where((event) => event.provider == 'google').length;
      final appleCount =
          snap.events.where((event) => event.provider == 'apple').length;
      debugPrint(
        'Calendar Firestore read: $googleCount visible Google events, '
        '$appleCount visible Apple events, ${calendars.length} saved calendars',
      );
    }
  }

  Future<void> _editSections(
    void Function(Map<String, Map<String, dynamic>> sections, Map profile)
        edit, {
    bool importApple = false,
  }) =>
      _serialize(() async {
        final result = await user.firestore.runTransaction((transaction) async {
          final profile =
              (await transaction.get(user)).data() as Map? ?? const {};
          final sections = _readSections(profile);
          edit(sections, profile);
          final bytes = sections.values.fold<int>(
            0,
            (total, section) =>
                total + ((section['events'] as Blob?)?.bytes.length ?? 0),
          );
          if (bytes > _maxBlobBytes) {
            throw const FormatException(
              'Synced calendars exceed the Firestore storage limit.',
            );
          }
          transaction.set(
            user,
            {_field: sections, if (importApple) _appleImported: true},
            SetOptions(mergeFields: [_field, if (importApple) _appleImported]),
          );
          return sections;
        });
        _sections = result;
        if (importApple) _importedApple = true;
      });

  static Iterable<PackReadyCalendarEventStruct> _readEvents(
    Blob? blob,
    CalendarSource source,
  ) sync* {
    if (blob == null) return;
    try {
      final decoded = jsonDecode(
        utf8.decode(GZipDecoder().decodeBytes(blob.bytes)),
      );
      if (decoded is! List) return;
      for (final item in decoded.whereType<Map>()) {
        final raw = Map<String, dynamic>.from(item);
        raw.putIfAbsent('provider', () => source.provider);
        raw.putIfAbsent('calendarId', () => source.id);
        raw.putIfAbsent('calendarName', () => source.name);
        final event = PackReadyCalendarEventStruct.fromMap(raw);
        if (event.id.isNotEmpty &&
            DateTime.tryParse(event.start) != null &&
            DateTime.tryParse(event.end) != null) {
          yield event;
        }
      }
    } catch (failure) {
      if (kDebugMode) {
        debugPrint(
            'Calendar failed decoding events for ${source.key}: $failure');
      }
    }
  }

  static Blob _encodeEvents(
    List<PackReadyCalendarEventStruct> events, {
    bool includeNotes = true,
  }) {
    final payload = [
      for (final event in events)
        <String, dynamic>{
          'id': event.id,
          'title': event.title,
          'start': event.start,
          'end': event.end,
          if (event.allDay) 'allDay': true,
          if (event.location.isNotEmpty) 'location': event.location,
          if (includeNotes && event.notes.isNotEmpty) 'notes': event.notes,
          if (event.seriesId.isNotEmpty) 'seriesId': event.seriesId,
          if (event.recurrence.isNotEmpty) 'recurrence': event.recurrence,
          'provider': event.provider,
          'calendarId': event.calendarId,
          'calendarName': event.calendarName,
        },
    ];
    return Blob(
      Uint8List.fromList(
          GZipEncoder().encode(utf8.encode(jsonEncode(payload)))!),
    );
  }

  static void _mergeSource(
    Map<String, Map<String, dynamic>> sections,
    CalendarSource source, {
    bool? enabled,
  }) {
    final before = sections[source.key];
    sections[source.key] = {
      ...?before,
      ...source.toMap(),
      'enabled': before?['enabled'] is bool
          ? before!['enabled']
          : (enabled ?? source.enabled),
    };
  }

  static bool _eventInRanges(
    PackReadyCalendarEventStruct event,
    List<({DateTime start, DateTime end})> ranges,
  ) {
    final start = DateTime.tryParse(event.start)?.toUtc();
    if (start == null) return false;
    for (final range in ranges) {
      if (!start.isBefore(range.start) && !start.isAfter(range.end)) {
        return true;
      }
    }
    return false;
  }

  List<PackReadyCalendarEventStruct> _mergedEventsFor(CalendarSource source) {
    final byId = <String, PackReadyCalendarEventStruct>{};
    final extraRanges = _extraRanges[source.key] ?? const [];
    for (final event in _readEvents(
      _sections[source.key]?['events'] as Blob?,
      source,
    )) {
      if (extraRanges.isNotEmpty && _eventInRanges(event, extraRanges)) {
        continue;
      }
      byId[event.id] = event;
    }
    final extras = _extraEvents[source.key];
    if (extras != null) {
      byId.addAll(extras);
    }
    return byId.values.toList();
  }

  CalendarSnapshot savedEvents({String? warning}) {
    final activeGoogle = calendars.any(
      (source) =>
          source.enabled &&
          source.provider == 'google' &&
          !hasLiveGoogle(source),
    );
    final notice = !activeGoogle
        ? null
        : hasStaleGoogleSync
            ? googleCalendarStaleNotice
            : googleCalendarReconnectNotice;
    return (
      events: [
        for (final source in calendars.where((source) => source.enabled))
          ..._mergedEventsFor(source),
      ],
      warning: warning,
      notice: notice,
    );
  }

  Future<({int calendarCount, int enabledCount, String? warning})>
      connectGoogle(GoogleCalendarAdapter adapter,
          {DateTime? focusDate}) async {
    final sources = await adapter.sources();
    if (sources.isEmpty) {
      throw const FormatException(
        'Google returned no calendars for this account.',
      );
    }
    try {
      await _editSections((sections, _) {
        final hadLive = sections.values.any((s) => s['provider'] != 'demo');
        for (final source in sources) {
          _mergeSource(sections, source);
        }
        if (!hadLive) {
          sections[_example.key]!['enabled'] = false;
        }
      });
    } on FirebaseException catch (failure) {
      throw FormatException(
        'Could not save Google calendar settings (${failure.code}).',
      );
    }
    _google = adapter;
    _activeGoogleKeys
      ..clear()
      ..addAll(sources.map((source) => source.key));

    // Persist events for ALL calendars in this Google account so toggling any
    // calendar visible later in a fresh session renders immediately without OAuth.
    final refreshed = await refresh(
      includeHiddenGoogle: true,
      focusDate: focusDate,
    );
    final enabledCount = sources
        .where((source) => _sections[source.key]?['enabled'] == true)
        .length;
    return (
      calendarCount: sources.length,
      enabledCount: enabledCount,
      warning: refreshed.warning,
    );
  }

  Future<String?> addApple(String link, String name, String color) async {
    final added = await _apple.add(link, name, color);
    await _editSections((sections, _) {
      final hadLive = sections.values.any((s) => s['provider'] != 'demo');
      _mergeSource(sections, added);
      if (!hadLive) sections[_example.key]!['enabled'] = false;
    });
    final read = await _apple.events([added]);
    if (read.warning != null && read.events.isEmpty) return read.warning;
    final nowUtc = DateTime.now().toUtc();
    await _persistWithFallback(
      {added.key: read.events},
      ranges: {
        added.key: (
          start: nowUtc.subtract(const Duration(days: _defaultPastDays)),
          end: nowUtc.add(const Duration(days: _defaultFutureDays)),
        ),
      },
    );
    return read.warning;
  }

  Future<void> setEnabled(CalendarSource source, bool enabled) => _serialize(
        () async {
          final section = _sections[source.key];
          if (section == null) return;
          final previous = section['enabled'] == true;
          section['enabled'] = enabled;
          try {
            if (source.provider == 'demo') {
              await user.update({
                FieldPath([_field, source.key]): {
                  ...source.toMap(),
                  'enabled': enabled,
                },
              });
            } else {
              await user.update({
                FieldPath([_field, source.key, 'enabled']): enabled,
              });
            }
          } on FirebaseException catch (failure) {
            if (failure.code == 'not-found') {
              await user.firestore.runTransaction((tx) async {
                final profile = (await tx.get(user)).data() as Map? ?? const {};
                final sections = _readSections(profile);
                sections[source.key] = {
                  ...(sections[source.key] ?? source.toMap()),
                  'enabled': enabled,
                };
                tx.set(
                  user,
                  {_field: sections},
                  SetOptions(mergeFields: [_field]),
                );
                _sections = sections;
              });
              return;
            }
            section['enabled'] = previous;
            rethrow;
          } catch (_) {
            section['enabled'] = previous;
            rethrow;
          }
        },
      );

  Future<bool> disconnect(
    List<CalendarSource> sources,
    ConfirmCalendarDisconnect confirm,
  ) async {
    if (sources.isEmpty) return false;
    final selection = [
      for (final source in sources)
        {'provider': source.provider, 'id': source.id},
    ];
    final preview = await callPackReadyAppleCalendar({
      'operation': 'disconnectPreview',
      'sources': selection,
    });
    final count = (preview['count'] as num?)?.toInt() ?? 0;
    final choice = await confirm(sources, count);
    if (choice == null) return false;
    await callPackReadyAppleCalendar({
      'operation': 'disconnect',
      'sources': selection,
      'disposition': choice.name,
    });
    await _editSections((sections, _) {
      for (final source in sources) {
        sections.remove(source.key);
      }
    });
    final hadGoogle = sources.any((source) => source.provider == 'google');
    for (final source in sources) {
      _activeGoogleKeys.remove(source.key);
      _extraRanges.remove(source.key);
      _extraEvents.remove(source.key);
    }
    if (_activeGoogleKeys.isEmpty) _google = null;
    if (hadGoogle && !calendars.any((source) => source.provider == 'google')) {
      unawaited(GoogleCalendarAdapter.clearSession());
    }
    return true;
  }

  Future<bool> importLegacyApple() async {
    if (_importedApple) return false;
    try {
      final before = calendars.where((s) => s.provider == 'apple').length;
      await _importAppleSources();
      return calendars.where((s) => s.provider == 'apple').length > before;
    } catch (_) {
      return false;
    }
  }

  Future<void> _importAppleSources() async {
    if (_importedApple) return;
    final sources = await _apple.sources();
    await _editSections((sections, profile) {
      if (profile[_appleImported] == true) return;
      final prefs = profile['calendarSourceEnabled'] as Map? ?? const {};
      for (final source in sources) {
        _mergeSource(sections, source, enabled: prefs[source.key] as bool?);
      }
    }, importApple: true);
  }

  Future<CalendarSnapshot> expandForDate(DateTime day) async {
    final probe = DateTime.utc(day.year, day.month, day.day, 12);
    final targets = calendars
        .where(
          (source) =>
              source.enabled &&
              (source.provider == 'apple' || hasLiveGoogle(source)) &&
              !_coversDate(source.key, probe),
        )
        .toList();
    if (targets.isEmpty) return savedEvents();

    final warnings = <String>[];
    final toPersist = <String, List<PackReadyCalendarEventStruct>>{};
    final persistRanges = <String, ({DateTime start, DateTime end})>{};

    for (var i = 0; i < targets.length; i += 3) {
      final batch = targets.sublist(
        i,
        i + 3 > targets.length ? targets.length : i + 3,
      );
      await Future.wait(
        batch.map((source) async {
          final adapter = source.provider == 'apple' ? _apple : _google;
          if (adapter == null) return;
          final persisted = _persistedRange(source.key);
          late final DateTime fetchStart;
          late final DateTime fetchEnd;
          if (persisted != null && probe.isBefore(persisted.start)) {
            fetchStart = probe.subtract(const Duration(days: 60));
            final gap = persisted.start.difference(probe).inDays;
            fetchEnd = gap <= 180
                ? persisted.start.add(const Duration(days: 1))
                : probe.add(const Duration(days: 60));
          } else if (persisted != null && probe.isAfter(persisted.end)) {
            fetchEnd = probe.add(const Duration(days: 90));
            final gap = probe.difference(persisted.end).inDays;
            fetchStart = gap <= 180
                ? persisted.end.subtract(const Duration(days: 1))
                : probe.subtract(const Duration(days: 30));
          } else {
            fetchStart = probe.subtract(const Duration(days: 60));
            fetchEnd = probe.add(const Duration(days: 90));
          }
          try {
            final read = await adapter.events(
              [source],
              rangeStart: fetchStart,
              rangeEnd: fetchEnd,
            );
            if (read.warning case final String message) {
              warnings.add(message);
              if (read.events.isEmpty) return;
            }
            if (!_sections.containsKey(source.key)) return;
            final slice = (start: fetchStart, end: fetchEnd);
            final extras = _extraEvents.putIfAbsent(source.key, () => {});
            extras.removeWhere((_, event) => _eventInRanges(event, [slice]));
            for (final event in read.events) {
              extras[event.id] = event;
            }
            _extraRanges.putIfAbsent(source.key, () => []).add(slice);

            if (persisted != null &&
                !fetchStart.isAfter(
                  persisted.end.add(const Duration(days: 1)),
                ) &&
                !fetchEnd.isBefore(
                  persisted.start.subtract(const Duration(days: 1)),
                )) {
              final nextStart = fetchStart.isBefore(persisted.start)
                  ? fetchStart
                  : persisted.start;
              final nextEnd =
                  fetchEnd.isAfter(persisted.end) ? fetchEnd : persisted.end;
              if (nextEnd.difference(nextStart).inDays <=
                  _maxPersistRangeDays) {
                toPersist[source.key] = _mergedEventsFor(source);
                persistRanges[source.key] = (start: nextStart, end: nextEnd);
              }
            }
          } on Exception {
            warnings.add('Could not load ${source.name} for this date.');
          }
        }),
      );
    }

    if (toPersist.isNotEmpty) {
      final err = await _persistWithFallback(
        toPersist,
        ranges: persistRanges,
        ignoreSizeFailure: true,
      );
      if (err == null) {
        for (final key in toPersist.keys) {
          final persisted = _persistedRange(key);
          final target = persistRanges[key];
          if (persisted != null &&
              target != null &&
              !persisted.start.isAfter(target.start) &&
              !persisted.end.isBefore(target.end)) {
            _extraRanges.remove(key);
            _extraEvents.remove(key);
          }
        }
      }
    }
    return savedEvents(warning: warnings.firstOrNull);
  }

  Future<String?> _persistWithFallback(
    Map<String, List<PackReadyCalendarEventStruct>> eventsByKey, {
    required Map<String, ({DateTime start, DateTime end})> ranges,
    bool ignoreSizeFailure = false,
  }) async {
    try {
      await _commitRefreshed(eventsByKey, ranges: ranges, includeNotes: true);
      return null;
    } on FormatException {
      try {
        await _commitRefreshed(
          eventsByKey,
          ranges: ranges,
          includeNotes: false,
        );
        return null;
      } on FormatException {
        try {
          await _commitRefreshed(
            eventsByKey,
            ranges: ranges,
            includeNotes: false,
            dropDisabledBlobs: true,
          );
          return null;
        } on FormatException catch (error) {
          return ignoreSizeFailure ? null : error.message;
        }
      }
    } on FirebaseException catch (failure) {
      return 'Could not save refreshed calendars (${failure.code}).';
    } on Exception {
      return 'Could not save refreshed calendars.';
    }
  }

  Future<CalendarSnapshot> refresh({
    bool includeHiddenGoogle = false,
    DateTime? focusDate,
  }) async {
    final refreshedEvents = <String, List<PackReadyCalendarEventStruct>>{};
    final warnings = <String>[];

    Future<void> refreshProvider(
      String provider,
      CalendarAdapter adapter,
    ) async {
      final targets = calendars.where((source) {
        if (source.provider != provider) return false;
        if (provider == 'google') {
          if (!_activeGoogleKeys.contains(source.key)) return false;
          return includeHiddenGoogle ||
              source.enabled ||
              !hasSavedEvents(source);
        }
        return source.enabled || !hasSavedEvents(source);
      }).toList();

      for (var i = 0; i < targets.length; i += 4) {
        final batch = targets.sublist(
          i,
          i + 4 > targets.length ? targets.length : i + 4,
        );
        await Future.wait(
          batch.map((source) async {
            try {
              final read = await adapter.events([source]);
              if (read.warning case final String message) {
                warnings.add(message);
                if (read.events.isEmpty) return;
              }
              refreshedEvents[source.key] = read.events;
            } on Exception {
              warnings.add('Could not refresh ${source.name}.');
            }
          }),
        );
      }
    }

    final google = _google;
    await Future.wait([
      if (google != null) refreshProvider('google', google),
      if (calendars.any((source) => source.provider == 'apple'))
        refreshProvider('apple', _apple),
    ]);

    if (refreshedEvents.isNotEmpty) {
      for (final key in refreshedEvents.keys) {
        _extraRanges.remove(key);
        _extraEvents.remove(key);
      }
      final nowUtc = DateTime.now().toUtc();
      final defaultRange = (
        start: nowUtc.subtract(const Duration(days: _defaultPastDays)),
        end: nowUtc.add(const Duration(days: _defaultFutureDays)),
      );
      final persistWarning = await _persistWithFallback(
        refreshedEvents,
        ranges: {for (final key in refreshedEvents.keys) key: defaultRange},
      );
      if (persistWarning != null) warnings.add(persistWarning);
    }

    if (focusDate != null && needsExpansionFor(focusDate)) {
      final expanded = await expandForDate(focusDate);
      if (expanded.warning != null) warnings.add(expanded.warning!);
    }

    final saved = savedEvents();
    final googleVisibleEvents =
        saved.events.where((event) => event.provider == 'google').length;
    final googleEnabledCount = calendars
        .where((source) => source.provider == 'google' && source.enabled)
        .length;
    final googleTotalCount =
        calendars.where((source) => source.provider == 'google').length;

    String? warning = warnings.firstOrNull;
    if (warning == null && google != null && googleVisibleEvents == 0) {
      warning = googleEnabledCount == 0
          ? 'Connected $googleTotalCount Google calendars, but none are selected. Open Calendars to turn them on.'
          : 'No events found in the selected Google calendars in the synced date range. Open Calendars to choose other calendars or switch Google accounts.';
    }
    return (events: saved.events, warning: warning, notice: saved.notice);
  }

  Future<void> _commitRefreshed(
    Map<String, List<PackReadyCalendarEventStruct>> refreshedEvents, {
    required Map<String, ({DateTime start, DateTime end})> ranges,
    required bool includeNotes,
    bool dropDisabledBlobs = false,
  }) async {
    final encoded = {
      for (final entry in refreshedEvents.entries)
        entry.key: _encodeEvents(entry.value, includeNotes: includeNotes),
    };
    await _editSections((sections, _) {
      final now = Timestamp.now();
      for (final entry in encoded.entries) {
        final section = sections[entry.key];
        final range = ranges[entry.key];
        if (section != null && range != null) {
          if (dropDisabledBlobs && section['enabled'] != true) {
            section.remove('events');
          } else {
            section['events'] = entry.value;
            section['syncedAt'] = now;
            section['syncVersion'] = _syncSchemaVersion;
            section['syncStart'] = Timestamp.fromDate(range.start);
            section['syncEnd'] = Timestamp.fromDate(range.end);
          }
        }
      }
      if (dropDisabledBlobs) {
        for (final section in sections.values) {
          if (section['enabled'] != true) section.remove('events');
        }
      }
    });
    if (kDebugMode) {
      final total = refreshedEvents.values.fold<int>(
        0,
        (totalCount, list) => totalCount + list.length,
      );
      debugPrint(
        'Calendar Firestore commit: ${encoded.length} refreshed calendars ($total events)',
      );
    }
  }
}

Future<List<PackReadyCalendarEventStruct>> loadPackReadyCalendarEvents(
  bool? sample,
) async {
  if (sample == true) return packReadyDemoCalendar();
  final adapter = await GoogleCalendarAdapter.connect();
  final sources = await adapter.sources();
  return (await adapter.events(
    sources.where((source) => source.enabled).toList(),
  ))
      .events;
}

String _ymdDate(DateTime day) => '${day.year.toString().padLeft(4, '0')}-'
    '${day.month.toString().padLeft(2, '0')}-'
    '${day.day.toString().padLeft(2, '0')}';

PackReadyCalendarEventStruct _demoEvent(
  DateTime day,
  String key,
  String title, {
  String? start,
  String? end,
  int days = 1,
  String? location,
  String? notes,
  String? series,
  String? repeats,
}) {
  final iso = _ymdDate(day);
  final endDate = DateTime(day.year, day.month, day.day + days);
  return PackReadyCalendarEventStruct(
    id: 'demo-$key-$iso',
    provider: 'demo',
    calendarId: 'demo',
    calendarName: 'Example Calendar',
    notes: notes,
    title: title,
    start: start == null ? iso : '${iso}T$start:00',
    end: end == null ? _ymdDate(endDate) : '${iso}T$end:00',
    allDay: start == null,
    location: location,
    seriesId: series,
    recurrence: repeats == null ? null : [repeats],
  );
}

final List<PackReadyCalendarEventStruct> _demoOneOffs = [
  _demoEvent(
    DateTime(2026, 11, 12),
    'dentist',
    'Dentist',
    start: '14:00',
    end: '15:00',
  ),
  _demoEvent(
    DateTime(2026, 11, 19),
    'coffee',
    'Coffee with Maya',
    start: '14:00',
    end: '15:00',
  ),
  _demoEvent(
    DateTime(2026, 11, 20),
    'cabin',
    'Weekend Vermont Cabin',
    days: 3,
  ),
  _demoEvent(
    DateTime(2026, 11, 20),
    'lunch',
    'Lunch with Sam',
    start: '11:30',
    end: '12:45',
    location: 'Downtown',
    notes: 'Bring a reusable water bottle and a takeout container.',
  ),
  _demoEvent(
    DateTime(2026, 11, 25),
    'thanksgiving',
    'Thanksgiving Visit',
    days: 4,
  ),
];

/// Resolves any Example Calendar event or series key across past, current,
/// and future dates for Home / My Activities titles.
String? demoEventTitleForKey(String key) {
  if (key == 'series:demo-squash' || key.startsWith('event:demo-squash-')) {
    return 'Squash / Gym';
  }
  if (key == 'series:demo-team' || key.startsWith('event:demo-team-')) {
    return 'Team Standup';
  }
  if (key == 'series:demo-trail' || key.startsWith('event:demo-trail-')) {
    return 'Trail Run Club';
  }
  for (final event in _demoOneOffs) {
    if (key == 'event:${event.id}') return event.title;
  }
  if (key == 'event:demo-dentist-2026-11-19') return 'Coffee with Maya';
  return null;
}

/// Real weekly recurring Example Calendar events for any past, current, or
/// future day (plus dated one-off example trips spanning that day).
List<PackReadyCalendarEventStruct> packReadyDemoCalendar([DateTime? day]) {
  List<PackReadyCalendarEventStruct> weeklyFor(DateTime d) {
    final normalized = DateTime(d.year, d.month, d.day);
    final weekday = normalized.weekday;
    return [
      if (weekday == DateTime.monday ||
          weekday == DateTime.wednesday ||
          weekday == DateTime.friday)
        _demoEvent(
          normalized,
          'squash',
          'Squash / Gym',
          start: '19:00',
          end: '21:00',
          series: 'demo-squash',
          repeats: 'RRULE:FREQ=WEEKLY;BYDAY=MO,WE,FR',
        ),
      if (weekday == DateTime.tuesday)
        _demoEvent(
          normalized,
          'team',
          'Team Standup',
          start: '10:00',
          end: '10:30',
          series: 'demo-team',
          repeats: 'RRULE:FREQ=WEEKLY;BYDAY=TU',
        ),
      if (weekday == DateTime.friday)
        _demoEvent(
          normalized,
          'trail',
          'Trail Run Club',
          start: '16:00',
          end: '17:30',
          series: 'demo-trail',
          repeats: 'RRULE:FREQ=WEEKLY;BYDAY=FR',
        ),
    ];
  }

  if (day != null) {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final nextDay = DateTime(day.year, day.month, day.day + 1);
    return [
      ...weeklyFor(startOfDay),
      for (final item in _demoOneOffs)
        if (DateTime.parse(item.start).toLocal().isBefore(nextDay) &&
            DateTime.parse(item.end).toLocal().isAfter(startOfDay))
          item,
    ];
  }

  final now = DateTime.now();
  final from = DateTime(now.year, now.month, now.day - 30);
  final to = DateTime(now.year, now.month, now.day + 180);
  final events = <PackReadyCalendarEventStruct>[..._demoOneOffs];
  for (var d = from; !d.isAfter(to); d = DateTime(d.year, d.month, d.day + 1)) {
    events.addAll(weeklyFor(d));
  }
  return events;
}
