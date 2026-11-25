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

import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:go_router/go_router.dart' show GoRouterState;
import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/save_packing_list.dart';
import '/index.dart' show PackingListWidget, TemplatesWidget;

String _clip(String text, int limit) =>
    text.length <= limit ? text : text.substring(0, limit);

const _aiUnavailable = "AI isn't connected right now. Try again in a moment.";

class _Source {
  _Source(
    this.id,
    this.kind,
    this.name,
    this.items, {
    this.activity = '',
    this.location,
    this.date,
  });

  final String id, kind, name, activity;
  final String? location;
  final DateTime? date;
  final List<PackItemStruct> items;

  Map<String, Object> toJson() => {
        'id': id,
        'kind': kind,
        'name': _clip(name, 100),
        if (activity.isNotEmpty) 'activity': _clip(activity, 40),
        if (location?.isNotEmpty ?? false) 'location': _clip(location!, 100),
        if (date != null) 'date': date!.toIso8601String().split('T').first,
        'items': items
            .where((item) => item.name.trim().isNotEmpty)
            .take(16)
            .map((item) => _clip(item.name, 70))
            .toList(),
      };
}

List<PackItemStruct> _items(Iterable<String> names) =>
    names.map((name) => PackItemStruct(name: name, packed: false)).toList();

List<_Source> _samples() => [
      _Source(
        't0',
        'template',
        'Dog',
        _items(['Ruffwear leash', 'Collapsible dog bowl', 'Dog food tub']),
      ),
      _Source(
        't1',
        'template',
        'Cabin Weekend',
        _items(['Green duffel', 'Cabin key pouch', 'Wool socks']),
      ),
      _Source(
        'a0',
        'past activity',
        'Vermont Gym',
        _items(['Lifting shoes', 'Wrist wraps']),
      ),
    ];

Future<List<_Source>> _loadSources(DocumentReference user) async {
  final results = await Future.wait([
    ChecklistTemplatesRecord.collection(user).limit(30).get(),
    PackingListsRecord.collection(user)
        .where('leaveDate', isLessThanOrEqualTo: DateTime.now())
        .orderBy('leaveDate', descending: true)
        .limit(12)
        .get(),
  ]).timeout(const Duration(seconds: 8));
  final templates = results[0].docs;
  final activities = results[1].docs;
  return [
    for (final row in templates)
      _Source(
        'template/${row.id}',
        'template',
        row.data()['name'] as String? ?? 'Untitled template',
        ChecklistTemplatesRecord.fromSnapshot(row).items,
        activity: row.data()['activity'] as String? ?? '',
        location: row.data()['location'] is String
            ? row.data()['location'] as String
            : null,
        date: ((row.data()['updatedTime'] ?? row.data()['createdTime'])
                as Timestamp?)
            ?.toDate(),
      ),
    for (final row in activities)
      _Source(
        'activity/${row.id}',
        'past activity',
        row.data()['tripName'] as String? ?? 'Untitled activity',
        PackingListsRecord.fromSnapshot(row).items,
        activity: row.data()['activity'] as String? ?? '',
        location: row.data()['location'] is String
            ? row.data()['location'] as String
            : null,
        date: (row.data()['leaveDate'] as Timestamp?)?.toDate(),
      ),
  ]
      .where(
        (source) =>
            source.kind == 'template' ||
            source.items.any((item) => item.name.trim().isNotEmpty),
      )
      .toList();
}

Set<String> _words(String text) {
  const aliases = {
    'dogs': 'dog',
    'puppy': 'dog',
    'pets': 'dog',
    'workout': 'gym',
    'fitness': 'gym',
    'camp': 'camping',
    'hike': 'hiking',
    'rainy': 'rain',
    'raining': 'rain',
    'showers': 'rain',
    'skiing': 'ski',
  };
  const ignored = {
    'the',
    'and',
    'with',
    'for',
    'day',
    'days',
    'trip',
    'kit',
    'pack',
    'packing',
    'list',
    'checklist',
    'template',
    'custom',
    'my',
  };
  return RegExp(r'[a-z][a-z0-9]+')
      .allMatches(text.toLowerCase())
      .map((match) => match.group(0)!)
      .map((word) => aliases[word] ?? word)
      .where((word) => !ignored.contains(word))
      .toSet();
}

Map<String, dynamic> _localDraft(String prompt, List<_Source> sources) {
  final words = _words(prompt);
  final ranked = [
    for (final source in sources)
      (
        source: source,
        score: 3 *
                words
                    .intersection(_words('${source.name} ${source.activity}'))
                    .length +
            words.intersection(_words(source.location ?? '')).length,
      ),
  ]..sort((a, b) => b.score.compareTo(a.score));
  final extras = [
    if (words.contains('rain')) ...['Packable rain shell', 'Dry bag'],
    if (words.contains('dog')) 'Dog towel',
    if (words.contains('gym')) 'Gym lock',
    if (words.contains('ski') || words.contains('snow')) 'Hand warmers',
    if (words.contains('hiking')) 'Trail map',
    if (words.contains('beach') || words.contains('sunny')) 'Sunscreen',
    if (words.contains('camping') || words.contains('cabin')) 'Headlamp',
    if (words.contains('flight')) 'Luggage tag',
  ];
  return {
    'title': prompt
        .split(RegExp(r',|\bwith\b|\band\b', caseSensitive: false))
        .first
        .trim(),
    'sourceIds': ranked
        .where((entry) => entry.score >= 3)
        .take(4)
        .map((entry) => entry.source.id)
        .toList(),
    'extras': extras.isEmpty && ranked.every((entry) => entry.score < 3)
        ? ['Water bottle', 'Phone charger']
        : extras,
  };
}

