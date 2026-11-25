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
import '/backend/push_notifications/push_notifications_util.dart';

Future<PackReadyReminderWriteResultStruct> writePackReadyReminder(
  String operation,
  String? listPath,
  DateTime? due,
  String? note,
) async {
  PackReadyReminderWriteResultStruct result(String status, [String? message]) =>
      PackReadyReminderWriteResultStruct(status: status, message: message);

  final user = currentUserReference;
  if (user == null) return result('error', 'Sign in to manage reminders.');
  final id = listPath?.split('/').last;
  if (id == null || id.isEmpty) {
    return result('error', 'Choose an activity.');
  }

  try {
    final ref = PackingListsRecord.createDoc(user, id: id);
    if (ref.path != listPath) return result('error', 'Choose an activity.');
    if (operation == 'remove') {
      await ref.update({
        'reminderTime': FieldValue.delete(),
        'reminderNote': FieldValue.delete(),
      });
      return result('saved');
    }

    final now = DateTime.now();
    final trip = await PackingListsRecord.getDocumentOnce(ref);
    if (operation == 'suggest') {
      final existing = trip.reminderTime;
      if (existing != null && existing.isAfter(now)) {
        return PackReadyReminderWriteResultStruct(
          status: 'edit',
          date: existing.toLocal(),
          note: trip.reminderNote,
        );
      }
      due = trip.leaveDate?.subtract(const Duration(days: 1));
      if (due == null || !due.isAfter(now)) return result('new');
      note = trip.reminderNote;
    } else if (due == null) {
      return result('error', 'Choose a date and time.');
    } else if (!due.isAfter(now)) {
      return result('error', 'Choose a time in the future.');
    }

    // The previous editor writes the record first, then queues the FlutterFlow
    // notification. A note-only edit keeps the existing notification.
    await ref
        .update({'reminderTime': due, 'reminderNote': (note ?? '').trim()});
    if (trip.reminderTime?.isAtSameMomentAs(due) ?? false)
      return result('saved');

    try {
      final title = trip.tripName.trim();
      final activity = trip.activity.trim();
      await FirebaseFirestore.instance
          .collection(kUserPushNotificationsCollectionName)
          .add({
        'notification_title': title.isNotEmpty
            ? title
            : (activity.isNotEmpty ? activity : 'Untitled activity'),
        'notification_text': 'Finish packing for your trip.',
        'scheduled_time': due,
        'notification_sound': 'default',
        'user_refs': user.path,
        'initial_page_name': 'PackingList',
        'parameter_data': serializeParameterData({'listRef': ref}),
        'sender': user,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return result('saved');
    } catch (_) {
      return result('queueWarning',
          'Reminder saved. The push notification could not be queued.');
    }
  } catch (_) {
    return result(
        'error',
        switch (operation) {
          'remove' => 'Could not remove the reminder. Try again.',
          'suggest' => 'Could not add the reminder. Try again.',
          _ =>
            'Could not save the reminder. Check your connection and try again.',
        });
  }
}
