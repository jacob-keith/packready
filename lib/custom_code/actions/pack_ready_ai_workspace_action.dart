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

// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart'
    show GZipDecoder, GZipEncoder, getAdler32, getCrc32;
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:uuid/uuid.dart';

import '/index.dart' show PackReadyAiConfirmationWidget;
import '/components/pack_ready_ai_tutorial_widget.dart';
import '/components/pack_ready_ai_undo_conflict_widget.dart';
import '/custom_code/actions/calendar_studio.dart'
    show calendarActivityEnd, effectiveCalendarActivityDate;
import '/custom_code/actions/generate_ai_editor_draft.dart'
    show packReadyCalendarSource;
import '/custom_code/actions/load_pack_ready_calendar_events.dart'
    show CalendarSync, packReadyDemoCalendar;
import '/custom_code/actions/save_packing_list.dart'
    show packingListCreationData;

Future<PackReadyAiReplyStruct> packReadyAiWorkspaceAction(
  BuildContext context,
  String operation,
  String input,
) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  bool current() =>
      context.mounted && uid == FirebaseAuth.instance.currentUser?.uid;

  PackReadyAiReplyStruct error(String message) =>
      PackReadyAiReplyStruct(error: message, ownerUid: uid);
  if (uid == null) return error('Sign in to use PackReady AI.');
  final user = FirebaseFirestore.instance.collection('users').doc(uid);
  final auth = FirebaseAuth.instance;
  var sameSession = true;
  final subscription = auth.authStateChanges().listen((active) {
    if (active?.uid != uid) sameSession = false;
  });
  bool active() => sameSession && current();
  void status(String value) {
    if (active()) {
      FFAppState().update(() => FFAppState().packReadyAiProgress = value);
    }
  }

  PackReadyAiReplyStruct reply(
    List<_AiTurnRecord> turns, {
    bool clearPrompt = false,
    bool tutorialSeen = true,
  }) =>
      PackReadyAiReplyStruct(
        ownerUid: uid,
        clearPrompt: clearPrompt,
        tutorialSeen: tutorialSeen,
        hasHistory: true,
        turns: turns.map(_historyCard).toList(),
      );

  try {
    switch (operation) {
      case 'tutorial':
      case 'firstTutorial':
        await showDialog<bool>(
          context: context,
          barrierColor: const Color(0xb8000000),
          builder: (_) => const Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 28,
            ),
            backgroundColor: Colors.transparent,
            child: PackReadyAiTutorialWidget(),
          ),
        );
        if (operation == 'firstTutorial' && active()) {
          await user.set({_aiTutorialField: true}, SetOptions(merge: true));
        }
        return PackReadyAiReplyStruct();
      case 'load':
        final state = await _loadAiUserState(user);
        return active()
            ? reply(state.turns, tutorialSeen: state.tutorialSeen)
            : PackReadyAiReplyStruct();
      case 'run':
        final prompt = input.trim();
        if (prompt.isEmpty) return PackReadyAiReplyStruct();
        if (prompt.length > 500) {
          return error('Keep your request under 500 characters.');
        }
        FocusScope.of(context).unfocus();
        status('Reading your calendars, activities, and templates…');
        final turn = await _runPackReadyOrchestrator(user, prompt, status, (
          changes,
        ) async {
          if (!active()) return false;
          final accepted = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (_) =>
                  PackReadyAiConfirmationWidget(plan: _reviewPlan(changes)),
            ),
          );
          return accepted == true && active();
        });
        if (turn == null || !active()) return PackReadyAiReplyStruct();
        if (turn.mutations.isEmpty) {
          try {
            await user.set(_aiTurnWrite(turn), SetOptions(merge: true));
          } catch (_) {
            return error('Could not save this AI request to your history.');
          }
        }
        return PackReadyAiReplyStruct(
          ownerUid: uid,
          clearPrompt: true,
          latestTurn: _historyCard(turn),
        );
      case 'undo':
        final state = await _loadAiUserState(user);
        if (!active()) return PackReadyAiReplyStruct();
        final turn = state.turns.where((turn) => turn.id == input).firstOrNull;
        if (turn != null && !turn.undone && turn.mutations.isNotEmpty) {
          await _undoAiTurn(context, user, turn, active);
        }
        if (!active()) return PackReadyAiReplyStruct();
        return reply((await _loadAiUserState(user)).turns);
      default:
        throw ArgumentError.value(operation);
    }
  } on FirebaseFunctionsException catch (failure) {
    return active()
        ? error(switch (failure.code) {
            'not-found' => 'The PackReady AI planner is unavailable.',
            'unauthenticated' => 'Sign in to use PackReady AI.',
            'deadline-exceeded' => 'PackReady AI timed out. Try again.',
            _ => failure.message ?? 'PackReady AI could not finish. Try again.',
          })
        : PackReadyAiReplyStruct();
  } catch (_) {
    return active()
        ? error(switch (operation) {
            'load' => 'Could not load AI history. Try again.',
            'undo' => 'Could not undo that request. Try again.',
            _ => 'PackReady AI could not finish. Try again.',
          })
        : PackReadyAiReplyStruct();
  } finally {
    if (operation == 'run') status('');
    await subscription.cancel();
  }
}

PackReadyAiHistoryCardStruct _historyCard(_AiTurnRecord turn) =>
    PackReadyAiHistoryCardStruct(
      turnId: turn.id,
      prompt: turn.prompt,
      summary: turn.summary,
      timeLabel: DateFormat(
        'MMM d · h:mm a',
      ).format(DateTime.fromMillisecondsSinceEpoch(turn.createdAtMs)),
      undone: turn.undone,
      undoable: turn.mutations.isNotEmpty && !turn.undone,
      lines: [
        for (final line in turn.lines)
          PackReadyAiResultLineStruct(kind: line.kind, text: line.text),
      ],
    );

PackReadyAiPlanStruct _reviewPlan(List<_PlanChange> changes) {
  final planned = changes.where((change) => !change.isSkipped).toList();
  final links = planned.where((change) => change.target != null).toList();
  final adds = planned.where((change) => change.isAdd).length;
  final deletes = planned.where((change) => change.isDelete).length;
  final edits = planned.length - adds - deletes;
  final attaches = links.where((change) => !change.isUnlink).length;
  return PackReadyAiPlanStruct(
    hasChanges: planned.isNotEmpty,
    title: planned.isEmpty
        ? 'All matched events are already linked'
        : links.isEmpty
            ? 'Review your changes'
            : 'See what goes where',
    description: planned.isEmpty
        ? 'There are no activities to create.'
        : attaches == 0
            ? '${planned.length} planned ${planned.length == 1 ? 'change' : 'changes'}.'
            : '$attaches ${attaches == 1 ? 'checklist will be applied' : 'checklists will be applied'} to activities.',
    addLabel: '+$adds Add',
    editLabel: '~$edits Edit',
    deleteLabel: '−$deletes Delete',
    links: links.map(_reviewCard).toList(),
    otherChanges: planned
        .where((change) => change.target == null)
        .map(_reviewCard)
        .toList(),
    skipped:
        changes.where((change) => change.isSkipped).map(_reviewCard).toList(),
  );
}

PackReadyAiChangeStruct _reviewCard(_PlanChange change) {
  final isLink = change.target != null;
  final dates = change.occurrences;
  final occurrence = _occurrenceLabel(dates);
  final scope = [
    if (change.scope.isNotEmpty) change.scope,
    if (!isLink && occurrence.isNotEmpty) occurrence,
  ].join('\n');
  final targetScope = [
    if ((change.targetScope ?? '').isNotEmpty) change.targetScope!,
    if (occurrence.isNotEmpty) occurrence,
  ].join('\n');
  return PackReadyAiChangeStruct(
    title: change.title,
    scope: scope,
    actionLabel: change.isSkipped ? change.action : change.action.toUpperCase(),
    tone: change.isDelete
        ? 'delete'
        : change.isSkipped
            ? 'skipped'
            : change.action == 'Update' || change.isUnlink
                ? 'edit'
                : 'add',
    glyph: change.icon,
    targetTitle: change.target,
    targetScope: targetScope,
    itemCountLabel: _itemCount(change.details.length),
    connector: change.isUnlink ? 'removes from' : 'applies to',
    details: change.details.isEmpty ? ['No checklist items'] : change.details,
    dates: dates.length < 2 ? [] : dates.map(DateFormat.MMMd().format).toList(),
  );
}