final _draftSessions = Expando<AiDraftEditorSession>();

const packReadyCalendarSource = 'packready';

typedef CalendarAiSave = ({DocumentReference activity, DateTime date});

class CalendarAiTarget {
  const CalendarAiTarget({
    required this.day,
    this.eventId,
    this.eventKey,
    this.calendarId,
    this.title = '',
    this.start,
    this.end,
    this.source = packReadyCalendarSource,
    this.notes = '',
    this.location = '',
    this.calendarName = '',
    this.allDay = false,
  });

  final DateTime day;
  final String? eventId, eventKey, calendarId;
  final String title, source, notes, location, calendarName;
  final DateTime? start, end;
  final bool allDay;

  String? get key => eventId == null ? null : eventKey ?? 'event:$eventId';

  Map<String, dynamic> toMap() => {
        'day': _ymd(day),
        'eventId': eventId,
        'eventKey': eventKey,
        'calendarId': calendarId,
        'title': title,
        'start': start?.toUtc().toIso8601String(),
        'end': end?.toUtc().toIso8601String(),
        'source': source,
        'notes': notes,
        'location': location,
        'calendarName': calendarName,
        'allDay': allDay,
      };

  static CalendarAiTarget? fromMap(Map input) {
    final day = _isoDay(input['day']);
    final id = input['eventId'];
    final start = DateTime.tryParse(input['start'] as String? ?? '')?.toLocal();
    final end = DateTime.tryParse(input['end'] as String? ?? '')?.toLocal();
    if (day == null ||
        (id != null && (id is! String || start == null || end == null)))
      return null;
    return CalendarAiTarget(
      day: day,
      eventId: id as String?,
      eventKey: input['eventKey'] as String?,
      calendarId: input['calendarId'] as String?,
      start: start,
      end: end,
      title: input['title'] as String? ?? '',
      source: input['source'] as String? ?? packReadyCalendarSource,
      notes: input['notes'] as String? ?? '',
      location: input['location'] as String? ?? '',
      calendarName: input['calendarName'] as String? ?? '',
      allDay: input['allDay'] == true,
    );
  }

  String eventPrompt(String tweak) {
    final schedule =
        '${allDay ? 'All day, ' : ''}${start!.toIso8601String().substring(0, 16)} to '
        '${end!.toIso8601String().substring(0, 16)}';
    return _clip(
      'One event: ${_clip(title, 58)}. $schedule.'
      '${calendarName.isEmpty || source == 'demo' ? '' : ' Calendar: ${_clip(calendarName, 28)}.'}'
      '${location.isEmpty ? '' : ' Location: ${_clip(location, 38)}.'}'
      '${tweak.isEmpty ? '' : ' Preferences: $tweak.'}'
      '${notes.isEmpty ? '' : ' Notes: ${_clip(notes, tweak.isEmpty ? 68 : 44)}.'}',
      280,
    );
  }
}

typedef _AiResult = ({
  AiEditorDraftStruct values,
  AiDraftEditorSession session
});

Future<AiEditorDraftStruct?> prepareCalendarEventAiDraft(
  BuildContext context,
  CalendarAiTarget target,
) async {
  final result = await _requestDraft(context, '', false, true, target);
  return result?.values;
}

AiEditorDraftStruct initializeCalendarAiDraft(
  BuildContext context,
  Object? input,
) {
  if (input is! Map || input['target'] is! Map) return AiEditorDraftStruct();
  final target = CalendarAiTarget.fromMap(input['target'] as Map);
  final page = ModalRoute.of(context);
  if (page != null && target != null) {
    _draftSessions[page] = AiDraftEditorSession(
      date: target.start ?? target.day,
      repeat: null,
      scheduleMissing: false,
      sample: false,
      calendar: target,
    );
    return AiEditorDraftStruct.maybeFromMap(input['draft']) ??
        AiEditorDraftStruct();
  }
  return AiEditorDraftStruct();
}

const packReadyChecklistDraftSessionKey = 'packReadyChecklistDraftSession';

AiDraftEditorSession? currentAiEditorDraft(BuildContext context) {
  final page = ModalRoute.of(context);
  if (page == null) return null;
  final saved = _draftSessions[page];
  if (saved != null) return saved;
  final extra = GoRouterState.of(context).extra;
  final transferred =
      extra is Map ? extra[packReadyChecklistDraftSessionKey] : null;
  return transferred is AiDraftEditorSession ? transferred : null;
}

