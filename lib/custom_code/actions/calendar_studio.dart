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

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/foundation.dart' show kDebugMode;

import '/auth/firebase_auth/auth_util.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/custom_code/actions/connect_google_pack_ready_calendars.dart'
    show GoogleCalendarAdapter;
import '/custom_code/actions/generate_ai_editor_draft.dart'
    show
        CalendarAiSave,
        CalendarAiTarget,
        packReadyCalendarSource,
        prepareCalendarEventAiDraft;
import '/custom_code/actions/load_pack_ready_calendar_events.dart';
import '/custom_code/actions/save_packing_list.dart' show writePackingList;

const calendarDarkGreen = Color(0xffaada70);
const calendarDarkAmber = Color(0xfffac65d);
const calendarDarkTerracotta = Color(0xffe58a52);
const calendarDarkNeutral = Color(0xff848e86);

DateTime calendarDay(DateTime date, [int offset = 0]) =>
    DateTime(date.year, date.month, date.day + offset);

class CalendarEntry {
  CalendarEntry(this.event, {this.activityRef})
      : start = _parseBound(event.start, event.allDay),
        end = _normalizeEnd(
          _parseBound(event.start, event.allDay),
          _parseBound(event.end, event.allDay),
          event.allDay,
        );

  static DateTime _parseBound(String raw, bool allDay) {
    final parsed = DateTime.parse(raw);
    if (allDay) {
      final date = raw.length == 10 ? parsed : parsed.toUtc();
      return DateTime(date.year, date.month, date.day);
    }
    return parsed.toLocal();
  }

  static DateTime _normalizeEnd(DateTime start, DateTime end, bool allDay) {
    if (allDay && !end.isAfter(start)) return calendarDay(start, 1);
    return end;
  }

  final PackReadyCalendarEventStruct event;
  final DocumentReference? activityRef;
  final DateTime start;
  final DateTime end;
  bool get repeats => event.seriesId.isNotEmpty;
  bool get allDay => event.allDay;
  String get title => event.title;

  bool on(DateTime day) {
    final nextDay = calendarDay(day, 1);
    if (!end.isAfter(start)) {
      return !start.isBefore(day) && start.isBefore(nextDay);
    }
    return start.isBefore(nextDay) && end.isAfter(day);
  }

  String key(bool series) {
    final base =
        series && repeats ? 'series:${event.seriesId}' : 'event:${event.id}';
    return event.calendarId.isNotEmpty && event.provider != 'demo'
        ? '${event.calendarId}:$base'
        : base;
  }

  String get repeatLabel {
    const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const codes = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
    for (final rule in event.recurrence) {
      final days = RegExp(r'(?:^|;)BYDAY=([^;]+)').firstMatch(rule)?.group(1);
      if (days == null) continue;
      final names = [
        for (var i = 0; i < codes.length; i++)
          if (days.split(',').contains(codes[i])) labels[i],
      ];
      if (names.length == 1) return 'Repeats ${names.single} weekly';
      if (names.isNotEmpty) return 'Repeats ${names.join(', ')}';
    }
    return 'Repeating event';
  }

  String get dateLabel {
    if (!allDay) {
      final sameDay = calendarDay(start) == calendarDay(end);
      final samePeriod = sameDay && (start.hour < 12) == (end.hour < 12);
      final from = DateFormat(samePeriod ? 'h:mm' : 'h:mm a').format(start);
      final to = DateFormat(
        sameDay ? 'h:mm a' : 'EEE, MMM d h:mm a',
      ).format(end);
      return '${DateFormat('EEE, MMM d').format(start)} · $from–$to';
    }
    final first = DateFormat('MMM d').format(start);
    final last = calendarDay(end, -1);
    if (calendarDay(start) == last || last.isBefore(calendarDay(start))) {
      return '$first · All day';
    }
    return '$first–${last.month == start.month ? last.day : DateFormat('MMM d').format(last)}';
  }

  String get timeLabel => allDay
      ? dateLabel
      : '${DateFormat('HH:mm').format(start)}–${DateFormat('HH:mm').format(end)}';
}

typedef _Seed = ({
  String name,
  String activity,
  List<String> packed,
  List<String> unpacked,
});

_Seed? _demoList(CalendarEntry entry) {
  return switch (entry.title) {
    'Weekend Vermont Cabin' => (
        name: 'Cabin List',
        activity: 'Camping',
        packed: const [
          'Warm jacket',
          'Rain shell',
          'Hiking boots',
          'Trail socks',
          'Beanie',
          'Gloves',
          'Layers',
          'Toiletries',
          'Headlamp',
          'Phone charger',
          'Water bottle',
          'Trail snacks',
          'Map',
          'First aid kit',
        ],
        unpacked: const ['Food cooler', 'Coffee', 'Firewood', 'Cabin key'],
      ),
    'Trail Run Club' => (
        name: 'Run Kit',
        activity: 'Running',
        packed: const [
          'Trail shoes',
          'Running socks',
          'Running vest',
          'Headlamp',
          'Watch',
        ],
        unpacked: const ['Water flask', 'Energy gels'],
      ),
    'Squash / Gym' => (
        name: 'Squash Bag',
        activity: 'Gym',
        packed: const [
          'Racket',
          'Court shoes',
          'Squash balls',
          'Eye protection',
          'Towel',
          'Water bottle',
          'Gym clothes',
          'Lock',
        ],
        unpacked: const [],
      ),
    'Thanksgiving Visit' => (
        name: 'Holiday Bag',
        activity: 'Travel',
        packed: const ['Overnight bag', 'Sweater', 'Toiletries'],
        unpacked: const ['Dessert', 'Host gift'],
      ),
    _ => null,
  };
}

class CalendarPacking {
  CalendarPacking(this.record);
  final PackingListsRecord record;
  String get name => record.tripName;
  int get total => record.items.length;
  int get packed => record.items.where((item) => item.packed).length;
  bool get ready => packed > 0 && packed == total;
}

enum CalendarSessionSource { none, demo, live }

