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

import 'package:collection/collection.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/custom_code/actions/load_native_activity.dart'
    show nativeActivitySnapshot;
import '/custom_code/actions/save_packing_list.dart';
import '/index.dart';

Future<DocumentReference?> saveNativeActivity(
  BuildContext context,
  bool? editing,
  bool? hasDate,
  String? name,
  String? location,
  DateTime? date,
  bool? recurring,
  List<PackItemStruct>? items,
) async {
  final isEditing = editing == true;
  final useDate = hasDate == true;
  final isRecurring = recurring == true;
  final cleanName = (name ?? '').trim();
  final cleanLocation = (location ?? '').trim();
  final user = currentUserReference;
  final record = isEditing ? nativeActivitySnapshot(context) : null;
  if (user == null || cleanName.isEmpty || (isEditing && record == null))
    return null;
  final linked =
      (record?.snapshotData['calendarEventKey'] as String?)?.isNotEmpty == true;
  final leave = linked ? record?.leaveDate : (useDate ? date : null);
  if (!isEditing && leave == null) return null;
  final app = FFAppState();
  final activity = record?.activity ?? app.selectedActivity;
  final selected = isEditing
      ? (items ?? const <PackItemStruct>[])
      : switch (activity) {
          'Gym' => app.gymItems,
          'Travel' => app.travelItems,
          'Camping' => app.campingItems,
          _ => app.customItems,
        };
  final DocumentReference? ref;
  try {
    ref = await savePackingListDraft(
      context,
      cleanName,
      activity,
      leave,
      linked ? record!.recurring : isRecurring,
      selected,
      location: cleanLocation,
      editing: record,
      itemsChanged: record != null &&
          !const ListEquality<PackItemStruct>().equals(selected, record.items),
    );
  } on StateError {
    return null;
  }
  if (!isEditing && ref != null) {
    final due = defaultPackingReminderTime(leave!);
    if (due != null) {
      triggerPushNotification(
        notificationTitle: cleanName,
        notificationText: 'Finish packing for your trip.',
        scheduledTime: due,
        notificationSound: 'default',
        userRefs: [user],
        initialPageName: PackingListWidget.routeName,
        parameterData: {'listRef': ref},
      );
    }
  }
  return ref;
}