Future<AiEditorDraftStruct> generateAiEditorDraft(
  BuildContext context,
  String? rawPrompt,
  bool? useSample,
  bool? enableLiveAi,
) async {
  final page = ModalRoute.of(context);
  if (page == null) return AiEditorDraftStruct();
  final previous = _draftSessions[page];
  final result = await _requestDraft(
    context,
    rawPrompt,
    useSample == true,
    enableLiveAi == true,
    previous?.calendar,
  );
  if (result == null || !context.mounted) return AiEditorDraftStruct();
  if (previous?.calendar != null) {
    final draft = result.session;
    draft.location = previous!.location;
    draft.alsoSaveTemplate = previous.alsoSaveTemplate;
    if (draft.calendar?.eventId != null) {
      draft.date = previous.date;
      draft.clockMinutes = previous.clockMinutes;
      draft.duration = previous.duration;
    }
  }
  _draftSessions[page] = result.session;
  return result.values;
}

Future<AiEditorDraftStruct> generateTemplateAiDraft(
  BuildContext context,
  String? rawPrompt,
) async {
  final result = await _requestDraft(
    context,
    rawPrompt,
    false,
    true,
    null,
    templateMode: true,
  );
  if (result == null || !context.mounted) return AiEditorDraftStruct();
  return result.values;
}

final _pendingModifyPrompts = Expando<String>();
final _lastModifySucceeded = Expando<bool>();

void setPendingAiChecklistModifyPrompt(BuildContext context, String prompt) {
  final page = ModalRoute.of(context);
  if (page != null) {
    _pendingModifyPrompts[page] = prompt;
    _lastModifySucceeded[page] = false;
  }
}

bool consumeAiChecklistModifySucceeded(BuildContext context) {
  final page = ModalRoute.of(context);
  if (page == null) return false;
  final ok = _lastModifySucceeded[page] == true;
  _lastModifySucceeded[page] = false;
  return ok;
}

Future<AiEditorDraftStruct> modifyAiEditorDraft(
  BuildContext context,
  String? currentTitle,
  List<PackItemStruct>? currentItems,
) async {
  final page = ModalRoute.of(context);
  if (page == null) return AiEditorDraftStruct();
  final instruction = (_pendingModifyPrompts[page] ?? '').trim();
  _pendingModifyPrompts[page] = '';
  _lastModifySucceeded[page] = false;
  void showMessage(String message) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
  if (instruction.isEmpty || instruction.length > 500) {
    showMessage('Describe your change in 500 characters or fewer.');
    return AiEditorDraftStruct();
  }
  final user = currentUserReference;
  if (user == null) {
    showMessage('Sign in to modify your checklist with AI.');
    return AiEditorDraftStruct();
  }
  final existingItems = currentItems ?? const <PackItemStruct>[];
  final existingByName = <String, PackItemStruct>{};
  for (final item in existingItems) {
    final lower = item.name.trim().toLowerCase();
    if (lower.isNotEmpty) existingByName.putIfAbsent(lower, () => item);
  }
  try {
    final records = await _loadSources(user);
    final today = DateUtils.dateOnly(DateTime.now());
    final Map<String, dynamic> draft;
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable(
        'packReadyAiTripDraft',
        options: HttpsCallableOptions(
          timeout: const Duration(seconds: 40),
        ),
      )
          .call({
        'prompt': instruction,
        'today': _ymd(today),
        'sources': records.map((source) => source.toJson()).toList(),
        'savedTemplateCount':
            records.where((source) => source.kind == 'template').length,
        'pickSourceItems': true,
        'templateMode': currentAiEditorDraft(context) == null,
        'currentChecklist': {
          'title': _clip((currentTitle ?? '').trim(), 100),
          'items': [
            for (final item in existingItems.take(60))
              if (item.name.trim().isNotEmpty)
                {
                  'name': _clip(item.name.trim(), 72),
                  if (item.detail.trim().isNotEmpty)
                    'detail': _clip(item.detail.trim(), 100),
                  if (item.category.trim().isNotEmpty)
                    'category': _clip(item.category.trim(), 40),
                },
          ],
        },
      });
      draft = Map<String, dynamic>.from(result.data as Map);
      if (draft['title'] is! String || draft['starterItems'] is! List) {
        throw const FormatException('Invalid AI checklist edit');
      }
    } on FirebaseFunctionsException catch (error) {
      if (context.mounted) {
        showMessage(switch (error.code) {
          'unavailable' => "The AI service couldn't finish. Try again.",
          'deadline-exceeded' => 'The AI edit timed out. Try again.',
          'unauthenticated' => 'Sign in to modify your checklist with AI.',
          _ => _aiUnavailable,
        });
      }
      return AiEditorDraftStruct();
    } catch (_) {
      if (context.mounted) showMessage(_aiUnavailable);
      return AiEditorDraftStruct();
    }
    if (!context.mounted || currentUserReference != user) {
      return AiEditorDraftStruct();
    }
    final seen = <String>{};
    final updated = <PackItemStruct>[];
    for (final raw in draft['starterItems'] as List) {
      if (raw is! String) continue;
      final name = _clip(raw.trim(), 72);
      final lower = name.toLowerCase();
      if (name.isEmpty || !seen.add(lower)) continue;
      final prior = existingByName[lower];
      updated.add(
        prior != null
            ? PackItemStruct.fromMap({...prior.toMap(), 'name': name})
            : PackItemStruct(name: name, packed: false),
      );
      if (updated.length >= 40) break;
    }
    final fallbackTitle = (currentTitle ?? '').trim();
    final title = _clip((draft['title'] as String).trim(), 72);
    _lastModifySucceeded[page] = true;
    return AiEditorDraftStruct(
      title: title.isEmpty
          ? (fallbackTitle.isEmpty ? 'My checklist' : fallbackTitle)
          : title,
      items: updated,
      extras: const [],
    );
  } catch (_) {
    if (context.mounted) {
      showMessage("Couldn't update your checklist. Try again.");
    }
    return AiEditorDraftStruct();
  }
}