/// Owns the calendar state for the signed-in app session across tab routes,
/// backed directly by Firestore `/users/{uid}.calendarSections`.
class _CalendarSession extends ChangeNotifier {
  _CalendarSession() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user?.uid == _userId) return;
      _userId = user?.uid;
      _fallbackUser = null;
      _accountVersion++;
      _sync = null;
      _activeSync = null;
      _expandingSlices.clear();
      _restored = false;
      savedActivity = null;
      _busyCount = 0;
      clear();
      unawaited(GoogleCalendarAdapter.clearSession());
      if (hasListeners && user != null) unawaited(restoreVisibleCalendars());
    });
  }

  String? _userId =
      FirebaseAuth.instance.currentUser?.uid ?? currentUserReference?.id;
  DocumentReference? _fallbackUser;
  int _accountVersion = 0;
  CalendarSessionSource source = CalendarSessionSource.none;
  bool exampleVisible = false;
  int savedCalendarCount = 0;
  List<CalendarEntry> entries = const [];
  DateTime? selected;
  int _busyCount = 0;
  bool get loading => _busyCount > 0;
  bool _restored = false;
  String? error;
  String? notice;
  Future<CalendarSync>? _sync;
  CalendarSync? _activeSync;
  final Set<String> _expandingSlices = {};
  DocumentReference? savedActivity;

  ({DateTime start, DateTime end})? syncedRange;
  bool get hasLiveCalendars => savedCalendarCount > 0;
  bool needsGoogleReconnectFor(DateTime day) =>
      _activeSync?.hasUncoveredSavedGoogle(day) == true;

  DocumentReference? get activeUser {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null && uid.isNotEmpty) {
      return FirebaseFirestore.instance.collection('users').doc(uid);
    }
    return currentUserReference ?? _fallbackUser;
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    if (!_restored && !loading && error == null && activeUser != null) {
      scheduleMicrotask(() {
        if (!_restored && !loading && error == null && activeUser != null) {
          unawaited(restoreVisibleCalendars());
        }
      });
    }
  }

  void _startBusy() {
    _busyCount++;
    notifyListeners();
  }

  void _endBusy(int account) {
    if (account != _accountVersion) return;
    if (_busyCount > 0) _busyCount--;
    notifyListeners();
  }

  Future<void> restoreVisibleCalendars([DocumentReference? user]) async {
    if (user != null) {
      _fallbackUser = user;
      _userId ??= user.id;
    }
    if (!_restored && !loading && activeUser != null) {
      await load();
    }
  }

  Future<CalendarSync> calendars() async {
    final user = activeUser;
    if (user == null) {
      throw const FormatException('Sign in to connect calendars.');
    }
    return _sync ??= _restore(user);
  }

  Future<CalendarSync> _restore(DocumentReference user) async {
    final sync = CalendarSync(user);
    final account = _accountVersion;
    try {
      await sync.restore();
    } catch (failure) {
      if (account == _accountVersion) {
        _sync = null;
        _activeSync = null;
      }
      if (kDebugMode) debugPrint('Calendar Firestore restore failed: $failure');
      throw const FormatException('Could not load saved calendars. Try again.');
    }
    if (account == _accountVersion) _activeSync = sync;
    return sync;
  }

  void applySnapshot(
    CalendarSync sync,
    CalendarSnapshot snapshot, {
    bool revealEvents = false,
    bool preferGoogle = false,
  }) {
    final liveEnabled = sync.calendars.any((item) => item.enabled);
    exampleVisible = sync.example.enabled;
    savedCalendarCount = sync.calendars.length;
    syncedRange = sync.syncedRange;
    source = liveEnabled
        ? CalendarSessionSource.live
        : exampleVisible
            ? CalendarSessionSource.demo
            : CalendarSessionSource.none;
    selected ??= calendarDay(DateTime.now());
    entries = snapshot.events
        .where(
          (item) =>
              DateTime.tryParse(item.start) != null &&
              DateTime.tryParse(item.end) != null,
        )
        .map(CalendarEntry.new)
        .toList()
      ..sort((a, b) => a.start.compareTo(b.start));

    if (revealEvents) {
      final day = selected ?? calendarDay(DateTime.now());
      final pool = preferGoogle
          ? entries.where((entry) => entry.event.provider == 'google')
          : entries;
      if (!pool.any((entry) => entry.on(day))) {
        final upcoming =
            pool.where((entry) => !entry.start.isBefore(day)).firstOrNull;
        final opening = upcoming ?? pool.lastOrNull;
        if (opening != null) selected = calendarDay(opening.start);
      }
    }
    error = snapshot.warning;
    notice = snapshot.notice;
    notifyListeners();
  }

  void clear() {
    source = CalendarSessionSource.none;
    exampleVisible = false;
    savedCalendarCount = 0;
    syncedRange = null;
    entries = const [];
    selected = null;
    error = null;
    notice = null;
    notifyListeners();
  }

  void select(DateTime day) {
    selected = day;
    notifyListeners();
    unawaited(ensureDateCovered(day));
  }

  Future<void> ensureDateCovered([DateTime? target]) async {
    final day = target ?? selected;
    final sync = _activeSync;
    if (day == null || sync == null || !sync.needsExpansionFor(day)) return;
    final account = _accountVersion;
    final sliceKey = '$account:${day.year}-${day.month}';
    if (!_expandingSlices.add(sliceKey)) return;
    _startBusy();
    try {
      final expanded = await sync.expandForDate(day);
      if (account != _accountVersion) return;
      applySnapshot(sync, expanded);
    } catch (failure) {
      if (kDebugMode) debugPrint('Calendar range expand failed: $failure');
    } finally {
      _expandingSlices.remove(sliceKey);
      _endBusy(account);
    }
  }

  Future<void> selectStudioDay(DateTime day) async {
    selected = day;
    await ensureDateCovered(day);
  }

  void setError(String? message) {
    error = message;
    notifyListeners();
  }

  Future<void> load({bool forceRefresh = false}) async {
    if (loading && !forceRefresh) return;
    final opening = !_restored && selected == null;
    final account = _accountVersion;
    error = null;
    _startBusy();
    try {
      final sync = await calendars();
      if (account != _accountVersion) return;
      _restored = true;
      applySnapshot(sync, sync.savedEvents(), revealEvents: opening);
      if (sync.needsAppleImport) {
        unawaited(_importLegacyApple(sync, account));
      }
      if (forceRefresh ||
          sync.hasGoogle ||
          sync.calendars.any((s) => s.provider == 'apple')) {
        final dayBeforeRefresh = selected;
        final refreshed = await sync.refresh(
          includeHiddenGoogle: forceRefresh,
          focusDate: selected,
        );
        if (account != _accountVersion) return;
        applySnapshot(
          sync,
          refreshed,
          revealEvents: opening && selected == dayBeforeRefresh,
        );
      }
    } catch (failure) {
      if (account != _accountVersion) return;
      if (kDebugMode) debugPrint('Calendar load failed: $failure');
      error = switch (failure) {
        FormatException() => failure.message,
        TimeoutException() => 'Calendar refresh timed out. Try again.',
        _ => 'Could not refresh the selected calendars. Try again.',
      };
    } finally {
      _endBusy(account);
    }
  }

  Future<void> _importLegacyApple(CalendarSync sync, int account) async {
    final added = await sync.importLegacyApple();
    if (!added || account != _accountVersion) return;
    final refreshed = await sync.refresh(focusDate: selected);
    if (account != _accountVersion) return;
    applySnapshot(sync, refreshed, revealEvents: entries.isEmpty);
  }

  Future<void> connectGoogleAdapter(GoogleCalendarAdapter adapter) async {
    final account = _accountVersion;
    final targetDay = selected;
    error = null;
    _startBusy();
    try {
      final sync = await calendars();
      if (account != _accountVersion) return;
      _restored = true;
      final outcome = await sync.connectGoogle(adapter, focusDate: targetDay);
      if (account != _accountVersion) return;
      final preserveUserDate = targetDay != null &&
          targetDay != calendarDay(DateTime.now()) &&
          sync.savedEvents().events.any(
                (item) => CalendarEntry(item).on(targetDay),
              );
      applySnapshot(
        sync,
        sync.savedEvents(warning: outcome.warning),
        revealEvents: !preserveUserDate,
        preferGoogle: true,
      );
    } catch (failure) {
      if (account != _accountVersion) return;
      if (kDebugMode) debugPrint('Calendar Google connect failed: $failure');
      error = switch (failure) {
        FormatException() => failure.message,
        TimeoutException() => 'Google Calendar sync timed out. Try again.',
        _ => 'Could not sync Google Calendar. Try again.',
      };
    } finally {
      _endBusy(account);
    }
  }

  Future<void> setExampleEnabled(bool enabled) async {
    final user = activeUser;
    final account = _accountVersion;
    error = null;
    _startBusy();
    try {
      final sync = await calendars();
      if (account != _accountVersion) return;
      _restored = true;
      final turningOn = enabled && !sync.example.enabled;
      await sync.setEnabled(sync.example, enabled);
      if (account != _accountVersion) return;
      applySnapshot(sync, sync.savedEvents());
      if (turningOn && user != null) {
        await seedCalendarDemoLists(user);
      }
    } catch (failure) {
      if (account != _accountVersion) return;
      error = failure is FormatException
          ? failure.message
          : 'Could not update Example Calendar.';
    } finally {
      _endBusy(account);
    }
  }
}