Future<void> _undoAiTurn(
  BuildContext context,
  DocumentReference<Map<String, dynamic>> user,
  _AiTurnRecord turn,
  bool Function() active,
) async {
  final db = user.firestore;
  final inspections = await Future.wait(
    turn.mutations.map((mutation) async {
      final ref = db.doc(
        '${user.path}/${mutation.collection}/${mutation.docId}',
      );
      final live = (await _readServerDoc(ref)).data();
      final hash = _docFingerprint(live);
      final conflict = switch (mutation.kind) {
        'create' => live != null && hash != mutation.afterHash,
        'delete' => live != null,
        'edit' => live == null || hash != mutation.afterHash,
        _ => false,
      };
      return (
        mutation: mutation,
        ref: ref,
        hash: hash,
        conflict: conflict,
        name: _docDisplayName(live) ?? mutation.name,
      );
    }),
  );
  if (!active() || !context.mounted) return;
  final names = inspections
      .where((item) => item.conflict)
      .map((item) => item.name)
      .toSet();
  if (names.isNotEmpty) {
    final label = names.length == 1 ? 'list' : 'lists';
    final accepted = await showDialog<bool>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: PackReadyAiUndoConflictWidget(
          title: 'Revert edited $label?',
          message:
              'You edited ${names.join(', ')} since then. Revert or keep your edits?',
        ),
      ),
    );
    if (accepted != true || !active()) return;
  }

  await db.runTransaction((transaction) async {
    final owner = (await transaction.get(user)).data() ?? const {};
    final saved = (owner[_aiHistoryRecordsField] as Map?)?[turn.id];
    if (saved is Blob &&
        _AiTurnRecord.fromJson(_decodeAiBlob(saved))?.undone == true) {
      return;
    }
    final lives = await Future.wait([
      for (final item in inspections) transaction.get(item.ref),
    ]);
    if (!active()) return;
    for (final (index, item) in inspections.indexed) {
      if (_docFingerprint(lives[index].data()) != item.hash) {
        throw StateError('A list changed while reviewing Undo.');
      }
    }
    for (final item in inspections) {
      final mutation = item.mutation;
      if (mutation.kind == 'create') {
        transaction.delete(item.ref);
      } else if (mutation.before != null) {
        transaction.set(
          item.ref,
          _decodeFs(mutation.before, db) as Map<String, dynamic>,
        );
      }
    }
    transaction.set(
      user,
      _aiTurnWrite(turn.copyWith(undone: true)),
      SetOptions(merge: true),
    );
  });
}

const _aiHistoryField = 'aiTurnHistory';
const _aiTutorialField = 'aiTutorialSeen';
const _aiHistoryRecordsField = 'aiTurnHistoryRecords';

String _orchClip(String text, int limit) {
  final trimmed = text.trim();
  return trimmed.length <= limit ? trimmed : trimmed.substring(0, limit);
}

DateTime _orchDay(DateTime d) => DateTime(d.year, d.month, d.day);

DateTime? _orchEventStart(PackReadyCalendarEventStruct ev) {
  final parsed = DateTime.tryParse(ev.start);
  if (parsed == null) return null;
  if (ev.allDay) {
    final date = ev.start.length == 10 ? parsed : parsed.toUtc();
    return DateTime(date.year, date.month, date.day);
  }
  return parsed.toLocal();
}

DateTime? _orchEventEnd(PackReadyCalendarEventStruct ev, DateTime start) {
  final parsed = DateTime.tryParse(ev.end);
  if (parsed == null) return null;
  if (ev.allDay) {
    final date = ev.end.length == 10 ? parsed : parsed.toUtc();
    final end = DateTime(date.year, date.month, date.day);
    return end.isAfter(start) ? end : _dayAfter(start);
  }
  return parsed.toLocal();
}

String _orchCalendarEventKey(
  PackReadyCalendarEventStruct event, {
  required bool series,
}) {
  final base = series && event.seriesId.isNotEmpty
      ? 'series:${event.seriesId}'
      : 'event:${event.id}';
  return event.calendarId.isNotEmpty && event.provider != 'demo'
      ? '${event.calendarId}:$base'
      : base;
}

bool _matchesCalendarLink(
  PackReadyCalendarEventStruct event,
  Map<String, dynamic> data, {
  List<int>? ruleWeekdays,
}) {
  final source = data['calendarSource'];
  final calendar = data['calendarId'];
  if ((source is String && source.isNotEmpty && source != event.provider) ||
      (calendar is String &&
          calendar.isNotEmpty &&
          calendar != event.calendarId)) {
    return false;
  }
  final key = data['calendarEventKey'] as String? ?? '';
  if (event.seriesId.isNotEmpty &&
      (key == _orchCalendarEventKey(event, series: true) ||
          key == 'series:${event.seriesId}')) {
    final weekdays = (data['calendarWeekdays'] as List? ?? const [])
        .whereType<num>()
        .where((day) => day >= 1 && day <= 7)
        .map((day) => day.toInt())
        .toSet();
    if (ruleWeekdays != null) {
      return weekdays.isEmpty ||
          ruleWeekdays.isEmpty ||
          ruleWeekdays.any(weekdays.contains);
    }
    final start = _orchEventStart(event);
    final excluded = data['calendarExcludedDates'] as List? ?? const [];
    return start != null &&
        !excluded.contains(_ymd(start)) &&
        (weekdays.isEmpty || weekdays.contains(start.weekday));
  }
  return ruleWeekdays == null &&
      event.id.isNotEmpty &&
      (key == _orchCalendarEventKey(event, series: false) ||
          key == 'event:${event.id}' ||
          (key.isEmpty && data['calendarEventId'] == event.id));
}

Future<QuerySnapshot> _readActivities(DocumentReference user) =>
    PackingListsRecord.collection(
      user,
    ).get(const GetOptions(source: Source.server));

// ---------------------------------------------------------------------------
// Lossless Firestore Document Codec, Fingerprinting, & Surgical Turn Journal
// ---------------------------------------------------------------------------

Object? _encodeFs(Object? value) {
  if (value == null || value is bool || value is num || value is String) {
    return value;
  }
  if (value is Timestamp) {
    return {'__tsUs': value.microsecondsSinceEpoch};
  }
  if (value is DateTime) {
    return {'__tsUs': Timestamp.fromDate(value).microsecondsSinceEpoch};
  }
  if (value is DocumentReference) {
    return {'__ref': value.path};
  }
  if (value is List) {
    return [for (final item in value) _encodeFs(item)];
  }
  if (value is Map) {
    final keys = value.keys.map((k) => k.toString()).toList()..sort();
    return {for (final k in keys) k: _encodeFs(value[k])};
  }
  return value.toString();
}

Object? _decodeFs(Object? value, FirebaseFirestore db) {
  if (value == null || value is bool || value is num || value is String) {
    return value;
  }
  if (value is List) {
    return [for (final item in value) _decodeFs(item, db)];
  }
  if (value is Map) {
    if (value.length == 1 && value['__tsUs'] is num) {
      return Timestamp.fromMicrosecondsSinceEpoch(
        (value['__tsUs'] as num).toInt(),
      );
    }
    if (value.length == 1 && value['__ref'] is String) {
      return db.doc(value['__ref'] as String);
    }
    return <String, dynamic>{
      for (final entry in value.entries)
        entry.key.toString(): _decodeFs(entry.value, db),
    };
  }
  return value;
}

/// Deterministic dart2js-safe fingerprint of an already-encoded Firestore map.
String _fingerprintEncoded(Map<String, dynamic> encoded) {
  final bytes = utf8.encode(jsonEncode(encoded));
  final fwd = getCrc32(bytes).toRadixString(16);
  final rev = getCrc32(bytes.reversed.toList()).toRadixString(16);
  final adler = getAdler32(bytes).toRadixString(16);
  return '${bytes.length}:$fwd:$rev:$adler';
}

String? _docFingerprint(Map<String, dynamic>? raw) {
  if (raw == null) return null;
  return _fingerprintEncoded(_encodeFs(raw) as Map<String, dynamic>);
}

String? _docDisplayName(Map<String, dynamic>? raw) {
  if (raw == null) return null;
  final trip = raw['tripName'];
  if (trip is String && trip.trim().isNotEmpty) return _orchClip(trip, 72);
  final name = raw['name'];
  if (name is String && name.trim().isNotEmpty) return _orchClip(name, 72);
  return null;
}

Future<DocumentSnapshot<Map<String, dynamic>>> _readServerDoc(
  DocumentReference<Map<String, dynamic>> ref,
) async {
  try {
    return await ref.get(const GetOptions(source: Source.server));
  } catch (_) {
    return ref.get();
  }
}

class _OrchResultLine {
  const _OrchResultLine(this.kind, this.text);
  final String kind; // 'create' | 'edit' | 'delete'
  final String text;

  Map<String, dynamic> toJson() => {'k': kind, 't': text};

  static _OrchResultLine? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final k = raw['k'];
    final t = raw['t'];
    if (k is! String || t is! String || t.isEmpty) return null;
    return _OrchResultLine(k, t);
  }
}

class _AiDocMutation {
  const _AiDocMutation({
    required this.collection,
    required this.docId,
    required this.name,
    required this.kind,
    required this.before,
    required this.afterHash,
  });

  final String collection; // 'packingLists' | 'checklistTemplates'
  final String docId;
  final String name;
  final String kind; // 'create' | 'edit' | 'delete'
  final Map<String, dynamic>? before; // null iff kind == 'create'
  final String? afterHash; // null iff kind == 'delete'

  Map<String, dynamic> toJson() => {
        'c': collection,
        'id': docId,
        'n': name,
        'k': kind,
        if (before != null) 'b': before,
        if (afterHash != null) 'h': afterHash,
      };

  static _AiDocMutation? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final c = raw['c'];
    final id = raw['id'];
    final n = raw['n'];
    final k = raw['k'];
    if (c is! String ||
        (c != 'packingLists' && c != 'checklistTemplates') ||
        id is! String ||
        id.isEmpty ||
        k is! String ||
        (k != 'create' && k != 'edit' && k != 'delete')) {
      return null;
    }
    final b = raw['b'];
    final h = raw['h'];
    return _AiDocMutation(
      collection: c,
      docId: id,
      name: n is String && n.isNotEmpty ? n : 'Untitled list',
      kind: k,
      before: b is Map ? Map<String, dynamic>.from(b) : null,
      afterHash: h is String ? h : null,
    );
  }
}