Future<_AiResult?> _requestDraft(
  BuildContext context,
  String? rawPrompt,
  bool sample,
  bool enableLiveAi,
  CalendarAiTarget? calendar, {
  bool templateMode = false,
}) async {
  final entered = (rawPrompt ?? '').trim();
  final linkedEvent = calendar?.eventId != null;
  final prompt = linkedEvent
      ? calendar!.eventPrompt(entered)
      : sample && entered.isEmpty
          ? 'Cabin weekend with my dog and a gym workout.'
          : entered;
  void showMessage(String message) => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
  if (prompt.isEmpty || prompt.length > 500) {
    showMessage('Describe your checklist in 500 characters or fewer.');
    return null;
  }
  final user = currentUserReference;
  if (!sample && (enableLiveAi != true || user == null)) {
    showMessage(
      enableLiveAi == true
          ? 'Sign in to generate an AI draft.'
          : _aiUnavailable,
    );
    return null;
  }
  try {
    final records = sample ? _samples() : await _loadSources(user!);
    final today = DateUtils.dateOnly(DateTime.now());
    final anchor = calendar?.day ?? today;
    final Map<String, dynamic> draft;
    if (sample) {
      draft = _localDraft(prompt, records);
    } else {
      try {
        final result = await FirebaseFunctions.instance
            .httpsCallable(
          'packReadyAiTripDraft',
          options: HttpsCallableOptions(
            timeout: const Duration(seconds: 40),
          ),
        )
            .call({
          'prompt': prompt,
          'today': _ymd(anchor),
          'sources': records.map((source) => source.toJson()).toList(),
          'savedTemplateCount':
              records.where((source) => source.kind == 'template').length,
          'pickSourceItems': true,
          if (templateMode) 'templateMode': true,
        });
        draft = Map<String, dynamic>.from(result.data as Map);
        if (draft['title'] is! String ||
            draft['sourceIds'] is! List ||
            draft['extras'] is! List) {
          throw const FormatException('Invalid AI draft');
        }
      } on FirebaseFunctionsException catch (error) {
        if (context.mounted) {
          showMessage(switch (error.code) {
            'unavailable' => "The AI draft service couldn't finish. Try again.",
            'deadline-exceeded' => 'The AI draft timed out. Try again.',
            'unauthenticated' => 'Sign in to generate an AI draft.',
            _ => _aiUnavailable,
          });
        }
        return null;
      } catch (_) {
        if (context.mounted) showMessage(_aiUnavailable);
        return null;
      }
    }
    final repeat = linkedEvent || templateMode
        ? null
        : sample
            ? _parseLocalRepeat(prompt, anchor)
            : _RepeatRule.fromJson(draft['repeatRule']);
    final ids =
        (draft['sourceIds'] as List).whereType<String>().take(4).toSet();
    final picked = draft['sourceItems'];
    final itemKeys = picked is List
        ? {
            for (final pick in picked.whereType<Map>())
              (pick['sourceId'], pick['itemName']),
          }
        : null;
    final unique = <String>{};
    final exact = [
      for (final source in records)
        for (final item in source.items)
          if (item.name.trim().isNotEmpty &&
              (itemKeys?.contains((source.id, _clip(item.name, 70))) ??
                  ids.contains(source.id)) &&
              unique.add(jsonEncode([item.name, item.detail, item.category])))
            PackItemStruct.fromMap({...item.toMap(), 'packed': false}),
    ];
    final taken = exact.map((item) => item.name.trim().toLowerCase()).toSet();
    List<String> newItems(Object? value, int limit, {int? nameLimit = 72}) =>
        value is List
            ? value
                .whereType<String>()
                .map(
                  (name) => nameLimit == null
                      ? name.trim()
                      : _clip(name.trim(), nameLimit),
                )
                .where(
                  (name) => name.isNotEmpty && taken.add(name.toLowerCase()),
                )
                .take(limit)
                .toList()
            : [];
    final essentials = newItems(draft['starterItems'], 24);
    final extras = templateMode
        ? const <String>[]
        : newItems(draft['extras'], 3, nameLimit: null);
    final leaveDate = templateMode ? null : _isoDay(draft['activityDate']);
    if (!context.mounted || (!sample && currentUserReference != user))
      return null;
    final title = _clip((draft['title'] as String).trim(), 72);
    return (
      session: AiDraftEditorSession(
        date: linkedEvent
            ? calendar!.start!
            : calendar != null
                ? leaveDate ?? anchor
                : leaveDate != null && !leaveDate.isBefore(today)
                    ? leaveDate
                    : today,
        repeat: repeat,
        calendar: calendar,
        scheduleMissing: !templateMode &&
            !linkedEvent &&
            repeat == null &&
            _repeatWords.hasMatch(prompt),
        sample: sample,
        clockMinutes:
            calendar != null && !linkedEvent ? _calendarClock(entered) : null,
      ),
      values: AiEditorDraftStruct(
        title: title.isEmpty ? 'New activity' : title,
        items: [...exact, ..._items(essentials)],
        extras: _items(extras),
      ),
    );
  } catch (_) {
    if (context.mounted)
      showMessage("Couldn't load your saved kits. Try again.");
    return null;
  }
}