final calendarSession = _CalendarSession();

Listenable get calendarActivityTitles => calendarSession;

DocumentReference? get lastCalendarActivity => calendarSession.savedActivity;

void ensureCalendarSessionLoaded([DocumentReference? user]) {
  unawaited(calendarSession.restoreVisibleCalendars(user));
}

void acknowledgeCalendarActivity(DocumentReference activity) {
  if (calendarSession.savedActivity == activity) {
    calendarSession.savedActivity = null;
  }
}

String _isoYmd(DateTime date) => '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

List<int> _recordWeekdays(PackingListsRecord record) {
  final raw = record.snapshotData['calendarWeekdays'];
  if (raw is! List) return const [];
  return [
    for (final value in raw)
      if (value is num && value.toInt() >= 1 && value.toInt() <= 7)
        value.toInt(),
  ];
}

Set<String> _recordExcludedDates(PackingListsRecord record) {
  final raw = record.snapshotData['calendarExcludedDates'];
  if (raw is! List) return const {};
  return {
    for (final value in raw)
      if (value is String && value.length == 10) value,
  };
}

bool calendarSeriesMatchesDate(PackingListsRecord record, DateTime start) {
  final excluded = _recordExcludedDates(record);
  if (excluded.contains(_isoYmd(start))) return false;
  final weekdays = _recordWeekdays(record);
  if (weekdays.isNotEmpty && !weekdays.contains(start.weekday)) return false;
  return true;
}

class PackReadyTimelineEntry {
  const PackReadyTimelineEntry({
    required this.record,
    required this.date,
    required this.id,
    this.eventTitle,
    this.allDay,
    this.location,
  });

  final PackingListsRecord record;
  final DateTime date;
  final String id;
  final String? eventTitle;
  final bool? allDay;
  final String? location;
}

bool _matchesCalendarSource(PackingListsRecord record, String provider) {
  final source = record.snapshotData['calendarSource'];
  if (source is! String || source.isEmpty) return true;
  return source == provider;
}

List<PackingListsRecord> calendarMatchedRecords(
  CalendarEntry entry,
  bool series,
  List<PackingListsRecord> records,
) {
  final key = entry.key(series);
  return [
    for (final record in records)
      if (record.snapshotData['calendarEventKey'] == key &&
          _matchesCalendarSource(record, entry.event.provider) &&
          (!series || calendarSeriesMatchesDate(record, entry.start)))
        record,
  ];
}

List<PackingListsRecord> calendarEventMatchedRecords(
  CalendarEntry entry,
  List<PackingListsRecord> records,
) {
  if (entry.activityRef != null) {
    return [
      for (final record in records)
        if (record.reference == entry.activityRef) record,
    ];
  }
  final occurrence = calendarMatchedRecords(entry, false, records);
  if (occurrence.isNotEmpty || !entry.repeats) return occurrence;
  return calendarMatchedRecords(entry, true, records);
}