class _AiTurnRecord {
  const _AiTurnRecord({
    required this.id,
    required this.prompt,
    required this.summary,
    required this.createdAtMs,
    required this.undone,
    required this.lines,
    required this.mutations,
  });

  final String id;
  final String prompt;
  final String summary;
  final int createdAtMs;
  final bool undone;
  final List<_OrchResultLine> lines;
  final List<_AiDocMutation> mutations;

  _AiTurnRecord copyWith({bool? undone}) => _AiTurnRecord(
        id: id,
        prompt: prompt,
        summary: summary,
        createdAtMs: createdAtMs,
        undone: undone ?? this.undone,
        lines: lines,
        mutations: mutations,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'p': prompt,
        's': summary,
        'at': createdAtMs,
        if (undone) 'u': true,
        'l': [for (final line in lines) line.toJson()],
        'm': [for (final m in mutations) m.toJson()],
      };

  static _AiTurnRecord? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final id = raw['id'];
    final p = raw['p'];
    final s = raw['s'];
    final at = raw['at'];
    if (id is! String || p is! String || s is! String || at is! num) {
      return null;
    }
    return _AiTurnRecord(
      id: id,
      prompt: p,
      summary: s,
      createdAtMs: at.toInt(),
      undone: raw['u'] == true,
      lines: [
        for (final item in raw['l'] as List? ?? const [])
          if (_OrchResultLine.fromJson(item) case final line?) line,
      ],
      mutations: [
        for (final item in raw['m'] as List? ?? const [])
          if (_AiDocMutation.fromJson(item) case final m?) m,
      ],
    );
  }
}

// Stage document writes independently of the grouped confirmation cards.
class _TurnJournal {
  final calendarConflicts = <bool Function(Map<String, dynamic>)>[];
  final writes = <String,
      ({
    DocumentReference<Map<String, dynamic>> ref,
    List<
        ({
          String kind,
          Map<String, dynamic> Function(Map<String, dynamic>) fields,
        })> steps,
  })>{};

  void stage(
    DocumentReference ref,
    String kind,
    Map<String, dynamic> Function(Map<String, dynamic>) fields,
  ) {
    writes
        .putIfAbsent(
          ref.path,
          () => (ref: ref.firestore.doc(ref.path), steps: []),
        )
        .steps
        .add((kind: kind, fields: fields));
  }

  Future<_AiTurnRecord> apply(
    DocumentReference user,
    _AiTurnRecord Function(List<_AiDocMutation>) turnFor,
  ) =>
      user.firestore.runTransaction((tx) async {
        if (calendarConflicts.isNotEmpty) {
          // AI turns also write the user history document. Reading it first makes
          // two simultaneous AI applies retry their link checks before committing.
          await tx.get(user.firestore.doc(user.path));
          final current = await _readActivities(user);
          for (final doc in current.docs) {
            if (writes[doc.reference.path]?.steps.last.kind == 'delete')
              continue;
            final data = doc.data() as Map<String, dynamic>;
            if (calendarConflicts.any((conflicts) => conflicts(data))) {
              throw FirebaseFunctionsException(
                code: 'aborted',
                message:
                    'A calendar activity was linked while you reviewed this plan. Run your request again to review the current links.',
              );
            }
          }
        }
        final entries = writes.values.toList();
        final before = await Future.wait([
          for (final entry in entries)
            entry.steps.first.kind == 'create'
                ? Future<Map<String, dynamic>?>.value(null)
                : tx.get(entry.ref).then((snapshot) => snapshot.data()),
        ]);
        final mutations = <_AiDocMutation>[];
        for (final (index, entry) in entries.indexed) {
          final old = before[index];
          var after = old;
          for (final step in entry.steps) {
            switch (step.kind) {
              case 'create':
                after = step.fields(const {});
              case 'edit':
                if (after == null)
                  throw StateError('Activity or template was removed');
                after = {...after, ...step.fields(after)};
              case 'delete':
                after = null;
            }
          }
          final afterHash = _docFingerprint(after);
          if (afterHash == _docFingerprint(old)) continue;
          mutations.add(
            _AiDocMutation(
              collection: entry.ref.parent.id,
              docId: entry.ref.id,
              name: _docDisplayName(after) ?? _docDisplayName(old) ?? 'List',
              kind: old == null
                  ? 'create'
                  : after == null
                      ? 'delete'
                      : 'edit',
              before:
                  old == null ? null : _encodeFs(old) as Map<String, dynamic>,
              afterHash: afterHash,
            ),
          );
          if (after == null) {
            tx.delete(entry.ref);
          } else {
            tx.set(entry.ref, after);
          }
        }
        final turn = turnFor(mutations);
        if (mutations.isNotEmpty) {
          tx.set(user, _aiTurnWrite(turn), SetOptions(merge: true));
        }
        return turn;
      });
}

Object? _decodeAiBlob(Blob raw) =>
    jsonDecode(utf8.decode(GZipDecoder().decodeBytes(raw.bytes)));

Map<String, dynamic> _aiTurnWrite(_AiTurnRecord turn) => {
      _aiHistoryRecordsField: {
        turn.id: Blob(
          Uint8List.fromList(
            GZipEncoder().encode(utf8.encode(jsonEncode(turn.toJson())))!,
          ),
        ),
      },
    };

Future<({bool tutorialSeen, List<_AiTurnRecord> turns})> _loadAiUserState(
  DocumentReference<Map<String, dynamic>> user,
) async {
  final snap = await user.get(const GetOptions(source: Source.server));
  final data = snap.data() ?? const <String, dynamic>{};
  final legacy = data[_aiHistoryField] as Blob?;
  final saved = data[_aiHistoryRecordsField] as Map<String, dynamic>?;
  final turns = <String, _AiTurnRecord>{
    if (legacy != null)
      for (final raw in _decodeAiBlob(legacy) as List)
        if (_AiTurnRecord.fromJson(raw) case final turn?) turn.id: turn,
    if (saved != null)
      for (final raw in saved.values)
        if (_AiTurnRecord.fromJson(_decodeAiBlob(raw as Blob)) case final turn?)
          turn.id: turn,
  }.values.toList()
    ..sort((a, b) => b.createdAtMs.compareTo(a.createdAtMs));
  return (tutorialSeen: data[_aiTutorialField] == true, turns: turns);
}

// ---------------------------------------------------------------------------
// Orchestrator Snapshot, Planner Call, & Action Execution
// ---------------------------------------------------------------------------

class _OrchSnapshot {
  _OrchSnapshot({
    required this.today,
    required this.calendars,
    required this.calendarSeries,
    required this.calendarEvents,
    required this.rawEvents,
    required this.activitiesById,
    required this.templatesById,
    required this.draftSources,
  });

  final DateTime today;
  final List<Map<String, dynamic>> calendars;
  final List<Map<String, dynamic>> calendarSeries;
  final List<Map<String, dynamic>> calendarEvents;
  final List<PackReadyCalendarEventStruct> rawEvents;
  final Map<String, PackingListsRecord> activitiesById;
  final Map<String, ChecklistTemplatesRecord> templatesById;
  final List<Map<String, Object>> draftSources;

  Map<String, dynamic> toPayload(String prompt) {
    final activities = <Map<String, dynamic>>[];
    final payload = <String, dynamic>{
      'prompt': prompt,
      'today': _ymd(today),
      'calendars': calendars,
      'calendarSeries': calendarSeries,
      'calendarEvents': calendarEvents,
      'activities': activities,
      'templates': [
        for (final tpl in templatesById.values)
          {
            'id': tpl.reference.id,
            'name': _orchClip(tpl.name, 80),
            'activity': _orchClip(tpl.activity, 40),
            'items': [
              for (final item in tpl.items.take(16))
                if (item.name.trim().isNotEmpty) _orchClip(item.name, 60),
            ],
          },
      ],
    };
    final ordered = [
      for (final doc in activitiesById.values)
        (doc: doc, start: effectiveCalendarActivityDate(doc)),
    ];
    int distance(DateTime? start) => start == null
        ? 1 << 31
        : today.difference(_orchDay(start)).abs().inHours;
    ordered.sort((a, b) => distance(a.start).compareTo(distance(b.start)));
    // Use the callable's snapshot size limit instead of cutting off arbitrary IDs.
    var remaining = 250000 - utf8.encode(jsonEncode(payload)).length;
    for (final (doc: doc, start: start) in ordered) {
      final activity = <String, dynamic>{
        'id': doc.reference.id,
        'tripName': _orchClip(doc.tripName, 80),
        'activity': _orchClip(doc.activity, 40),
        ..._activityTiming(doc, start),
        'recurring': doc.recurring,
        if (doc.snapshotData['location'] is String &&
            (doc.snapshotData['location'] as String).trim().isNotEmpty)
          'location': _orchClip(doc.snapshotData['location'] as String, 80),
        if (doc.snapshotData['calendarSource'] is String)
          'calendarSource': doc.snapshotData['calendarSource'],
        if (doc.snapshotData['calendarId'] is String)
          'calendarId': doc.snapshotData['calendarId'],
        if (doc.snapshotData['calendarEventKey'] is String)
          'calendarEventKey': doc.snapshotData['calendarEventKey'],
        if (doc.snapshotData['calendarEventTitle'] is String)
          'calendarEventTitle': _orchClip(
            doc.snapshotData['calendarEventTitle'] as String,
            80,
          ),
        if (doc.snapshotData['calendarWeekdays'] is List &&
            (doc.snapshotData['calendarWeekdays'] as List).isNotEmpty)
          'calendarWeekdays': doc.snapshotData['calendarWeekdays'],
        if (doc.snapshotData['calendarExcludedDates'] is List &&
            (doc.snapshotData['calendarExcludedDates'] as List).isNotEmpty)
          'calendarExcludedDates': doc.snapshotData['calendarExcludedDates'],
        'items': [
          for (final item in doc.items.take(16))
            if (item.name.trim().isNotEmpty) _orchClip(item.name, 60),
        ],
      };
      remaining -= utf8.encode(jsonEncode(activity)).length + 1;
      if (remaining < 0) break;
      activities.add(activity);
    }
    return payload;
  }
}