int? _calendarClock(String prompt) {
  final match = RegExp(
    r'\bat\s+(\d{1,2})(?::([0-5]\d))?\s*(a\.?m\.?|p\.?m\.?)?\b',
    caseSensitive: false,
  ).firstMatch(prompt);
  if (match == null) return null;
  final hour = int.parse(match[1]!);
  final suffix = match[3]?.toLowerCase();
  if (suffix == null
      ? (match[2] == null || hour > 23)
      : (hour < 1 || hour > 12)) return null;
  final h =
      suffix == null ? hour : hour % 12 + (suffix.startsWith('p') ? 12 : 0);
  return h * 60 + (int.tryParse(match[2] ?? '') ?? 0);
}

class AiDraftEditorSession {
  AiDraftEditorSession({
    required this.date,
    required this.repeat,
    required this.scheduleMissing,
    required this.sample,
    this.calendar,
    int? clockMinutes,
  })  : clockMinutes = calendar?.start != null && calendar?.allDay == false
            ? calendar!.start!.hour * 60 + calendar.start!.minute
            : clockMinutes,
        duration = calendar?.start == null
            ? null
            : calendar!.end!.difference(calendar.start!),
        location = calendar?.location ?? '';

  DateTime date;
  final _RepeatRule? repeat;
  final bool scheduleMissing, sample;
  final CalendarAiTarget? calendar;
  int? clockMinutes;
  Duration? duration;
  String location;
  bool alsoSaveTemplate = false;
  bool get calendarAllDay => clockMinutes == null;
  DateTime get calendarStart {
    final original = calendar?.start;
    final clock = clockMinutes ?? 0;
    if (original != null &&
        _ymd(original) == _ymd(date) &&
        original.hour * 60 + original.minute == clock) return original;
    return DateTime(date.year, date.month, date.day, clock ~/ 60, clock % 60);
  }

  DateTime get calendarEnd {
    final start = calendarStart;
    if (duration case final interval?) return start.add(interval);
    return calendarAllDay
        ? _dayAfter(start)
        : start.add(const Duration(hours: 1));
  }

  void setCalendarEnd(TimeOfDay time) {
    final start = calendarStart;
    var end = DateTime(
      start.year,
      start.month,
      start.day,
      time.hour,
      time.minute,
    );
    if (!end.isAfter(start))
      end = DateTime(
        start.year,
        start.month,
        start.day + 1,
        time.hour,
        time.minute,
      );
    duration = end.difference(start);
  }

  bool _saving = false;
  DocumentReference? _seriesRef;
  DocumentReference? _templateRef;
  DocumentReference? _calendarRef;

  String get scheduleLabel {
    final rule = repeat;
    if (scheduleMissing)
      return 'Tweak the prompt to add weekdays, times and a date range.';
    if (rule == null) {
      final day = dateTimeFormat('EEE, MMM d', date);
      final time = clockMinutes;
      return time == null ? day : '$day · ${_clock(time)}';
    }
    final days = rule.weekdays
        .map((day) => _weekdays[day - 1].substring(0, 3))
        .join(', ');
    final count = rule.expand().dates.length;
    final overnight = rule.endTime < rule.startTime ? ' next day' : '';
    final holidays = rule.excludeHolidays ? ' · Skip holidays' : '';
    return '$days · $count dates$holidays\n'
        '${_clock(rule.startTime)}–${_clock(rule.endTime)}$overnight · '
        '${dateTimeFormat('MMM d, y', rule.start)}–${dateTimeFormat('MMM d, y', rule.end)}';
  }

  List<String> get exceptions => [
        for (final change in repeat?.dayExceptions ?? <_DayException>[])
          [
            change.label,
            if (change.addItems.isNotEmpty) 'Add ${change.addItems.join(', ')}',
            if (change.removeItems.isNotEmpty)
              'Remove ${change.removeItems.join(', ')}',
          ].join(' · '),
      ];