List<CalendarEntry> _visibleCalendarEntries({
  Iterable<PackReadyCalendarEventStruct>? calendarEvents,
  bool? includeExampleCalendar,
  Iterable<PackingListsRecord>? records,
}) {
  final external = calendarEvents == null
      ? calendarSession.entries
      : calendarEvents
          .where(
            (item) =>
                DateTime.tryParse(item.start) != null &&
                DateTime.tryParse(item.end) != null,
          )
          .map(CalendarEntry.new);
  final showExample = includeExampleCalendar ?? calendarSession.exampleVisible;
  if (!showExample) return [...external];
  final demoById = <String, PackReadyCalendarEventStruct>{
    for (final ev in packReadyDemoCalendar()) ev.id: ev,
  };
  if (records != null) {
    final now = DateTime.now();
    final defaultStart = calendarDay(now, -30);
    final defaultEnd = calendarDay(now, 180);
    DateTime? extraStart;
    DateTime? extraEnd;
    for (final record in records) {
      if (record.snapshotData['calendarSource'] !=
          CalendarSessionSource.demo.name) {
        continue;
      }
      final stored = record.leaveDate?.toLocal();
      if (stored == null) continue;
      final d = calendarDay(stored);
      if (d.isBefore(defaultStart)) {
        final s = calendarDay(d, -7);
        if (extraStart == null || s.isBefore(extraStart)) extraStart = s;
      }
      final horizon = calendarDay(d, 180);
      if (horizon.isAfter(defaultEnd)) {
        if (extraEnd == null || horizon.isAfter(extraEnd)) extraEnd = horizon;
      }
    }
    if (extraStart != null) {
      for (var d = extraStart;
          d.isBefore(defaultStart);
          d = calendarDay(d, 1)) {
        for (final ev in packReadyDemoCalendar(d)) {
          demoById[ev.id] = ev;
        }
      }
    }
    if (extraEnd != null) {
      for (var d = calendarDay(defaultEnd, 1);
          !d.isAfter(extraEnd);
          d = calendarDay(d, 1)) {
        for (final ev in packReadyDemoCalendar(d)) {
          demoById[ev.id] = ev;
        }
      }
    }
  }
  return [...external, ...demoById.values.map(CalendarEntry.new)];
}

List<PackReadyTimelineEntry> packReadyTimelineEntries(
  List<PackingListsRecord> records, {
  Iterable<PackReadyCalendarEventStruct>? calendarEvents,
  bool? includeExampleCalendar,
}) {
  final visibleEvents = _visibleCalendarEntries(
    calendarEvents: calendarEvents,
    includeExampleCalendar: includeExampleCalendar,
    records: records,
  );
  final timeline = <PackReadyTimelineEntry>[];
  final matchedRefs = <DocumentReference>{};
  final seenIds = <String>{};

  for (final event in visibleEvents) {
    for (final record in calendarEventMatchedRecords(event, records)) {
      matchedRefs.add(record.reference);
      final id =
          '${record.reference.path}@${event.event.provider}:${event.event.calendarId}:${event.event.id}';
      if (!seenIds.add(id)) continue;
      timeline.add(
        PackReadyTimelineEntry(
          record: record,
          date: event.start,
          id: id,
          eventTitle: event.title.trim().isNotEmpty ? event.title : null,
          allDay: event.allDay,
          location:
              event.event.location.isNotEmpty ? event.event.location : null,
        ),
      );
    }
  }

  for (final record in records) {
    if (matchedRefs.contains(record.reference)) continue;
    final date = _effectiveCalendarActivityDate(record, entries: visibleEvents);
    if (date == null) continue;
    final id = record.reference.path;
    if (!seenIds.add(id)) continue;
    timeline.add(
      PackReadyTimelineEntry(
        record: record,
        date: date,
        id: id,
        eventTitle: _linkedCalendarActivityTitle(
          record,
          entries: visibleEvents,
        ),
      ),
    );
  }

  timeline.sort((a, b) {
    final cmp = a.date.compareTo(b.date);
    return cmp != 0 ? cmp : a.id.compareTo(b.id);
  });
  return timeline;
}

DateTime? effectiveCalendarActivityDate(PackingListsRecord activity) =>
    _effectiveCalendarActivityDate(activity);

DateTime? _effectiveCalendarActivityDate(
  PackingListsRecord activity, {
  Iterable<CalendarEntry>? entries,
}) {
  final stored = activity.leaveDate?.toLocal();
  if (stored == null) return null;
  final excluded = _recordExcludedDates(activity);
  final weekdays = _recordWeekdays(activity);
  if (excluded.isEmpty && weekdays.isEmpty) return stored;
  if (calendarSeriesMatchesDate(activity, stored)) return stored;

  final key = activity.snapshotData['calendarEventKey'];
  final source = activity.snapshotData['calendarSource'];
  if (key is String && key.isNotEmpty) {
    final today = calendarDay(DateTime.now());
    CalendarEntry? fallback;
    for (final entry in entries ?? _visibleCalendarEntries()) {
      if (entry.event.provider == source &&
          entry.repeats &&
          entry.key(true) == key &&
          calendarSeriesMatchesDate(activity, entry.start)) {
        fallback ??= entry;
        if (!entry.start.isBefore(today)) return entry.start;
      }
    }
    if (fallback != null) return fallback.start;
  }
  if (weekdays.isNotEmpty) {
    for (var offset = 1; offset <= 60; offset++) {
      final candidate = DateTime(
        stored.year,
        stored.month,
        stored.day + offset,
        stored.hour,
        stored.minute,
      );
      if (calendarSeriesMatchesDate(activity, candidate)) return candidate;
    }
  }
  return null;
}

String? linkedCalendarActivityTitle(PackingListsRecord activity) =>
    _linkedCalendarActivityTitle(activity);

String? _linkedCalendarActivityTitle(
  PackingListsRecord activity, {
  Iterable<CalendarEntry>? entries,
}) {
  final data = activity.snapshotData;
  final key = data['calendarEventKey'];
  if (key is! String || key.isEmpty) return null;
  final source = data['calendarSource'];
  if (source == CalendarSessionSource.demo.name) {
    final demoTitle = demoEventTitleForKey(key);
    if (demoTitle != null) return demoTitle;
  }

  for (final entry in entries ?? calendarSession.entries) {
    if (entry.event.provider == source &&
        entry.title.trim().isNotEmpty &&
        (key == entry.key(false) ||
            (entry.repeats && key == entry.key(true)))) {
      return entry.title;
    }
  }
  final saved = data['calendarEventTitle'];
  return saved is String && saved.trim().isNotEmpty ? saved : null;
}

String _seedId(String key) =>
    'calendar-demo-${base64Url.encode(utf8.encode(key))}';

