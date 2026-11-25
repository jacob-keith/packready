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
import 'package:collection/collection.dart';
import '/auth/firebase_auth/auth_util.dart';

final _packingDrafts = Expando<Map<String, DocumentReference>>(
  'packing list drafts',
);

Future<DocumentReference?> savePackingList(
  BuildContext context,
  String? tripName,
  String? activity,
  DateTime? leaveDate,
  bool? recurring,
  List<PackItemStruct>? items,
) =>
    savePackingListDraft(
      context,
      tripName,
      activity,
      leaveDate,
      recurring,
      items,
    );

Future<DocumentReference?> savePackingListDraft(
  BuildContext context,
  String? tripName,
  String? activity,
  DateTime? leaveDate,
  bool? recurring,
  List<PackItemStruct>? items, {
  String? location,
  PackingListsRecord? editing,
  bool itemsChanged = false,
}) async {
  final user = currentUserReference;
  if (user == null ||
      tripName == null ||
      activity == null ||
      (leaveDate == null && editing == null) ||
      items == null) return null;
  if (editing != null && editing.parentReference != user) return null;
  final ref = editing?.reference ??
      _newPackingListRef(
        context,
        user,
        tripName,
        activity,
        leaveDate!,
        recurring,
        items,
        location,
      );
  try {
    final write = writePackingList(
      ref,
      tripName: tripName,
      activity: activity,
      leaveDate: leaveDate,
      recurring: recurring,
      items: items,
      location: location,
      editing: editing,
      itemsChanged: itemsChanged,
      maxAttempts: editing == null ? 1 : 5,
    );
    if (editing == null) {
      await write.timeout(const Duration(milliseconds: 1700));
    } else {
      await write;
    }
    return ref;
  } on FirebaseException {
    return null;
  } on TimeoutException {
    return null;
  }
}

DocumentReference _newPackingListRef(
  BuildContext context,
  DocumentReference user,
  String tripName,
  String activity,
  DateTime leaveDate,
  bool? recurring,
  List<PackItemStruct> items,
  String? location,
) {
  final draft = jsonEncode([
    user.path,
    tripName,
    activity,
    leaveDate.millisecondsSinceEpoch,
    recurring,
    location,
    getPackItemListFirestoreData(items),
  ]);
  final route = ModalRoute.of(context) ?? context;
  final refs = _packingDrafts[route] ??= {};
  return refs.putIfAbsent(draft, () => PackingListsRecord.createDoc(user));
}