  Future<void> save(
    BuildContext context,
    String? title,
    List<PackItemStruct>? items,
    String? pendingItem,
    bool template,
  ) async {
    if (_saving) return;
    void message(String text) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(text)));
    final name = title?.trim() ?? '';
    if (pendingItem?.trim().isNotEmpty == true) {
      message('Finish the item edit with + Add item before saving.');
      return;
    }
    if (name.isEmpty || items == null || items.isEmpty) {
      message('Enter a checklist name and add at least one item.');
      return;
    }
    final rule = repeat;
    if (!template &&
        (scheduleMissing || rule?.expand().dates.isEmpty == true)) {
      message('Tweak your prompt to choose a complete schedule.');
      return;
    }
    if (sample) {
      message('Sample draft. Generate a live draft to save it.');
      return;
    }
    final user = currentUserReference;
    if (user == null) {
      message('Sign in again to save this draft.');
      return;
    }
    _saving = true;
    final checklist = [
      for (final item in items) PackItemStruct.fromMap(item.toMap()),
    ];
    try {
      if (template) {
        await _saveTemplate(user, name, checklist);
        if (context.mounted) context.goNamed(TemplatesWidget.routeName);
      } else {
        final ref = rule == null && calendar != null
            ? await _saveCalendarActivity(user, name, checklist)
            : rule == null
                ? await savePackingList(
                    context,
                    name,
                    'Custom',
                    date,
                    false,
                    checklist,
                  )
                : await _saveSeries(user, name, rule, checklist);
        if (ref == null) throw StateError('Activity could not be saved');
        if (calendar != null && alsoSaveTemplate) {
          await _saveTemplate(user, name, checklist);
        }
        if (context.mounted) {
          if (calendar != null) {
            context.pop<CalendarAiSave>((
              activity: ref,
              date: rule == null ? calendarStart : rule.expand().dates.first,
            ));
            return;
          }
          context.goNamed(
            PackingListWidget.routeName,
            queryParameters: {
              'listRef': serializeParam(ref, ParamType.DocumentReference),
            }.withoutNulls,
          );
        }
      }
    } catch (_) {
      if (context.mounted)
        message(
          template
              ? "Couldn't save your template. Try again."
              : "Couldn't create your activity. Try again.",
        );
    } finally {
      _saving = false;
    }
  }

  Future<void> _saveTemplate(
    DocumentReference user,
    String name,
    List<PackItemStruct> checklist,
  ) =>
      (_templateRef ??= ChecklistTemplatesRecord.createDoc(user)).set({
        ...createChecklistTemplatesRecordData(
          name: name,
          activity: 'Custom',
          starterName: name,
        ),
        ...mapToFirestore({
          'createdTime': FieldValue.serverTimestamp(),
          'updatedTime': FieldValue.serverTimestamp(),
          'items': getPackItemListFirestoreData(checklist),
        }),
      });

  Future<DocumentReference> _saveCalendarActivity(
    DocumentReference user,
    String name,
    List<PackItemStruct> checklist,
  ) async {
    final target = calendar!;
    final key = target.key;
    final ref = _calendarRef ??= PackingListsRecord.createDoc(user);
    await writePackingList(
      ref,
      tripName: name,
      activity: 'Custom',
      leaveDate: calendarStart,
      recurring: false,
      items: checklist,
      calendarEventKey: key,
      calendarId: target.calendarId,
      calendarEventId: target.eventId,
      calendarEventTitle: key == null ? null : target.title,
      calendarSource: target.source,
      calendarAllDay: calendarAllDay,
      endTime: calendarEnd,
      location: location.trim(),
    );
    return ref;
  }

  Future<DocumentReference> _saveSeries(
    DocumentReference user,
    String name,
    _RepeatRule rule,
    List<PackItemStruct> checklist,
  ) async {
    final dates = rule.expand().dates;
    final series = (_seriesRef ??= PackingListsRecord.createDoc(user)).id;
    final batch = FirebaseFirestore.instance.batch();
    final now = DateTime.now();
    final reminderMinutes = switch (currentUserDocument?.defaultReminder) {
      '30 mins before' => 30,
      '1 hour before leaving' => 60,
      '2 hours before' => 120,
      '1 day before' => 1440,
      _ => null,
    };
    final refs = <DocumentReference>[];
    for (final day in dates) {
      final items = [...checklist];
      for (final change in rule.exceptionsFor(day)) {
        final removed =
            change.removeItems.map((name) => name.toLowerCase()).toSet();
        items.removeWhere(
          (item) => removed.contains(item.name.trim().toLowerCase()),
        );
        final names =
            items.map((item) => item.name.trim().toLowerCase()).toSet();
        items.addAll(
          _items(
            change.addItems.where((name) => names.add(name.toLowerCase())),
          ),
        );
      }
      final ref = PackingListsRecord.createDoc(
        user,
        id: '${series}_${_ymd(day)}',
      );
      final start = rule.startAt(day);
      final reminder = reminderMinutes == null
          ? null
          : start.subtract(Duration(minutes: reminderMinutes));
      refs.add(ref);
      batch.set(ref, {
        ...createPackingListsRecordData(
          tripName: name,
          activity: 'Custom',
          leaveDate: start,
          createdTime: now,
          completed: false,
          recurring: true,
          reminderTime:
              reminder != null && reminder.isAfter(now) ? reminder : null,
        ),
        ...mapToFirestore({
          'items': getPackItemListFirestoreData(items),
          'repeatSeriesId': series,
          'repeatRule': rule.toJson(),
          'endTime': rule.endAt(day),
          if (calendar != null) 'calendarSource': packReadyCalendarSource,
          if (calendar != null && location.trim().isNotEmpty)
            'location': location.trim(),
        }),
      });
    }
    await batch.commit();
    return refs.first;
  }
}

// Calendar rules use local wall time and an inclusive date range.
const _weekdays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];
const _months = [
  'jan',
  'feb',
  'mar',
  'apr',
  'may',
  'jun',
  'jul',
  'aug',
  'sep',
  'oct',
  'nov',
  'dec',
];
final _repeatWords = RegExp(
  r'\b(?:every|weekly|recurring|repeats?)\b',
  caseSensitive: false,
);

