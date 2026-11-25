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

import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/widgets/calendar_event_list.dart'
    show linkedCalendarActivityTitle;

final _snapshots = Expando<PackingListsRecord>();

PackingListsRecord? nativeActivitySnapshot(BuildContext context) =>
    _snapshots[ModalRoute.of(context) ?? context];

Future<NativeActivityDraftStruct> loadNativeActivity(
  BuildContext context,
  DocumentReference? listRef,
) async {
  final route = ModalRoute.of(context) ?? context;
  _snapshots[route] = null;
  final user = currentUserReference;
  if (user == null ||
      listRef == null ||
      listRef.parent.id != 'packingLists' ||
      listRef.parent.parent != user) {
    return NativeActivityDraftStruct();
  }
  try {
    final snapshot = await listRef.get();
    if (!snapshot.exists || !context.mounted || currentUserReference != user)
      return NativeActivityDraftStruct();
    final record = PackingListsRecord.fromSnapshot(snapshot);
    _snapshots[route] = record;
    final data = record.snapshotData;
    final linked = (data['calendarEventKey'] as String?)?.isNotEmpty == true;
    final allDay = data['calendarAllDay'] == true;
    final start = record.leaveDate;
    final end = data['endTime'] as DateTime?;
    final title = linkedCalendarActivityTitle(record);
    final provider = switch (data['calendarSource']) {
      'google' => 'Google Calendar',
      'apple' => 'Apple Calendar',
      'demo' => 'Demo calendar',
      _ => 'Calendar',
    };
    final days = [
      for (final day
          in (data['calendarWeekdays'] as List? ?? []).whereType<int>())
        if (day >= 1 && day <= 7)
          const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day - 1],
    ];
    String schedule(DateTime value) => dateTimeFormat(
          allDay ? 'EEE, MMM d, y' : 'EEE, MMM d, y, h:mm a',
          value.toLocal(),
        );
    return NativeActivityDraftStruct(
      ok: true,
      name: record.tripName,
      location: data['location'] as String? ?? '',
      activity: record.activity,
      linked: linked,
      date: start?.toLocal(),
      hasDate: start != null,
      recurring: record.recurring,
      items: record.items,
      calendarTitle: title == null ? provider : '$provider · $title',
      calendarStart: start == null
          ? ''
          : 'Starts ' + schedule(start) + (allDay ? ' · All day' : ''),
      calendarEnd: end == null || allDay ? '' : 'Ends ' + schedule(end),
      calendarRepeat: days.isNotEmpty
          ? 'Repeats ' + days.join(', ')
          : (record.recurring ? 'Recurring' : 'One-time'),
    );
  } catch (_) {
    return NativeActivityDraftStruct();
  }
}