Future<DateTime?> writePackingList(
  DocumentReference ref, {
  required String tripName,
  required String activity,
  required DateTime? leaveDate,
  required bool? recurring,
  required List<PackItemStruct> items,
  String? calendarEventKey,
  String? calendarId,
  String? calendarEventId,
  String? calendarEventTitle,
  String? calendarSource,
  List<int>? calendarWeekdays,
  List<String>? calendarExcludedDates,
  String? location,
  DateTime? endTime,
  bool calendarAllDay = false,
  bool completed = false,
  DateTime? previousLeaveDate,
  PackingListsRecord? editing,
  bool itemsChanged = false,
  int maxAttempts = 5,
}) async {
  final data = packingListCreationData(
    tripName: tripName,
    activity: activity,
    leaveDate: leaveDate,
    recurring: recurring,
    items: items,
    calendarEventKey: calendarEventKey,
    calendarId: calendarId,
    calendarEventId: calendarEventId,
    calendarEventTitle: calendarEventTitle,
    calendarSource: calendarSource,
    calendarWeekdays: calendarWeekdays,
    calendarExcludedDates: calendarExcludedDates,
    location: location,
    endTime: endTime,
    calendarAllDay: calendarAllDay,
    completed: completed,
  );
  final reminder = data['reminderTime'] as DateTime?;

  return FirebaseFirestore.instance.runTransaction<DateTime?>((
    transaction,
  ) async {
    final snapshot = await transaction.get(ref);
    if (editing != null) {
      if (!snapshot.exists) throw StateError('Activity was deleted');
      final saved = PackingListsRecord.fromSnapshot(snapshot);
      final update = <String, dynamic>{
        if (tripName != editing.tripName) 'tripName': data['tripName'],
        if (recurring != editing.recurring) 'recurring': data['recurring'],
        if ((location ?? '') != (editing.snapshotData['location'] ?? ''))
          'location': data['location'] ?? FieldValue.delete(),
      };
      if (leaveDate != null &&
          editing.leaveDate?.isAtSameMomentAs(leaveDate) != true) {
        update['leaveDate'] = data['leaveDate'];
        final oldStart = saved.leaveDate;
        final oldEnd = saved.snapshotData['endTime'] as DateTime?;
        if (oldStart != null && oldEnd != null) {
          update['endTime'] = leaveDate.add(oldEnd.difference(oldStart));
        }
      }
      if (itemsChanged) {
        if (!const ListEquality<PackItemStruct>().equals(
          saved.items,
          editing.items,
        )) {
          throw StateError('Packing items changed');
        }
        update['items'] = data['items'];
      }
      if (update.isNotEmpty) transaction.update(ref, update);
      return null;
    }
    if (snapshot.exists) {
      if (previousLeaveDate == null ||
          leaveDate == null ||
          !leaveDate.isAfter(DateTime.now())) {
        return null;
      }
      final saved = PackingListsRecord.fromSnapshot(snapshot);
      if (saved.leaveDate?.isAtSameMomentAs(previousLeaveDate) != true) {
        return null;
      }
      final restoredReminder = saved.reminderTime == null ? reminder : null;
      transaction.update(
        ref,
        createPackingListsRecordData(
          leaveDate: leaveDate,
          reminderTime: restoredReminder,
        ),
      );
      return restoredReminder;
    }
    transaction.set(ref, data);
    return reminder;
  }, maxAttempts: maxAttempts);
}

Map<String, dynamic> packingListCreationData({
  required String tripName,
  required String activity,
  required DateTime? leaveDate,
  required bool? recurring,
  required List<PackItemStruct> items,
  String? calendarEventKey,
  String? calendarId,
  String? calendarEventId,
  String? calendarEventTitle,
  String? calendarSource,
  List<int>? calendarWeekdays,
  List<String>? calendarExcludedDates,
  String? location,
  DateTime? endTime,
  bool calendarAllDay = false,
  bool completed = false,
}) {
  final reminder =
      leaveDate == null ? null : defaultPackingReminderTime(leaveDate);

  return {
    ...createPackingListsRecordData(
      tripName: tripName,
      activity: activity,
      leaveDate: leaveDate,
      createdTime: DateTime.now(),
      recurring: recurring,
      completed: completed,
      reminderTime: reminder,
    ),
    ...mapToFirestore({'items': getPackItemListFirestoreData(items)}),
    if (calendarEventKey != null) 'calendarEventKey': calendarEventKey,
    if (calendarId != null && calendarId.isNotEmpty) 'calendarId': calendarId,
    if (calendarEventId != null) 'calendarEventId': calendarEventId,
    if (calendarEventTitle != null) 'calendarEventTitle': calendarEventTitle,
    if (calendarSource != null) 'calendarSource': calendarSource,
    if (calendarWeekdays != null && calendarWeekdays.isNotEmpty)
      'calendarWeekdays': calendarWeekdays,
    if (calendarExcludedDates != null && calendarExcludedDates.isNotEmpty)
      'calendarExcludedDates': calendarExcludedDates,
    if (location != null && location.isNotEmpty) 'location': location,
    if (endTime != null) 'endTime': endTime,
    if (calendarAllDay) 'calendarAllDay': true,
  };
}

DateTime? defaultPackingReminderTime(DateTime leaveDate) {
  final minutes = switch (currentUserDocument?.defaultReminder) {
    '30 mins before' => 30,
    '1 hour before leaving' => 60,
    '2 hours before' => 120,
    '1 day before' => 1440,
    _ => null,
  };
  final candidate =
      minutes == null ? null : leaveDate.subtract(Duration(minutes: minutes));
  return candidate != null && candidate.isAfter(DateTime.now())
      ? candidate
      : null;
}