Map<String, Object> _activityTiming(
  PackingListsRecord record,
  DateTime? start,
) {
  if (start == null) return {};
  final end = calendarActivityEnd(record);
  final allDay = record.snapshotData['calendarAllDay'] == true ||
      (end == null && start == _orchDay(start));
  return {
    'leaveDate': _ymd(start),
    'allDay': allDay,
    if (!allDay) 'startTime': DateFormat('HH:mm').format(start),
    if (end != null) ...{
      'endDate': _ymd(allDay ? _dayAfter(end, -1) : end),
      if (!allDay) 'endTime': DateFormat('HH:mm').format(end),
    },
  };
}

Future<_OrchSnapshot> _collectOrchestratorSnapshot(
  DocumentReference user,
) async {
  final today = _orchDay(DateTime.now());
  final sync = CalendarSync(user);
  final results = await Future.wait([
    sync.restore(migrate: false).then((_) => sync.savedEvents()),
    _readActivities(user),
    ChecklistTemplatesRecord.collection(user).limit(40).get(),
  ]).timeout(const Duration(seconds: 12));

  final savedCalendar = results[0] as ({
    List<PackReadyCalendarEventStruct> events,
    String? warning,
    String? notice,
  });
  final activityDocs = (results[1] as QuerySnapshot).docs;
  final templateDocs = (results[2] as QuerySnapshot).docs;

  final windowStart = today.subtract(const Duration(days: 14));
  final windowEnd = today.add(const Duration(days: 365));
  final demoEnd = today.add(const Duration(days: 120));

  final rawEvents = <PackReadyCalendarEventStruct>[
    ...savedCalendar.events.where((ev) {
      final start = _orchEventStart(ev);
      return start != null &&
          !start.isBefore(windowStart) &&
          !start.isAfter(windowEnd);
    }),
  ];
  if (sync.example.enabled) {
    final seenDemo = <String>{};
    for (var d = windowStart;
        !d.isAfter(demoEnd);
        d = DateTime(d.year, d.month, d.day + 1)) {
      for (final ev in packReadyDemoCalendar(d)) {
        if (seenDemo.add(ev.id)) rawEvents.add(ev);
      }
    }
  }
  rawEvents.sort((a, b) => a.start.compareTo(b.start));

  final calendars = <Map<String, dynamic>>[
    if (sync.example.enabled)
      {'id': 'demo', 'provider': 'demo', 'name': 'Example Calendar'},
    for (final cal in sync.calendars.where((c) => c.enabled))
      {'id': cal.id, 'provider': cal.provider, 'name': cal.name},
  ];

  final seriesMap = <String, Map<String, dynamic>>{};
  final compactEvents = <Map<String, dynamic>>[];
  for (final ev in rawEvents) {
    final start = _orchEventStart(ev);
    if (start == null) continue;
    final dateStr = _ymd(start);
    if (ev.seriesId.isNotEmpty) {
      final key = '${ev.provider}:${ev.calendarId}:${ev.seriesId}';
      final entry = seriesMap.putIfAbsent(
        key,
        () => {
          'seriesId': ev.seriesId,
          'provider': ev.provider,
          'calendarId': ev.calendarId,
          'calendarName': _orchClip(ev.calendarName, 60),
          'title': _orchClip(ev.title, 80),
          if (ev.location.isNotEmpty) 'location': _orchClip(ev.location, 60),
          'weekdays': <int>{},
          'sampleDates': <String>[],
        },
      );
      (entry['weekdays'] as Set<int>).add(start.weekday);
      final samples = entry['sampleDates'] as List<String>;
      if (!start.isBefore(today) && samples.length < 6) samples.add(dateStr);
    }
    if (!start.isBefore(today) && compactEvents.length < 120) {
      compactEvents.add({
        'eventId': ev.id,
        'seriesId': ev.seriesId,
        'provider': ev.provider,
        'calendarId': ev.calendarId,
        'calendarName': _orchClip(ev.calendarName, 60),
        'title': _orchClip(ev.title, 80),
        'date': dateStr,
        'weekday': start.weekday,
        'allDay': ev.allDay,
        if (!ev.allDay) 'startTime': DateFormat('HH:mm').format(start),
        if (_orchEventEnd(ev, start) case final end?) ...{
          'endDate': _ymd(ev.allDay ? _dayAfter(end, -1) : end),
          if (!ev.allDay) 'endTime': DateFormat('HH:mm').format(end),
        },
        if (ev.location.isNotEmpty) 'location': _orchClip(ev.location, 60),
      });
    }
  }

  final calendarSeries = [
    for (final s in seriesMap.values.take(40))
      {...s, 'weekdays': (s['weekdays'] as Set<int>).toList()..sort()},
  ];

  final activitiesById = <String, PackingListsRecord>{
    for (final doc in activityDocs)
      doc.id: PackingListsRecord.fromSnapshot(doc),
  };
  final templatesById = <String, ChecklistTemplatesRecord>{
    for (final doc in templateDocs)
      doc.id: ChecklistTemplatesRecord.fromSnapshot(doc),
  };

  final draftSources = <Map<String, Object>>[
    for (final tpl in templatesById.values.take(30))
      {
        'id': 'template/${tpl.reference.id}',
        'kind': 'template',
        'name': _orchClip(tpl.name, 100),
        if (tpl.activity.isNotEmpty) 'activity': _orchClip(tpl.activity, 40),
        'items': [
          for (final item in tpl.items.take(16))
            if (item.name.trim().isNotEmpty) _orchClip(item.name, 70),
        ],
      },
    for (final act in activitiesById.values
        .where((a) => a.items.any((i) => i.name.trim().isNotEmpty))
        .take(12))
      {
        'id': 'activity/${act.reference.id}',
        'kind': 'past activity',
        'name': _orchClip(act.tripName, 100),
        if (act.activity.isNotEmpty) 'activity': _orchClip(act.activity, 40),
        if (act.leaveDate != null) 'date': _ymd(act.leaveDate!.toLocal()),
        'items': [
          for (final item in act.items.take(16))
            if (item.name.trim().isNotEmpty) _orchClip(item.name, 70),
        ],
      },
  ];

  return _OrchSnapshot(
    today: today,
    calendars: calendars,
    calendarSeries: calendarSeries,
    calendarEvents: compactEvents,
    rawEvents: rawEvents,
    activitiesById: activitiesById,
    templatesById: templatesById,
    draftSources: draftSources,
  );
}

List<PackItemStruct> _mergeItemStructs(
  List<PackItemStruct> base,
  Iterable<String> addNames, {
  Iterable<String> removeNames = const [],
}) {
  final removals = removeNames.map((s) => s.trim().toLowerCase()).toSet();
  final kept = <PackItemStruct>[];
  final seen = <String>{};
  for (final item in base) {
    final lower = item.name.trim().toLowerCase();
    if (lower.isEmpty || removals.contains(lower) || !seen.add(lower)) continue;
    kept.add(item);
  }
  for (final raw in addNames) {
    final cleaned = _orchClip(raw, 72);
    final lower = cleaned.toLowerCase();
    if (cleaned.isEmpty || removals.contains(lower) || !seen.add(lower)) {
      continue;
    }
    kept.add(PackItemStruct(name: cleaned, packed: false));
  }
  return kept;
}

bool _mentionsTemplate(String prompt, String name) {
  if (name.isEmpty) return false;
  return RegExp(
    '(^|[^\\w])${RegExp.escape(name)}([^\\w]|\$)',
    caseSensitive: false,
  ).hasMatch(prompt);
}

bool _usesTemplate(String prompt, String name) {
  if (name.isEmpty) return false;
  return RegExp(
    r'\b(?:from|using|use|reuse|apply|based on|start with)\s+'
    r'(?:(?:the|my|our|saved|existing|template|checklist)\s+)*'
    '["“\x27]?${RegExp.escape(name)}([^\\w]|\$)',
    caseSensitive: false,
  ).hasMatch(prompt);
}

Future<Map<String, dynamic>> _callSpecialistDraft(
  String draftPrompt,
  String request,
  _OrchSnapshot snapshot,
) async {
  // A named source belongs to the individual action that requested it.
  final sources = snapshot.draftSources.where((source) {
    if (source['kind'] != 'template') return true;
    final name = source['name'] as String;
    return _usesTemplate(request, name) && _usesTemplate(draftPrompt, name);
  }).toList();
  final templateCount =
      sources.where((source) => source['kind'] == 'template').length;
  final result = await FirebaseFunctions.instance
      .httpsCallable(
    'packReadyAiTripDraft',
    options: HttpsCallableOptions(timeout: const Duration(seconds: 40)),
  )
      .call({
    'prompt': templateCount == 0
        ? _orchClip(draftPrompt, 280)
        : 'Name the checklist for its destination. ${_orchClip(draftPrompt, 240)}',
    'today': _ymd(snapshot.today),
    'sources': sources,
    'savedTemplateCount': templateCount,
    'pickSourceItems': true,
  });
  return Map<String, dynamic>.from(result.data as Map);
}