Future<void> seedCalendarDemoLists(DocumentReference user) async {
  final demoEntries = packReadyDemoCalendar().map(CalendarEntry.new).toList();
  final templates = await calendarSavedTemplates(user);
  final examples = <String, CalendarEntry>{};
  final firstStarts = <String, DateTime>{};
  final now = DateTime.now();
  for (final entry in demoEntries) {
    if (_demoList(entry) == null) continue;
    final key = entry.key(entry.repeats);
    firstStarts.putIfAbsent(key, () => entry.start);
    final previous = examples[key];
    if (previous == null ||
        (previous.start.isBefore(now) && entry.start.isAfter(previous.start))) {
      examples[key] = entry;
    }
  }
  for (final entry in examples.values) {
    if (calendarSession.activeUser != user) return;
    final seed = _demoList(entry)!;
    final names = {...seed.packed, ...seed.unpacked};
    final matching = templates
        .where(
          (template) =>
              template.items.length >= (seed.unpacked.isEmpty ? 1 : 2) &&
              template.activity == seed.activity &&
              (template.name.toLowerCase() == seed.name.toLowerCase() ||
                  template.items
                          .where((item) => names.contains(item.name))
                          .length >=
                      2),
        )
        .firstOrNull;
    final items = matching?.items ??
        [
          for (final name in [...seed.packed, ...seed.unpacked])
            PackItemStruct(name: name),
        ];
    final fullyPacked = seed.unpacked.isEmpty;
    final checked = fullyPacked
        ? items.length
        : (items.length * seed.packed.length ~/ names.length).clamp(
            1,
            items.length - 1,
          );
    await createCalendarActivity(
      user,
      entry,
      entry.repeats,
      (
        name: matching?.name ?? seed.name,
        activity: matching?.activity ?? seed.activity,
        items: [
          for (var i = 0; i < items.length; i++)
            copyCalendarPackItem(items[i], packed: i < checked),
        ],
      ),
      'demo',
      id: _seedId(entry.key(entry.repeats)),
      previousLeaveDate: entry.repeats ? firstStarts[entry.key(true)] : null,
    );
  }
}

Future<List<ChecklistTemplatesRecord>> calendarSavedTemplates(
  DocumentReference user,
) async {
  final templates = await queryChecklistTemplatesRecordOnce(parent: user);
  return templates..sort((a, b) => a.name.compareTo(b.name));
}

PackItemStruct copyCalendarPackItem(
  PackItemStruct item, {
  bool packed = false,
}) =>
    PackItemStruct.fromMap({...item.toMap(), 'packed': packed});

enum PackReadyPackingStatus { packed, incomplete, unpacked, event }

bool _isExternalCalendarSource(Object? source) =>
    source == 'google' || source == 'apple' || source == 'demo';

bool isPackReadyOnlyActivity(PackingListsRecord record) {
  if (effectiveCalendarActivityDate(record) == null) return false;
  final data = record.snapshotData;
  final source = data['calendarSource'];
  final key = data['calendarEventKey'];
  if (_isExternalCalendarSource(source) && key is String && key.isNotEmpty) {
    return false;
  }
  if (source == 'demo') return false;
  return true;
}

PackReadyPackingStatus? packReadyPackingStatusForLists(
  Iterable<PackingListsRecord> lists, {
  bool hasEvents = false,
}) {
  final seen = <DocumentReference>{};
  var hasAnyList = false;
  var packed = 0;
  var total = 0;
  for (final record in lists) {
    if (!seen.add(record.reference)) continue;
    hasAnyList = true;
    total += record.items.length;
    packed += record.items.where((item) => item.packed).length;
  }
  if (!hasAnyList) return hasEvents ? PackReadyPackingStatus.event : null;
  if (total == 0) return PackReadyPackingStatus.event;
  if (packed >= total) return PackReadyPackingStatus.packed;
  if (packed == 0) return PackReadyPackingStatus.unpacked;
  return PackReadyPackingStatus.incomplete;
}

Color packReadyStatusColor(
  PackReadyPackingStatus status, {
  Brightness brightness = Brightness.dark,
}) {
  if (brightness == Brightness.light) {
    return switch (status) {
      PackReadyPackingStatus.packed => const Color(0xff3e7a28),
      PackReadyPackingStatus.incomplete => const Color(0xffc2720c),
      PackReadyPackingStatus.unpacked => const Color(0xffc25c38),
      PackReadyPackingStatus.event => const Color(0xff6b7870),
    };
  }
  return switch (status) {
    PackReadyPackingStatus.packed => calendarDarkGreen,
    PackReadyPackingStatus.incomplete => calendarDarkAmber,
    PackReadyPackingStatus.unpacked => calendarDarkTerracotta,
    PackReadyPackingStatus.event => calendarDarkNeutral,
  };
}

String packReadyStatusLabel(PackReadyPackingStatus status) => switch (status) {
      PackReadyPackingStatus.packed => 'Packed',
      PackReadyPackingStatus.incomplete => 'Incomplete',
      PackReadyPackingStatus.unpacked => 'Unpacked',
      PackReadyPackingStatus.event => 'Event',
    };

Future<DocumentReference> createCalendarActivity(
  DocumentReference user,
  CalendarEntry entry,
  bool series,
  CalendarPackingDraft draft,
  String source, {
  String? id,
  DateTime? previousLeaveDate,
}) async {
  final ref = PackingListsRecord.createDoc(user, id: id);
  final due = await writePackingList(
    ref,
    tripName: draft.name,
    activity: draft.activity,
    leaveDate: entry.start,
    endTime: entry.end,
    calendarAllDay: entry.allDay,
    location: entry.event.location,
    recurring: series,
    items: draft.items,
    completed:
        draft.items.isNotEmpty && draft.items.every((item) => item.packed),
    calendarEventKey: entry.key(series),
    calendarId: entry.event.calendarId,
    calendarEventId: entry.event.id,
    calendarEventTitle: entry.title,
    calendarSource: source,
    previousLeaveDate: previousLeaveDate,
  );
  if (due != null && calendarSession.activeUser == user) {
    triggerPushNotification(
      notificationTitle: draft.name,
      notificationText: 'Finish packing for your trip.',
      scheduledTime: due,
      notificationSound: 'default',
      userRefs: [user],
      initialPageName: 'PackingList',
      parameterData: {'listRef': ref},
    );
  }
  return ref;
}