String _ymd(DateTime day) => day.toIso8601String().split('T').first;
String _clock(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';
DateTime _dayAfter(DateTime date, [int delta = 1]) =>
    DateTime(date.year, date.month, date.day + delta);

DateTime? _isoDay(Object? value) {
  if (value is! String || !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value))
    return null;
  final date = DateTime.tryParse(value);
  return date != null && _ymd(date) == value ? date : null;
}

int? _clockMinutes(Object? value) {
  if (value is! String ||
      !RegExp(r'^(?:[01]\d|2[0-3]):[0-5]\d$').hasMatch(value)) return null;
  return int.parse(value.substring(0, 2)) * 60 + int.parse(value.substring(3));
}

class _DayException {
  _DayException(this.weekday, this.date, this.addItems, this.removeItems);

  final int? weekday;
  final DateTime? date;
  final List<String> addItems, removeItems;

  static _DayException? fromJson(Object? input) {
    if (input is! Map) return null;
    final weekday = input['weekday'];
    final date = _isoDay(input['date']);
    if (date == null && (weekday is! int || weekday < 1 || weekday > 7)) {
      return null;
    }
    List<String> names(Object? value) => value is List
        ? value
            .whereType<String>()
            .map((name) => name.trim())
            .where((name) => name.isNotEmpty)
            .toList()
        : [];
    return _DayException(
      date == null ? weekday as int : null,
      date,
      names(input['addItems']),
      names(input['removeItems']),
    );
  }

  String get label => date == null ? _weekdays[weekday! - 1] : _ymd(date!);

  Map<String, Object> toJson() => {
        if (weekday != null) 'weekday': weekday!,
        if (date != null) 'date': _ymd(date!),
        'addItems': addItems,
        'removeItems': removeItems,
      };
}

class _RepeatRule {
  _RepeatRule(
    this.weekdays,
    this.start,
    this.end,
    this.startTime,
    this.endTime,
    this.excludeHolidays,
    this.dayExceptions,
  );
  final List<int> weekdays;
  final DateTime start, end;
  final int startTime, endTime;
  final bool excludeHolidays;
  final List<_DayException> dayExceptions;

  static _RepeatRule? fromJson(Object? input) {
    if (input is! Map ||
        input['weekdays'] is! List ||
        input['excludeHolidays'] is! bool) return null;
    final days = (input['weekdays'] as List).whereType<int>().toSet().toList()
      ..sort();
    final start = _isoDay(input['startDate']);
    final end = _isoDay(input['endDate']);
    final from = _clockMinutes(input['startTime']);
    final to = _clockMinutes(input['endTime']);
    final exceptions = input['dayExceptions'];
    if (days.isEmpty ||
        days.first < 1 ||
        days.last > 7 ||
        start == null ||
        end == null ||
        from == null ||
        to == null ||
        from == to ||
        end.isBefore(start) ||
        !end.isBefore(_dayAfter(start, 366))) return null;
    return _RepeatRule(
      days,
      start,
      end,
      from,
      to,
      input['excludeHolidays'] as bool,
      [
        if (exceptions is List)
          for (final value in exceptions)
            if (_DayException.fromJson(value) case final change?)
              if (switch (change.date) {
                final day? => !day.isBefore(start) &&
                    !day.isAfter(end) &&
                    days.contains(day.weekday),
                null => days.contains(change.weekday),
              })
                change,
      ],
    );
  }

  Map<String, Object> toJson() => {
        'weekdays': weekdays,
        'startDate': _ymd(start),
        'endDate': _ymd(end),
        'startTime': _clock(startTime),
        'endTime': _clock(endTime),
        'excludeHolidays': excludeHolidays,
        if (dayExceptions.isNotEmpty)
          'dayExceptions':
              dayExceptions.map((change) => change.toJson()).toList(),
      };

  Iterable<_DayException> exceptionsFor(DateTime day) sync* {
    yield* dayExceptions.where((change) => change.weekday == day.weekday);
    yield* dayExceptions.where((change) => change.date == day);
  }

  DateTime startAt(DateTime day) =>
      DateTime(day.year, day.month, day.day, startTime ~/ 60, startTime % 60);
  DateTime endAt(DateTime day) => DateTime(
        day.year,
        day.month,
        day.day + (endTime < startTime ? 1 : 0),
        endTime ~/ 60,
        endTime % 60,
      );

  ({List<DateTime> dates, Map<DateTime, String> skipped}) expand() {
    final holidays = excludeHolidays
        ? {
            for (var year = start.year - 1; year <= end.year + 1; year++)
              ..._federalHolidays(year),
          }
        : <DateTime, String>{};
    final dates = <DateTime>[];
    final skipped = <DateTime, String>{};
    for (var day = start; !day.isAfter(end); day = _dayAfter(day)) {
      if (!weekdays.contains(day.weekday)) continue;
      final holiday = holidays[day];
      if (holiday == null) {
        dates.add(day);
      } else {
        skipped[day] = holiday;
      }
    }
    return (dates: dates, skipped: skipped);
  }
}