List<PackItemStruct> _itemsFromSpecialistDraft(
  Map<String, dynamic> draft,
  _OrchSnapshot snapshot, {
  List<String> extraItems = const [],
}) {
  final bySource = <String, List<PackItemStruct>>{
    for (final tpl in snapshot.templatesById.values)
      'template/${tpl.reference.id}': tpl.items,
    for (final act in snapshot.activitiesById.values)
      'activity/${act.reference.id}': act.items,
  };
  final picked = draft['sourceItems'];
  final base = <PackItemStruct>[];
  if (picked is List) {
    for (final pick in picked.whereType<Map>()) {
      final sid = pick['sourceId'];
      final name = pick['itemName'];
      if (sid is! String || name is! String) continue;
      final match = bySource[sid]
          ?.where((i) => _orchClip(i.name, 70) == name)
          .firstOrNull;
      if (match != null) {
        base.add(PackItemStruct.fromMap({...match.toMap(), 'packed': false}));
      }
    }
  }
  final starters =
      (draft['starterItems'] as List? ?? const []).whereType<String>();
  return _mergeItemStructs(base, [...starters, ...extraItems]);
}

typedef _CalendarTarget = ({PackReadyCalendarEventStruct event, bool excluded});

List<_CalendarTarget> _resolveCalendarTargets(
  Map<String, dynamic> action,
  _OrchSnapshot snapshot,
) {
  final provider = (action['provider'] as String? ?? '').trim();
  final calendarId = (action['calendarId'] as String? ?? '').trim();
  final seriesId = (action['seriesId'] as String? ?? '').trim();
  final eventId = (action['eventId'] as String? ?? '').trim();
  final titleMatch =
      (action['eventTitleMatch'] as String? ?? '').trim().toLowerCase();
  final scope = (action['scope'] as String? ?? 'series').trim();
  final weekdays = (action['weekdays'] as List? ?? const [])
      .whereType<num>()
      .map((n) => n.toInt())
      .toSet();
  final dates =
      (action['dates'] as List? ?? const []).whereType<String>().toSet();
  final excludedDates = (action['excludedDates'] as List? ?? const [])
      .whereType<String>()
      .toSet();

  bool matchesIdentity(PackReadyCalendarEventStruct ev) {
    if (provider.isNotEmpty && ev.provider != provider) return false;
    if (calendarId.isNotEmpty && ev.calendarId != calendarId) return false;
    if (eventId.isNotEmpty) return ev.id == eventId;
    if (seriesId.isNotEmpty) return ev.seriesId == seriesId;
    // The deployed planner still identifies individual events by exact title.
    return titleMatch.isNotEmpty && ev.title.trim().toLowerCase() == titleMatch;
  }

  return snapshot.rawEvents
      .where((ev) {
        final start = _orchEventStart(ev);
        if (start == null || !matchesIdentity(ev)) return false;
        final dateStr = _ymd(start);
        if (scope == 'dates') return dates.contains(dateStr);
        if (start.isBefore(snapshot.today)) return false;
        return scope != 'weekdays' || weekdays.contains(start.weekday);
      })
      .map(
        (event) => (
          event: event,
          excluded: excludedDates.contains(_ymd(_orchEventStart(event)!)),
        ),
      )
      .toList();
}