typedef CalendarPackingDraft = ({
  String name,
  String activity,
  List<PackItemStruct> items
});
List<CalendarEntry> calendarEventsOn(
  DateTime day,
  List<PackingListsRecord> records,
) {
  final cutoff = calendarDay(day, 1);
  final external = <CalendarEntry>[
    ...calendarSession.entries.where((entry) => entry.on(day)),
    if (calendarSession.exampleVisible)
      ...packReadyDemoCalendar(day).map(CalendarEntry.new),
  ];
  final linkedRefs = <DocumentReference>{
    for (final entry in external)
      for (final record in calendarEventMatchedRecords(entry, records))
        record.reference,
  };
  final packReadyOnly = [
    for (final record in records)
      if (isPackReadyOnlyActivity(record) &&
          !linkedRefs.contains(record.reference))
        _nativeEvent(record),
  ].where((entry) => entry.start.isBefore(cutoff) && entry.on(day));
  return [...external, ...packReadyOnly]
    ..sort((a, b) => a.start.compareTo(b.start));
}

CalendarEntry _nativeEvent(PackingListsRecord record) {
  final start =
      effectiveCalendarActivityDate(record) ?? record.leaveDate!.toLocal();
  final end = calendarActivityEnd(record);
  final location = record.snapshotData['location'];
  final dateOnly = end == null &&
      start.hour == 0 &&
      start.minute == 0 &&
      start.second == 0 &&
      start.millisecond == 0;
  final allDay = record.snapshotData['calendarAllDay'] == true || dateOnly;
  final effectiveEnd = end ??
      (allDay ? calendarDay(start, 1) : start.add(const Duration(hours: 1)));
  String bound(DateTime value) =>
      allDay ? DateFormat('yyyy-MM-dd').format(value) : value.toIso8601String();
  return CalendarEntry(
    PackReadyCalendarEventStruct(
      id: record.reference.id,
      title: record.tripName,
      provider: packReadyCalendarSource,
      location: location is String ? location : null,
      start: bound(start),
      end: bound(effectiveEnd),
      allDay: allDay,
    ),
    activityRef: record.reference,
  );
}

DateTime? calendarActivityEnd(PackingListsRecord record) {
  final value = record.snapshotData['endTime'];
  if (value is Timestamp) return value.toDate().toLocal();
  return value is DateTime ? value.toLocal() : null;
}

/// Runs the commands from the native Calendar page and projects a display model.
Future<CalendarStudioViewStruct> calendarStudio(
  BuildContext context,
  String? operation,
  String? selectedDate,
  bool? monthMode,
  String? value,
  String? detail,
  String? color,
) async {
  final isMonth = monthMode == true;
  final op = operation ?? 'load';
  final session = calendarSession;
  final today = calendarDay(DateTime.now());
  var day = DateTime.tryParse(selectedDate ?? '') ?? session.selected ?? today;
  final user = session.activeUser;
  String? failure;
  try {
    switch (op) {
      case 'load':
        unawaited(GoogleCalendarAdapter.prewarm().catchError((Object _) {}));
        await session.restoreVisibleCalendars();
        day = session.selected ?? day;
      case 'today':
        day = today;
      case 'date':
        day = DateTime.tryParse(value ?? '') ?? day;
      case 'previous':
      case 'next':
        final step = op == 'previous' ? -1 : 1;
        if (isMonth) {
          final start = DateTime(day.year, day.month + step);
          final lastDay = DateTime(start.year, start.month + 1, 0).day;
          day = DateTime(
            start.year,
            start.month,
            day.day.clamp(1, lastDay).toInt(),
          );
        } else {
          day = calendarDay(day, 7 * step);
        }
      case 'refresh':
        if (user != null) await session.load(forceRefresh: true);
      case 'google':
        if (user == null) {
          throw const FormatException('Sign in to connect calendars.');
        }
        // OAuth begins on the original tap, before awaiting any other work.
        final adapter = await GoogleCalendarAdapter.connect();
        if (session.activeUser == user) {
          await session.connectGoogleAdapter(adapter);
          day = session.selected ?? day;
        }
      case 'apple':
        if ((value ?? '').trim().isEmpty) {
          throw const FormatException('Enter an Apple Calendar public link.');
        }
        final sync = await session.calendars();
        final warning = await sync.addApple(
          value!.trim(),
          (detail ?? '').trim(),
          (color ?? '').trim().isEmpty ? '#75A8DF' : color!.trim(),
        );
        if (session.activeUser == user) {
          session.applySnapshot(
            sync,
            sync.savedEvents(warning: warning),
            revealEvents: true,
          );
          day = session.selected ?? day;
        }
      case 'toggle':
        final sync = await session.calendars();
        final source = [
          sync.example,
          ...sync.calendars,
        ].where((source) => source.key == value).firstOrNull;
        if (source != null) {
          if (source.provider == 'demo') {
            await session.setExampleEnabled(!source.enabled);
          } else {
            await sync.setEnabled(source, !source.enabled);
            final shouldRefresh = !source.enabled &&
                !sync.hasSavedEvents(source) &&
                (source.provider == 'apple' || sync.hasLiveGoogle(source));
            final snapshot = shouldRefresh
                ? await sync.refresh(focusDate: day)
                : sync.savedEvents();
            if (session.activeUser == user)
              session.applySnapshot(sync, snapshot);
          }
        }
      case 'disconnect':
        final sync = await session.calendars();
        final sources = sync.calendars
            .where((source) => value == '' || source.key == value)
            .toList();
        if (sources.isNotEmpty && context.mounted) {
          final changed = await sync.disconnect(sources, (sources, count) {
            if (!context.mounted) return Future.value();
            return showDialog<CalendarDisconnectChoice>(
              context: context,
              builder: (dialog) => AlertDialog(
                title: Text(
                  sources.length == 1
                      ? 'Disconnect ${sources.single.name}?'
                      : 'Disconnect ${sources.length} calendars?',
                ),
                content: Text(
                  count == 0
                      ? 'Saved events from these calendars will be removed.'
                      : 'Keep the $count linked activities on their dates, or remove them.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialog),
                    child: const Text('Cancel'),
                  ),
                  if (count > 0)
                    TextButton(
                      onPressed: () => Navigator.pop(
                        dialog,
                        CalendarDisconnectChoice.remove,
                      ),
                      child: const Text('Remove linked activities'),
                    ),
                  FilledButton(
                    onPressed: () => Navigator.pop(
                      dialog,
                      CalendarDisconnectChoice.keep,
                    ),
                    child: Text(
                      count == 0 ? 'Disconnect' : 'Keep activities',
                    ),
                  ),
                ],
              ),
            );
          });
          if (changed && session.activeUser == user) {
            session.applySnapshot(sync, sync.savedEvents());
          }
        }
      case 'open':
        if (user != null &&
            value != null &&
            value.startsWith('${user.path}/packingLists/') &&
            value.split('/').length == 4 &&
            context.mounted) {
          await context.pushNamed(
            'PackingList',
            queryParameters: {
              'listRef': serializeParam(
                FirebaseFirestore.instance.doc(value),
                ParamType.DocumentReference,
              )!,
            },
          );
        }
      case 'draft':
      case 'manual':
      case 'series':
        if (user == null) {
          throw const FormatException('Sign in to create a packing list.');
        }
        if (context.mounted) {
          day = await _openCalendarStudioEditor(
                context,
                day,
                value,
                user,
                op,
              ) ??
              day;
        }
    }
    if (session.activeUser == user) {
      await session.selectStudioDay(day);
    }
  } catch (error) {
    if (kDebugMode) debugPrint('Calendar $op failed: ${error.runtimeType}');
    failure = error is FormatException
        ? error.message
        : 'Could not update the calendar. Try again.';
  }

  if (session.activeUser != user) {
    return _studioView(today, isMonth, const [], failure);
  }
  try {
    final records = user == null
        ? <PackingListsRecord>[]
        : await queryPackingListsRecordOnce(parent: user);
    if (session.activeUser == user) {
      return _studioView(day, isMonth, records, failure);
    }
    return _studioView(today, isMonth, const [], null);
  } catch (_) {
    return _studioView(
      day,
      isMonth,
      const [],
      failure ?? 'Could not load packing lists. Try refreshing.',
    );
  }
}