Map<DateTime, String> _federalHolidays(int year) {
  DateTime nth(int month, int weekday, int week) {
    final first = DateTime(year, month);
    return _dayAfter(first, (weekday - first.weekday) % 7 + 7 * (week - 1));
  }

  final mayEnd = DateTime(year, 6, 0);
  final dates = <DateTime, String>{
    DateTime(year, 1, 1): 'New Year’s Day',
    nth(1, DateTime.monday, 3): 'Martin Luther King Jr. Day',
    nth(2, DateTime.monday, 3): 'Washington’s Birthday',
    _dayAfter(mayEnd, -((mayEnd.weekday - DateTime.monday) % 7)):
        'Memorial Day',
    if (year >= 2021) DateTime(year, 6, 19): 'Juneteenth',
    DateTime(year, 7, 4): 'Independence Day',
    nth(9, DateTime.monday, 1): 'Labor Day',
    nth(10, DateTime.monday, 2): 'Columbus Day',
    DateTime(year, 11, 11): 'Veterans Day',
    nth(11, DateTime.thursday, 4): 'Thanksgiving Day',
    DateTime(year, 12, 25): 'Christmas Day',
  };
  return {
    ...dates,
    for (final entry in dates.entries)
      if (entry.key.weekday == DateTime.saturday ||
          entry.key.weekday == DateTime.sunday)
        _dayAfter(entry.key, entry.key.weekday == DateTime.saturday ? -1 : 1):
            '${entry.value} (observed)',
  };
}

_RepeatRule? _parseLocalRepeat(String prompt, DateTime today) {
  if (!_repeatWords.hasMatch(prompt)) return null;
  final range = RegExp(
    r'\bfrom\s+(.+?)\s+(?:to|until|through)\s+([^,;]+?)(?=\s+(?:(?:excluding|except|including)\b)|[,;]|$)',
    caseSensitive: false,
  ).firstMatch(prompt);
  final clock = RegExp(
    r'\b(\d{1,2})(?::([0-5]\d))?\s*(am|pm)?\s*(?:[-–—]|\bto\b)\s*(\d{1,2})(?::([0-5]\d))?\s*(am|pm)?\b',
    caseSensitive: false,
  ).firstMatch(range == null ? prompt : prompt.substring(0, range.start));
  if (range == null || clock == null) return null;
  final weekdayText = prompt.substring(0, clock.start).toLowerCase();
  final days = [
    for (final (i, name) in _weekdays.indexed)
      if (RegExp(
        '\\b(?:${name.toLowerCase()}|${name.substring(0, 3).toLowerCase()})s?\\b',
      ).hasMatch(weekdayText))
        i + 1,
  ];
  if (days.isEmpty && RegExp(r'\bweekdays\b').hasMatch(weekdayText))
    days.addAll([1, 2, 3, 4, 5]);
  if (days.isEmpty && RegExp(r'\bevery day\b|\bdaily\b').hasMatch(weekdayText))
    days.addAll([1, 2, 3, 4, 5, 6, 7]);

  DateTime? parseDay(String raw, DateTime anchor, {required bool isEnd}) {
    final text = raw.trim().toLowerCase().replaceFirst(RegExp(r'\.$'), '');
    final explicit = _isoDay(text);
    if (explicit != null) return explicit;
    final match = RegExp(
      r'^([a-z]{3,})(?:\s+(\d{1,2})(?:st|nd|rd|th)?)?(?:\s+(\d{4}))?$',
    ).firstMatch(text);
    if (match == null) return null;
    final month = _months.indexOf(match[1]!.substring(0, 3)) + 1;
    if (month == 0) return null;
    final year = int.tryParse(match[3] ?? '') ?? anchor.year;
    final day = int.tryParse(match[2] ?? '');
    DateTime inYear(int y) => day != null
        ? DateTime(y, month, day)
        : isEnd
            ? DateTime(y, month + 1, 0)
            : DateTime(y, month);
    var date = inYear(year);
    if (match[3] == null && date.isBefore(anchor)) {
      date = !isEnd && day == null && month == anchor.month
          ? anchor
          : inYear(year + 1);
    }
    return date.month == month ? date : null;
  }

  int? parseClock(int offset, String? suffix) {
    final hour = int.parse(clock[offset]!);
    final minute = int.tryParse(clock[offset + 1] ?? '') ?? 0;
    if (suffix == null) return hour < 24 ? hour * 60 + minute : null;
    if (hour < 1 || hour > 12) return null;
    return (hour % 12 + (suffix.toLowerCase() == 'pm' ? 12 : 0)) * 60 + minute;
  }

  final start = parseDay(range[1]!, today, isEnd: false);
  final end = start == null ? null : parseDay(range[2]!, start, isEnd: true);
  final from = parseClock(1, clock[3] ?? clock[6]);
  final to = parseClock(4, clock[6] ?? clock[3]);
  if (start == null || end == null || from == null || to == null) return null;
  final inferredFrom = clock[3] == null && clock[6] != null && from > to
      ? (from + 720) % 1440
      : from;
  return _RepeatRule.fromJson({
    'weekdays': days,
    'startDate': _ymd(start),
    'endDate': _ymd(end),
    'startTime': _clock(inferredFrom),
    'endTime': _clock(to),
    'excludeHolidays': RegExp(
      r'\b(?:excluding|exclude|except|skip(?:ping)?)\b[^,;]*\bholidays\b',
      caseSensitive: false,
    ).hasMatch(prompt),
  });
}