Future<_AiTurnRecord?> _runPackReadyOrchestrator(
  DocumentReference user,
  String prompt,
  void Function(String status) onStatus,
  Future<bool> Function(List<_PlanChange> changes) confirm,
) async {
  final createdAtMs = DateTime.now().millisecondsSinceEpoch;
  final turnId = const Uuid().v4();

  onStatus('Reading your calendars, activities, and templates…');
  final snapshot = await _collectOrchestratorSnapshot(user);

  onStatus('Planning actions with PackReady AI…');
  final planRaw = await FirebaseFunctions.instance
      .httpsCallable(
        'packReadyAiOrchestrator',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 45)),
      )
      .call(snapshot.toPayload(prompt));
  final plan = Map<String, dynamic>.from(planRaw.data as Map);
  final summary = (plan['summary'] as String?)?.trim().isNotEmpty == true
      ? (plan['summary'] as String).trim()
      : 'Updated your PackReady checklists.';
  final actions = (plan['actions'] as List? ?? const [])
      .whereType<Map>()
      .map((m) => Map<String, dynamic>.from(m))
      .toList();
  _AiTurnRecord noChanges(String message) => _AiTurnRecord(
        id: turnId,
        prompt: prompt,
        summary: message,
        createdAtMs: createdAtMs,
        undone: false,
        lines: const [],
        mutations: const [],
      );
  if (actions.isEmpty) return noChanges(summary);

  final calendarTargets = {
    for (final (i, action) in actions.indexed)
      if (action['type'] == 'draft_calendar_events')
        i: _resolveCalendarTargets(action, snapshot),
  };
  final canDelete = actions.any(
    (action) => action['type'] == 'delete_activities',
  );
  bool needsCalendarDraft(List<_CalendarTarget> targets) =>
      canDelete ||
      targets.any(
        (target) =>
            !target.excluded &&
            !snapshot.activitiesById.values.any(
              (record) =>
                  _matchesCalendarLink(target.event, record.snapshotData),
            ),
      );

  // Run the specialist drafts needed for this plan in parallel.
  final draftIndices = <int>[
    for (var i = 0; i < actions.length; i++)
      if ((calendarTargets.containsKey(i) &&
              needsCalendarDraft(calendarTargets[i]!)) ||
          actions[i]['type'] == 'draft_activity' ||
          actions[i]['type'] == 'draft_template')
        i,
  ];
  final draftResults = <int, Map<String, dynamic>>{};
  if (draftIndices.isNotEmpty) {
    onStatus(
      draftIndices.length == 1
          ? 'Drafting checklist with specialist AI…'
          : 'Drafting ${draftIndices.length} checklists in parallel…',
    );
    final responses = await Future.wait(
      draftIndices.map(
        (idx) => _callSpecialistDraft(
          actions[idx]['draftPrompt'] as String? ?? '',
          prompt,
          snapshot,
        ),
      ),
    );
    for (var i = 0; i < draftIndices.length; i++) {
      draftResults[draftIndices[i]] = responses[i];
    }
  }

  final journal = _TurnJournal();
  final changes = <_PlanChange>[];
  final plannedItems = <String, List<PackItemStruct>>{};
  final plannedCalendarLinks = <Map<String, dynamic>>[];

  void updateRecord(
    DocumentReference ref,
    Map<String, dynamic> Function(Map<String, dynamic>) fields,
    _PlanChange change,
  ) {
    changes.add(change);
    journal.stage(ref, 'edit', fields);
  }

  void deleteRecord(DocumentReference ref, _PlanChange change) {
    changes.add(change);
    journal.stage(ref, 'delete', (_) => const {});
  }

  void createActivity(
    DocumentReference ref, {
    required _PlanChange change,
    required String title,
    required List<PackItemStruct> items,
    required DateTime start,
    required DateTime? end,
    required bool allDay,
    required bool recurring,
    PackReadyCalendarEventStruct? event,
    String? eventKey,
    List<int>? weekdays,
    List<String>? excludedDates,
  }) {
    changes.add(change);
    final fields = packingListCreationData(
      tripName: title,
      activity: 'Custom',
      leaveDate: start,
      endTime: end,
      calendarAllDay: allDay,
      location: event?.location,
      recurring: recurring,
      items: items,
      calendarEventKey: eventKey,
      calendarId: event?.calendarId,
      calendarEventId: event?.id,
      calendarEventTitle: event?.title,
      calendarSource: event?.provider ?? packReadyCalendarSource,
      calendarWeekdays: weekdays,
      calendarExcludedDates: excludedDates,
    );
    journal.stage(ref, 'create', (_) => fields);
    if (event != null) {
      plannedCalendarLinks.add(fields);
      final targets = recurring
          ? snapshot.rawEvents
              .where((ev) => _matchesCalendarLink(ev, fields))
              .toList()
          : [event];
      journal.calendarConflicts.add(
        (data) =>
            (recurring &&
                _matchesCalendarLink(
                  event,
                  data,
                  ruleWeekdays: weekdays ?? const [],
                )) ||
            targets.any((ev) => _matchesCalendarLink(ev, data)),
      );
    }
  }

  void createTemplate(
    String title,
    String activity,
    List<PackItemStruct> items,
  ) {
    final ref = ChecklistTemplatesRecord.createDoc(user);
    changes.add(
      _PlanChange(
        'Create',
        title,
        'Saved template · ${_itemCount(items.length)}',
        _itemDetails(items),
        icon: 'inventory',
      ),
    );
    final now = Timestamp.now();
    journal.stage(
        ref,
        'create',
        (_) => {
              ...createChecklistTemplatesRecordData(
                name: title,
                activity: activity.isEmpty ? 'Custom' : activity,
                starterName: title,
              ),
              ...mapToFirestore({
                'createdTime': now,
                'updatedTime': now,
                'items': getPackItemListFirestoreData(items),
              }),
            });
  }

  List<ChecklistTemplatesRecord> sourceTemplates(Map<String, dynamic> draft) =>
      [
        for (final sourceId in {
          for (final pick
              in (draft['sourceItems'] as List? ?? const []).whereType<Map>())
            if (pick['sourceId'] case final String id)
              if (id.startsWith('template/')) id.substring(9),
        })
          if (snapshot.templatesById[sourceId] case final template?) template,
      ];

  _PlanChange draftChange(
    List<ChecklistTemplatesRecord> sources,
    String title,
    String target,
    String scope,
    List<PackItemStruct> items, {
    List<PackItemStruct> before = const [],
    List<DateTime> occurrences = const [],
    String? groupKey,
    bool personal = false,
  }) {
    final templateIds =
        sources.map((template) => template.reference.id).toList()..sort();
    return _PlanChange(
      personal ? 'Create' : 'Apply',
      personal || sources.isNotEmpty ? _checklistTitle(target) : title,
      sources.isEmpty
          ? 'Draft checklist'
          : 'Based on ${sources.map((template) => template.name).join(', ')}',
      _deltaDetails(_itemDelta(before, items)),
      icon: 'link',
      target: target,
      targetScope: scope,
      occurrences: occurrences,
      groupKey:
          groupKey == null ? null : jsonEncode([groupKey, ...templateIds]),
    );
  }

  String calendarGroup(PackReadyCalendarEventStruct event) => jsonEncode([
        event.provider,
        event.calendarId,
        event.seriesId.isNotEmpty ? event.seriesId : event.title,
        event.seriesId.isNotEmpty,
      ]);

  _PlanChange activityLink(
    PackingListsRecord record,
    ChecklistTemplatesRecord template,
    bool unlink,
    List<String> details,
  ) {
    final data = record.snapshotData;
    final key = data['calendarEventKey'];
    final isSeries = key is String &&
        (key.startsWith('series:') || key.contains(':series:'));
    final start = record.leaveDate?.toLocal();
    final weekdays = (data['calendarWeekdays'] as List? ?? const []).toSet();
    final excluded =
        (data['calendarExcludedDates'] as List? ?? const []).toSet();
    final dates = isSeries
        ? [
            for (final event in snapshot.rawEvents)
              if (event.seriesId.isNotEmpty &&
                  _orchCalendarEventKey(event, series: true) == key)
                if (_orchEventStart(event) case final date?)
                  if (!date.isBefore(snapshot.today) &&
                      (weekdays.isEmpty || weekdays.contains(date.weekday)) &&
                      !excluded.contains(_ymd(date)))
                    date,
          ]
        : <DateTime>[if (start != null) start];
    dates.sort();
    return _PlanChange(
      unlink ? 'Unlink' : 'Apply',
      unlink ? template.name : _checklistTitle(record.tripName),
      unlink ? 'Remove template items' : 'Based on ${template.name}',
      details,
      icon: unlink ? 'unlink' : 'link',
      target: record.tripName,
      targetScope: isSeries ? 'Recurring series' : 'Existing activity',
      occurrences: dates,
      groupKey: key == null && record.recurring
          ? 'existing-personal/${template.reference.id}'
          : null,
    );
  }

  final lines = <_OrchResultLine>[];
  final deletedActivityIds = <String>{};

  for (var i = 0; i < actions.length; i++) {
    final action = actions[i];
    final type = action['type'] as String? ?? '';
    switch (type) {
      case 'delete_activities':
        final ids = (action['activityIds'] as List? ?? const [])
            .whereType<String>()
            .where((id) => snapshot.activitiesById.containsKey(id))
            .toList();
        if (ids.isEmpty) break;
        for (final id in ids) {
          final record = snapshot.activitiesById[id]!;
          deletedActivityIds.add(id);
          deleteRecord(
            record.reference,
            _PlanChange(
              'Delete',
              record.tripName,
              'Activity · ${_activityScope(record)}',
              _itemDetails(plannedItems[record.reference.path] ?? record.items),
              icon: 'delete',
            ),
          );
        }
        lines.add(
          _OrchResultLine(
            'delete',
            'Deleted ${ids.length} ${ids.length == 1 ? 'activity' : 'activities'}'
                '${(action['label'] as String?)?.isNotEmpty == true ? ' (${action['label']})' : ''}',
          ),
        );

      case 'delete_templates':
        final ids = (action['templateIds'] as List? ?? const [])
            .whereType<String>()
            .where((id) => snapshot.templatesById.containsKey(id))
            .toList();
        if (ids.isEmpty) break;
        for (final id in ids) {
          final tpl = snapshot.templatesById[id]!;
          deleteRecord(
            tpl.reference,
            _PlanChange(
              'Delete',
              tpl.name,
              'Permanently delete saved template',
              _itemDetails(plannedItems[tpl.reference.path] ?? tpl.items),
              icon: 'delete',
            ),
          );
        }
        lines.add(
          _OrchResultLine(
            'delete',
            'Deleted ${ids.length} ${ids.length == 1 ? 'template' : 'templates'}',
          ),
        );

      case 'edit_activity_items':
        final id = action['activityId'] as String?;
        final record = id == null ? null : snapshot.activitiesById[id];
        if (id == null || record == null || deletedActivityIds.contains(id)) {
          break;
        }
        final addItems = (action['addItems'] as List? ?? const [])
            .whereType<String>()
            .toList();
        final removeItems = (action['removeItems'] as List? ?? const [])
            .whereType<String>()
            .toList();
        final before = plannedItems[record.reference.path] ?? record.items;
        final updated = _mergeItemStructs(
          before,
          addItems,
          removeNames: removeItems,
        );
        final delta = _itemDelta(before, updated);
        final details = _deltaDetails(delta);
        if (details.isEmpty) break;
        plannedItems[record.reference.path] = updated;
        final source = _namedTemplate(
          action,
          prompt,
          snapshot,
          addItems,
          removeItems,
        );
        final unlink = source != null && addItems.isEmpty;
        final change = source == null
            ? _PlanChange(
                'Update',
                record.tripName,
                _activityScope(record),
                details,
              )
            : activityLink(record, source, unlink, details);
        updateRecord(record.reference, (live) {
          final items = _applyItemDelta(live, delta);
          return {
            'items': getPackItemListFirestoreData(items),
            'completed': items.isNotEmpty && items.every((item) => item.packed),
          };
        }, change);
        lines.add(
          _OrchResultLine(
            'edit',
            'Updated ${record.tripName} (${addItems.isNotEmpty ? '+${addItems.length}' : ''}'
                '${addItems.isNotEmpty && removeItems.isNotEmpty ? ' / ' : ''}'
                '${removeItems.isNotEmpty ? '-${removeItems.length}' : ''} items)',
          ),
        );

      case 'edit_template_items':
        final id = action['templateId'] as String?;
        final tpl = id == null ? null : snapshot.templatesById[id];
        if (id == null || tpl == null) break;
        final addItems = (action['addItems'] as List? ?? const [])
            .whereType<String>()
            .toList();
        final removeItems = (action['removeItems'] as List? ?? const [])
            .whereType<String>()
            .toList();
        final before = plannedItems[tpl.reference.path] ?? tpl.items;
        final updated = _mergeItemStructs(
          before,
          addItems,
          removeNames: removeItems,
        );
        final delta = _itemDelta(before, updated);
        final details = _deltaDetails(delta);
        if (details.isEmpty) break;
        plannedItems[tpl.reference.path] = updated;
        updateRecord(
          tpl.reference,
          (live) => {
            'items': getPackItemListFirestoreData(_applyItemDelta(live, delta)),
            'updatedTime': Timestamp.now(),
          },
          _PlanChange(
            'Update',
            tpl.name,
            'Edit saved template',
            details,
            icon: 'inventory',
          ),
        );
        lines.add(_OrchResultLine('edit', 'Updated template ${tpl.name}'));

      case 'exclude_calendar_dates':
        final id = action['activityId'] as String?;
        final record = id == null ? null : snapshot.activitiesById[id];
        if (id == null || record == null || deletedActivityIds.contains(id)) {
          break;
        }
        final datesToExclude = (action['dates'] as List? ?? const [])
            .whereType<String>()
            .where((d) => _isoDay(d) != null)
            .toSet();
        if (datesToExclude.isEmpty) break;
        final existingKey =
            record.snapshotData['calendarEventKey'] as String? ?? '';
        final isSeries = existingKey.contains(':series:') ||
            existingKey.startsWith('series:');
        if (!isSeries) {
          final ld = effectiveCalendarActivityDate(record);
          if (ld != null &&
              datesToExclude.length == 1 &&
              datesToExclude.contains(_ymd(ld))) {
            deleteRecord(
              record.reference,
              _PlanChange(
                'Delete',
                record.tripName,
                'Activity · ${_activityScope(record)}',
                _itemDetails(
                  plannedItems[record.reference.path] ?? record.items,
                ),
                icon: 'delete',
                occurrences: [ld],
              ),
            );
            deletedActivityIds.add(id);
            lines.add(
              _OrchResultLine(
                'delete',
                'Removed ${record.tripName} on ${_ymd(ld)}',
              ),
            );
          }
          break;
        }
        final existingExcluded =
            (record.snapshotData['calendarExcludedDates'] as List? ?? const [])
                .whereType<String>()
                .toSet();
        final mergedExcluded = {...existingExcluded, ...datesToExclude}.toList()
          ..sort();
        final update = <String, dynamic>{
          'calendarExcludedDates': mergedExcluded,
        };
        final ld = record.leaveDate?.toLocal();
        if (ld != null && mergedExcluded.contains(_ymd(ld))) {
          final recWeekdays =
              (record.snapshotData['calendarWeekdays'] as List? ?? const [])
                  .whereType<num>()
                  .map((n) => n.toInt())
                  .toSet();
          final replacement = snapshot.rawEvents.where((ev) {
            if (ev.seriesId.isEmpty) return false;
            if (_orchCalendarEventKey(ev, series: true) != existingKey) {
              return false;
            }
            final start = _orchEventStart(ev);
            if (start == null || start.isBefore(snapshot.today)) {
              return false;
            }
            if (mergedExcluded.contains(_ymd(start))) return false;
            return recWeekdays.isEmpty || recWeekdays.contains(start.weekday);
          }).firstOrNull;
          if (replacement != null) {
            final repStart = _orchEventStart(replacement)!;
            final repEnd = _orchEventEnd(replacement, repStart);
            update['leaveDate'] = repStart;
            if (repEnd != null) update['endTime'] = repEnd;
            update['calendarEventId'] = replacement.id;
          }
        }
        final newDates = datesToExclude.difference(existingExcluded);
        if (newDates.isEmpty) break;
        updateRecord(
          record.reference,
          (_) => update,
          _PlanChange(
            'Update',
            record.tripName,
            'Skip calendar dates',
            newDates.map((date) => '− ${_planDate(date)}').toList(),
          ),
        );
        lines.add(
          _OrchResultLine(
            'edit',
            'Skipped ${datesToExclude.length == 1 ? datesToExclude.first : '${datesToExclude.length} dates'} for ${record.tripName}',
          ),
        );

      case 'draft_calendar_events':
        final matched = calendarTargets[i]!;
        final savedLinks = snapshot.activitiesById.values
            .where(
              (record) => !deletedActivityIds.contains(record.reference.id),
            )
            .map((record) => record.snapshotData)
            .toList();
        final unlinked = <PackReadyCalendarEventStruct>[];
        final seen = <(String, String, String)>{};
        var skipped = 0;
        for (final (event: event, excluded: excluded) in matched) {
          if (!seen.add((event.provider, event.calendarId, event.id))) continue;
          final existing = savedLinks
              .where((data) => _matchesCalendarLink(event, data))
              .firstOrNull;
          if (existing != null) {
            changes.add(
              _PlanChange(
                'Already linked',
                event.title,
                [event.calendarName, _docDisplayName(existing)]
                    .whereType<String>()
                    .where((text) => text.isNotEmpty)
                    .join(' · '),
                const [],
                icon: 'link',
                occurrences: [_orchEventStart(event)!],
                groupKey: calendarGroup(event),
              ),
            );
            skipped++;
          } else if (!excluded &&
              !plannedCalendarLinks.any(
                (data) => _matchesCalendarLink(event, data),
              )) {
            unlinked.add(event);
          }
        }
        if (skipped > 0) {
          lines.add(
            _OrchResultLine(
              'skip',
              '$skipped calendar ${skipped == 1 ? 'event was' : 'events were'} already linked.',
            ),
          );
        }
        if (unlinked.isEmpty) break;

        final draft = draftResults[i];
        if (draft == null) break;
        final sources = sourceTemplates(draft);
        final extraItems = (action['extraItems'] as List? ?? const [])
            .whereType<String>()
            .toList();
        final title = _orchClip(
          (draft['title'] as String?) ??
              (action['label'] as String? ?? 'New activity'),
          72,
        );
        final items = _itemsFromSpecialistDraft(
          draft,
          snapshot,
          extraItems: extraItems,
        );
        if (items.isEmpty) break;
        final scope = (action['scope'] as String? ?? 'series').trim();
        final weekdays = ((action['weekdays'] as List? ?? const [])
            .whereType<num>()
            .map((n) => n.toInt())
            .where((d) => d >= 1 && d <= 7)
            .toSet()
            .toList())
          ..sort();
        final excludedDates = ((action['excludedDates'] as List? ?? const [])
            .whereType<String>()
            .where((d) => _isoDay(d) != null)
            .toSet()
            .toList())
          ..sort();

        var created = 0;
        void stageEvents(
          List<PackReadyCalendarEventStruct> events, {
          List<int>? ruleWeekdays,
          List<String>? ruleExclusions,
        }) {
          final first = events.first;
          final start = _orchEventStart(first)!;
          final end = _orchEventEnd(first, start);
          final recurring = ruleWeekdays != null;
          final ref = PackingListsRecord.createDoc(user);
          createActivity(
            ref,
            change: draftChange(
              sources,
              title,
              first.title,
              [
                first.calendarName,
                if (recurring)
                  ruleWeekdays.isEmpty
                      ? 'Recurring series'
                      : ruleWeekdays
                          .map((day) => _weekdays[day - 1])
                          .join(', '),
                if (recurring && excludedDates.isNotEmpty)
                  'Skip ${excludedDates.map(_planDate).join(', ')}',
              ].where((text) => text.isNotEmpty).join(' · '),
              items,
              occurrences:
                  events.map((event) => _orchEventStart(event)!).toList()
                    ..sort(),
              groupKey: calendarGroup(first),
            ),
            title: title,
            items: items,
            start: start,
            end: end,
            allDay: first.allDay,
            recurring: recurring,
            event: first,
            eventKey: _orchCalendarEventKey(first, series: recurring),
            weekdays: ruleWeekdays,
            excludedDates: ruleExclusions,
          );
          created++;
        }

        final bySeries = <String, List<PackReadyCalendarEventStruct>>{};
        for (final event in unlinked) {
          if ((scope == 'series' || scope == 'weekdays') &&
              event.seriesId.isNotEmpty) {
            bySeries.putIfAbsent(calendarGroup(event), () => []).add(event);
          } else {
            stageEvents([event]);
          }
        }
        final ruleWeekdays = scope == 'weekdays' ? weekdays : const <int>[];
        final links = [...savedLinks, ...plannedCalendarLinks];
        for (final series in bySeries.values) {
          final overlapsRule = links.any(
            (data) => _matchesCalendarLink(
              series.first,
              data,
              ruleWeekdays: ruleWeekdays,
            ),
          );
          final group = calendarGroup(series.first);
          final exclusions = {
            ...excludedDates,
            for (final event in snapshot.rawEvents)
              if (calendarGroup(event) == group &&
                  links.any((data) => _matchesCalendarLink(event, data)))
                _ymd(_orchEventStart(event)!),
          };
          if (overlapsRule ||
              series.any(
                (event) => exclusions.contains(_ymd(_orchEventStart(event)!)),
              )) {
            // Fill gaps as individual occurrences when another recurring
            // rule could cover the same weekdays in the future.
            for (final event in series) {
              stageEvents([event]);
            }
          } else {
            stageEvents(
              series,
              ruleWeekdays: ruleWeekdays,
              ruleExclusions: exclusions.toList()..sort(),
            );
          }
        }
        lines.add(
          _OrchResultLine(
            'create',
            'Created $created ${created == 1 ? 'activity' : 'activities'} for $title.',
          ),
        );

      case 'draft_activity':
        final draft = draftResults[i];
        if (draft == null) break;
        final sources = sourceTemplates(draft);
        final title = _orchClip(
          (action['title'] as String?) ??
              (draft['title'] as String?) ??
              'New activity',
          72,
        );
        final items = _itemsFromSpecialistDraft(draft, snapshot);
        if (items.isEmpty) break;
        final excluded = (action['excludedDates'] as List? ?? const [])
            .whereType<String>()
            .toSet();
        final date = _isoDay(action['date']);
        final schedule = action['schedule'] as Map?;
        final rule = _RepeatRule.fromJson(schedule == null
            ? draft['repeatRule']
            : {...schedule, 'startDate': action['date']});
        final first = date ?? _isoDay(draft['activityDate']);
        if (rule == null && first == null) {
          return noChanges('What date or repeat date range should I use?');
        }
        final dates = (rule?.expand() ?? [first!])
            .where((day) => !excluded.contains(_ymd(day)))
            .toList();
        if (dates.isEmpty) break;
        for (final day in dates) {
          final window = rule?.windowOn(day) ??
              _activityWindow(
                day,
                _isoDay(schedule?['endDate']) ?? day,
                _clockMinutes(schedule?['startTime']),
                _clockMinutes(schedule?['endTime']),
              );
          createActivity(
            PackingListsRecord.createDoc(user),
            change: draftChange(
              sources,
              title,
              title,
              'Personal activity · ${_activityWhen(window, repeat: rule != null)}',
              items,
              occurrences: rule == null ? const [] : [day],
              groupKey: rule == null ? null : 'personal/$i',
              personal: true,
            ),
            title: title,
            items: items,
            start: window.start,
            end: window.end,
            allDay: window.allDay,
            recurring: rule != null,
          );
        }
        lines.add(_OrchResultLine(
          'create',
          rule == null
              ? 'Created $title (${items.length} items · ${_ymd(dates.single)})'
              : 'Created $title (${items.length} base items · ${dates.length} dates)',
        ));
        if (action['alsoSaveTemplate'] == true) {
          createTemplate(title, 'Custom', items);
        }

      case 'draft_template':
        final draft = draftResults[i];
        if (draft == null) break;
        final title = _orchClip(
          (draft['title'] as String?) ?? 'New template',
          72,
        );
        final items = _itemsFromSpecialistDraft(draft, snapshot);
        if (items.isEmpty) break;
        final activity = _orchClip(
          (action['activity'] as String?) ?? 'Custom',
          40,
        );
        createTemplate(title, activity, items);
        lines.add(
          _OrchResultLine(
            'create',
            'Created template $title (${items.length} items)',
          ),
        );
    }
  }

  _AiTurnRecord turnFor(List<_AiDocMutation> mutations) => _AiTurnRecord(
        id: turnId,
        prompt: prompt,
        summary: journal.writes.isNotEmpty
            ? summary
            : changes.isEmpty
                ? 'No changes to apply.'
                : 'All matched calendar events are already linked.',
        createdAtMs: createdAtMs,
        undone: false,
        lines: changes.isEmpty ? const [] : lines,
        mutations: mutations,
      );
  if (changes.isEmpty) return turnFor(const []);
  // Leave one write for the durable Undo record in the same transaction.
  if (journal.writes.length > 499) {
    throw FirebaseFunctionsException(
      code: 'invalid-argument',
      message:
          'This plan changes too many records at once. Try a shorter date range.',
    );
  }
  if (!await confirm(_groupPlanChanges(changes))) return null;
  if (journal.writes.isEmpty) return turnFor(const []);
  onStatus('Applying changes to PackReady…');
  return journal.apply(user, turnFor);
}