Future<DateTime?> _openCalendarStudioEditor(
  BuildContext context,
  DateTime day,
  String? eventKey,
  DocumentReference user,
  String operation,
) async {
  final session = calendarSession;
  final source = session.source;
  final entry = eventKey == null || eventKey.isEmpty
      ? null
      : calendarEventsOn(
          day,
          const [],
        ).where((entry) => entry.key(false) == eventKey).firstOrNull;
  if (eventKey?.isNotEmpty == true && entry == null) {
    throw const FormatException('This event is no longer available.');
  }
  final target = entry == null
      ? CalendarAiTarget(day: day)
      : CalendarAiTarget(
          day: calendarDay(entry.start),
          eventId: entry.event.id,
          title: entry.title,
          start: entry.start,
          end: entry.end,
          source: entry.event.provider,
          notes: entry.event.notes,
          eventKey: entry.key(operation == 'series'),
          calendarId: entry.event.calendarId,
          calendarName: entry.event.calendarName,
          location: entry.event.location,
          allDay: entry.allDay,
        );

  AiEditorDraftStruct? prefill;
  if (entry != null) {
    if (operation == 'draft') {
      prefill = await prepareCalendarEventAiDraft(context, target);
      if (prefill == null) return null;
    } else {
      prefill = AiEditorDraftStruct(title: entry.title);
    }
  }
  if (!context.mounted ||
      session.activeUser != user ||
      session.source != source) {
    return null;
  }
  final saved = await context.pushNamed<CalendarAiSave>(
    'TemplateEditor',
    extra: {
      'startItems': <PackItemStruct>[],
      'startActivity': 'Custom',
      'calendarAi': {'target': target.toMap(), 'draft': prefill?.toMap()},
      'calendarPrompt': entry == null,
      'calendarActivityMode': true,
    },
  );
  if (saved == null || session.activeUser != user) return null;
  session.savedActivity = saved.activity;
  return calendarDay(saved.date);
}

CalendarStudioViewStruct _studioView(
  DateTime day,
  bool monthMode,
  List<PackingListsRecord> records,
  String? failure,
) {
  final session = calendarSession;
  final today = calendarDay(DateTime.now());
  final monthStart = DateTime(day.year, day.month);
  final first = monthMode
      ? calendarDay(monthStart, -(monthStart.weekday % 7))
      : calendarDay(day, -(day.weekday % 7));
  final daysInMonth = DateTime(day.year, day.month + 1, 0).day;
  final rowCount =
      monthMode ? (monthStart.weekday % 7 + daysInMonth + 6) ~/ 7 : 1;
  CalendarStudioDayStruct cell(DateTime date) {
    final events = calendarEventsOn(date, records);
    final linked = events.expand(
      (entry) => calendarEventMatchedRecords(entry, records),
    );
    return CalendarStudioDayStruct(
      date: _isoYmd(date),
      label: '${date.day}',
      weekday: DateFormat('EEE').format(date).toUpperCase(),
      selected: date == day,
      today: date == today,
      outside: monthMode && date.month != day.month,
      standalone: events.any((entry) => entry.activityRef != null),
      status: packReadyPackingStatusForLists(
        linked,
        hasEvents: events.isNotEmpty,
      )?.name,
    );
  }

  final events = calendarEventsOn(day, records);
  final cards = events.map((entry) {
    final linked = calendarEventMatchedRecords(
      entry,
      records,
    ).map(CalendarPacking.new).toList();
    final packed = linked.fold(0, (sum, list) => sum + list.packed);
    final total = linked.fold(0, (sum, list) => sum + list.total);
    final status = packReadyPackingStatusForLists(
      linked.map((list) => list.record),
      hasEvents: true,
    )!;
    final standalone = entry.activityRef != null;
    return CalendarStudioCardStruct(
      title: entry.title,
      eventKey: entry.key(false),
      standalone: standalone,
      path: entry.activityRef?.path,
      status: status.name,
      needsPacking: packed < total,
      showProgress: linked.isNotEmpty,
      progress: '$packed/$total',
      subtitle: [
        if (standalone) 'PackReady',
        if (linked.isNotEmpty && !standalone) linked.first.name,
        entry.timeLabel,
        if ((linked.isEmpty || standalone) && entry.event.location.isNotEmpty)
          entry.event.location,
      ].join(' · '),
      source: entry.event.calendarName.isEmpty
          ? switch (entry.event.provider) {
              'google' => 'Google Calendar',
              'apple' => 'Apple Calendar',
              'demo' => 'Example Calendar',
              _ => 'PackReady',
            }
          : entry.event.calendarName,
      dateLabel: entry.dateLabel,
      location: entry.event.location,
      notes: entry.event.notes,
      repeats: entry.repeats,
      repeatLabel: entry.repeats ? entry.repeatLabel : '',
      lists: linked
          .map(
            (list) => CalendarStudioListStruct(
              title: list.name,
              path: list.record.reference.path,
              progress: '${list.packed}/${list.total}',
            ),
          )
          .toList(),
    );
  }).toList();
  final timeline = _calendarTimeline(day, monthMode, events, cards);
  final sync = session._activeSync;
  final sources =
      sync == null ? <CalendarSource>[] : [sync.example, ...sync.calendars];
  return CalendarStudioViewStruct(
    date: _isoYmd(day),
    monthTitle: DateFormat(
      monthMode ? 'MMMM yyyy' : 'MMM yyyy',
    ).format(day).toUpperCase(),
    dayTitle: DateFormat('EEE, MMM d').format(day).toUpperCase(),
    summary: '${cards.length} ${cards.length == 1 ? 'event' : 'events'} · '
        '${cards.where((card) => card.needsPacking).length} need packing',
    weeks: [
      for (var row = 0; row < rowCount; row++)
        CalendarStudioWeekStruct(
          days: [
            for (var col = 0; col < 7; col++)
              cell(calendarDay(first, row * 7 + col)),
          ],
        ),
    ],
    bands: timeline.bands,
    hourLabels: timeline.hours,
    hourStep: timeline.step,
    hourInset: timeline.hourInset,
    nowOffset: timeline.nowOffset,
    nowLabel: timeline.nowLabel,
    hasEvents: cards.isNotEmpty,
    sources: [
      for (final source in sources)
        CalendarStudioSourceStruct(
          sourceKey: source.key,
          name: source.name,
          provider: switch (source.provider) {
            'google' => sync!.hasLiveGoogle(source)
                ? 'Google · synced'
                : sync.hasSavedEvents(source)
                    ? 'Google · saved in PackReady'
                    : 'Google · reconnect to load',
            'apple' => 'Apple',
            _ => 'Built-in',
          },
          enabled: source.enabled,
          removable: source.provider != 'demo',
        ),
    ],
    live: session.hasLiveCalendars,
    connected: session.source != CalendarSessionSource.none,
    reconnect: session.needsGoogleReconnectFor(day) ||
        session.error == googleCalendarReconnectNotice ||
        session.notice != null,
    message: failure ??
        session.error ??
        session.notice ??
        (session.needsGoogleReconnectFor(day)
            ? 'Reconnect Google Calendar to load this date.'
            : ''),
  );
}