String _itemCount(int count) => '$count ${count == 1 ? 'item' : 'items'}';

String _checklistTitle(String activity) =>
    activity.toLowerCase().endsWith(' checklist')
        ? activity
        : '$activity checklist';

String _planDate(String iso) {
  final date = _isoDay(iso);
  return date == null ? iso : DateFormat.MMMd().format(date);
}

String _activityScope(PackingListsRecord record) => [
      if (record.leaveDate case final date?)
        DateFormat.MMMd().format(date.toLocal()),
      record.recurring ? 'Recurring activity' : 'Existing activity',
    ].join(' · ');

List<String> _itemDetails(List<PackItemStruct> items) => [
      for (final item in items)
        if (item.name.trim().isNotEmpty)
          item.detail.trim().isEmpty
              ? item.name
              : '${item.name} · ${item.detail}',
    ];

typedef _ItemDelta = ({List<String> add, List<String> remove});

_ItemDelta _itemDelta(List<PackItemStruct> before, List<PackItemStruct> after) {
  final oldNames = before.map((item) => item.name.trim().toLowerCase()).toSet();
  final newNames = after.map((item) => item.name.trim().toLowerCase()).toSet();
  return (
    add: [
      for (final item in after)
        if (!oldNames.contains(item.name.trim().toLowerCase())) item.name,
    ],
    remove: [
      for (final item in before)
        if (item.name.trim().isNotEmpty &&
            !newNames.contains(item.name.trim().toLowerCase()))
          item.name,
    ],
  );
}

List<String> _deltaDetails(_ItemDelta delta) => [
      for (final name in delta.add) '+ $name',
      for (final name in delta.remove) '− $name',
    ];

List<PackItemStruct> _applyItemDelta(
        Map<String, dynamic> live, _ItemDelta delta) =>
    _mergeItemStructs([
      for (final item in (live['items'] as List? ?? const []).whereType<Map>())
        PackItemStruct.fromMap(Map<String, dynamic>.from(item)),
    ], delta.add, removeNames: delta.remove);

ChecklistTemplatesRecord? _namedTemplate(
  Map<String, dynamic> action,
  String prompt,
  _OrchSnapshot snapshot,
  List<String> additions,
  List<String> removals,
) {
  // The deployed planner represents activity links as item edits. Identify the
  // named source only when the proposed item names also match that template.
  if (additions.isNotEmpty && removals.isNotEmpty) return null;
  final requested = [
    ...additions,
    ...removals,
  ].map((name) => name.toLowerCase());
  if (requested.isEmpty) return null;
  final label = (action['label'] as String? ?? '').toLowerCase();
  final request = prompt.toLowerCase();
  final templateIntent = RegExp(r'\b(template|attach|unlink|link)\b');
  if (!templateIntent.hasMatch(label) && !templateIntent.hasMatch(request))
    return null;
  final candidates = snapshot.templatesById.values.where((template) {
    if (!_mentionsTemplate(request, template.name.trim())) return false;
    final names =
        template.items.map((item) => item.name.trim().toLowerCase()).toSet();
    return requested.every(names.contains);
  }).toList();
  return candidates.length == 1 ? candidates.single : null;
}

List<_PlanChange> _groupPlanChanges(List<_PlanChange> changes) {
  final groups = <Object, List<_PlanChange>>{};
  for (final change in changes) {
    final key = change.groupKey == null
        ? change
        : (
            change.groupKey,
            change.action,
            change.title,
            change.target,
            change.targetScope,
            change.isSkipped ? change.scope : null,
            jsonEncode(change.details.toList()..sort()),
          );
    groups.putIfAbsent(key, () => []).add(change);
  }
  return [
    for (final group in groups.values)
      if (group.length == 1)
        group.single
      else
        group.first.withOccurrences(
          [for (final change in group) ...change.occurrences]..sort(),
        ),
  ];
}

String _occurrenceLabel(List<DateTime> dates) {
  if (dates.isEmpty) return '';
  if (dates.length == 1) return DateFormat.MMMd().format(dates.single);
  final first = dates.first;
  final last = dates.last;
  final format =
      first.year == last.year ? DateFormat.MMMd() : DateFormat.yMMMd();
  final start = format.format(first);
  final end = format.format(last);
  final range = start == end ? start : '$start – $end';
  return '${dates.length} occurrences · $range';
}

class _PlanChange {
  const _PlanChange(
    this.action,
    this.title,
    this.scope,
    this.details, {
    this.icon = 'edit',
    this.target,
    this.targetScope,
    this.occurrences = const [],
    this.groupKey,
  });

  final String action;
  final String title;
  final String scope;
  final List<String> details;
  final String icon;
  final String? target;
  final String? targetScope;
  final List<DateTime> occurrences;
  final String? groupKey;

  _PlanChange withOccurrences(List<DateTime> dates) => _PlanChange(
        action,
        title,
        scope,
        details,
        icon: icon,
        target: target,
        targetScope: targetScope,
        occurrences: dates,
      );

  bool get isAdd => action == 'Create' || action == 'Apply';
  bool get isDelete => action == 'Delete';
  bool get isUnlink => action == 'Unlink';
  bool get isSkipped => action == 'Already linked';
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
String _ymd(DateTime day) => day.toIso8601String().split('T').first;
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

typedef _ActivityWindow = ({DateTime start, DateTime end, bool allDay});

_ActivityWindow _activityWindow(
  DateTime first,
  DateTime last,
  int? startClock,
  int? endClock,
) {
  if (startClock == null) {
    return (start: first, end: _dayAfter(last), allDay: true);
  }
  DateTime at(DateTime day, int minutes) =>
      DateTime(day.year, day.month, day.day, minutes ~/ 60, minutes % 60);
  final start = at(first, startClock);
  final end = endClock == null
      ? (last == first ? start.add(const Duration(hours: 1)) : _dayAfter(last))
      : at(last == first && endClock < startClock ? _dayAfter(last) : last,
          endClock);
  return (start: start, end: end, allDay: false);
}

String _activityWhen(_ActivityWindow window, {required bool repeat}) {
  final format = DateFormat.MMMd();
  final start = window.start;
  final end = window.allDay ? _dayAfter(window.end, -1) : window.end;
  final sameDay = _orchDay(start) == _orchDay(end);
  final fromDay = format.format(start);
  final toDay = format.format(end);
  final clock = DateFormat.jm();
  if (window.allDay) {
    if (repeat) return 'All day';
    return sameDay ? '$fromDay · All day' : '$fromDay – $toDay · All day';
  }
  final fromTime = clock.format(start);
  final toTime = clock.format(end);
  if (repeat) return '$fromTime – $toTime${sameDay ? '' : ' next day'}';
  return sameDay
      ? '$fromDay · $fromTime – $toTime'
      : '$fromDay $fromTime – $toDay $toTime';
}

class _RepeatRule {
  _RepeatRule(
    this.weekdays,
    this.start,
    this.end,
    this.startTime,
    this.endTime,
    this.excludeHolidays,
  );
  final List<int> weekdays;
  final DateTime start, end;
  final int? startTime, endTime;
  final bool excludeHolidays;

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
    if (days.isEmpty ||
        days.first < 1 ||
        days.last > 7 ||
        start == null ||
        end == null ||
        (input['startTime'] != null && from == null) ||
        (input['endTime'] != null && to == null) ||
        (to != null && (from == null || from == to)) ||
        end.isBefore(start) ||
        !end.isBefore(_dayAfter(start, 366))) return null;
    return _RepeatRule(
      days,
      start,
      end,
      from,
      to,
      input['excludeHolidays'] as bool,
    );
  }

  _ActivityWindow windowOn(DateTime day) =>
      _activityWindow(day, day, startTime, endTime);

  Iterable<DateTime> expand() sync* {
    final holidays = excludeHolidays
        ? {
            for (var year = start.year - 1; year <= end.year + 1; year++)
              ..._federalHolidays(year),
          }
        : <DateTime, String>{};
    for (var day = start; !day.isAfter(end); day = _dayAfter(day)) {
      if (weekdays.contains(day.weekday) && !holidays.containsKey(day)) {
        yield day;
      }
    }
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