/// Positions native timeline cards by local clock time. Each band is a run of
/// overlapping cards. The native Row gives its lanes equal available widths.
({
  List<CalendarStudioBandStruct> bands,
  List<String> hours,
  double step,
  double hourInset,
  double nowOffset,
  String nowLabel,
}) _calendarTimeline(
  DateTime day,
  bool monthMode,
  List<CalendarEntry> events,
  List<CalendarStudioCardStruct> cards,
) {
  final step = monthMode ? 38.0 : 41.5;
  final clock = DateTime.now();
  final tomorrow = calendarDay(day, 1);
  final minuteNow =
      calendarDay(clock) == day ? clock.hour * 60 + clock.minute : null;
  final slots = <({int start, int end, CalendarStudioCardStruct card})>[];
  final allDay = <CalendarStudioCardStruct>[];
  var firstHour = 9;
  var lastHour = 21;
  for (var i = 0; i < events.length; i++) {
    final entry = events[i];
    final card = cards[i];
    if (entry.allDay) {
      card.allDay = true;
      card.gap = allDay.isEmpty ? 0 : 6;
      card.height = 46;
      allDay.add(card);
      continue;
    }
    final start = entry.start.isBefore(day)
        ? 0
        : entry.start.hour * 60 + entry.start.minute;
    final end = entry.end.isBefore(tomorrow)
        ? entry.end.hour * 60 + entry.end.minute
        : 1440;
    final stop = end > start ? end : start + 1;
    if (start ~/ 60 < firstHour) firstHour = start ~/ 60;
    if ((stop + 59) ~/ 60 > lastHour) lastHour = (stop + 59) ~/ 60;
    slots.add((start: start, end: stop, card: card));
  }
  if (minuteNow != null) {
    final hour = minuteNow ~/ 60;
    if (hour < firstHour) firstHour = hour;
    if (hour >= lastHour) lastHour = hour + 1;
  }

  final allDayHeight = allDay.isEmpty ? 0.0 : allDay.length * 52.0 + 5;
  double at(int minute) => allDayHeight + (minute / 60 - firstHour) * step + 9;
  final bands = <CalendarStudioBandStruct>[
    if (allDay.isNotEmpty)
      CalendarStudioBandStruct(
        gap: 0,
        allDay: true,
        lanes: [CalendarStudioLaneStruct(cards: allDay)],
      ),
  ];
  final lanes = <List<CalendarStudioCardStruct>>[];
  final laneEnds = <double>[];
  var previousEnd = allDay.isEmpty ? 0.0 : allDay.length * 52.0 - 6;
  var bandStart = 0.0;
  var bandEnd = 0.0;
  void finishBand() {
    if (lanes.isEmpty) return;
    bands.add(
      CalendarStudioBandStruct(
        gap: bandStart - previousEnd,
        lanes: lanes
            .map((cards) => CalendarStudioLaneStruct(cards: cards))
            .toList(),
      ),
    );
    previousEnd = bandEnd;
    lanes.clear();
    laneEnds.clear();
  }

  for (final slot in slots) {
    final top = at(slot.start);
    final height =
        (at(slot.end) - top - 2).clamp(25.0, double.infinity).toDouble();
    if (lanes.isNotEmpty && top >= bandEnd) finishBand();
    if (lanes.isEmpty) {
      bandStart = top;
      bandEnd = top;
    }
    var lane = laneEnds.indexWhere((end) => end <= top);
    if (lane < 0) {
      lane = lanes.length;
      lanes.add([]);
      laneEnds.add(bandStart);
    }
    slot.card.gap = top - laneEnds[lane];
    slot.card.height = height;
    lanes[lane].add(slot.card);
    laneEnds[lane] = top + height;
    if (laneEnds[lane] > bandEnd) bandEnd = laneEnds[lane];
  }
  finishBand();

  return (
    bands: bands,
    hours: [
      for (var hour = firstHour; hour <= lastHour; hour++)
        DateFormat('h a').format(DateTime(day.year, day.month, day.day, hour)),
    ],
    step: step,
    hourInset: allDayHeight + 2,
    nowOffset: minuteNow == null ? 0 : at(minuteNow) - 6,
    nowLabel: minuteNow == null ? '' : DateFormat('h:mm').format(clock),
  );
}
