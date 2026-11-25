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
import 'package:firebase_auth/firebase_auth.dart' as auth;

VoidCallback? _stopReminderWatch;

Future<void> watchPackReadyReminders(BuildContext context) async {
  final route = ModalRoute.of(context);
  _stopReminderWatch?.call();

  final state = FFAppState();
  StreamSubscription<auth.User?>? authChanges;
  final stopQueries = <VoidCallback>[];

  void clearQueries() {
    for (final stopQuery in stopQueries) {
      stopQuery();
    }
    stopQueries.clear();
  }

  void stop() {
    clearQueries();
    unawaited(authChanges?.cancel());
    _stopReminderWatch = null;
  }

  void publish(bool alerts, String status,
      [List<PackReadyReminderRowStruct> rows = const []]) {
    state.update(() {
      if (alerts) {
        state.packReadyAlertStatus = status;
        state.packReadyAlerts = rows;
      } else {
        state.packReadySuggestionStatus = status;
        state.packReadySuggestions = rows;
      }
    });
  }

  void watch(String? uid) {
    clearQueries();
    for (final alerts in [true, false]) {
      if (uid == null) {
        publish(alerts, 'ready');
        continue;
      }
      publish(alerts, 'loading');
      final user = UsersRecord.collection.doc(uid);
      final field = alerts ? 'reminderTime' : 'leaveDate';
      final query = PackingListsRecord.collection(user)
          .where(field, isGreaterThanOrEqualTo: DateTime.now())
          .orderBy(field);

      Timer? expiry;
      var records = <PackingListsRecord>[];

      void refresh() {
        expiry?.cancel();
        if (!context.mounted) {
          stop();
          return;
        }
        final now = DateTime.now();
        final rows = <PackReadyReminderRowStruct>[];
        DateTime? nextChange;
        for (final trip in records) {
          final until = alerts ? trip.reminderTime : trip.leaveDate;
          if (until == null || !until.isAfter(now)) continue;
          final reminder = alerts ? null : trip.reminderTime;
          final scheduled =
              reminder != null && reminder.isAfter(now) ? reminder : null;
          final changesAt = scheduled != null && scheduled.isBefore(until)
              ? scheduled
              : until;
          if (nextChange == null || changesAt.isBefore(nextChange))
            nextChange = changesAt;
          if (scheduled != null) continue;

          final title = trip.tripName.trim();
          final activity = trip.activity.trim();
          rows.add(PackReadyReminderRowStruct(
            listRef: trip.reference,
            listPath: trip.reference.path,
            title: title.isNotEmpty
                ? title
                : (activity.isNotEmpty ? activity : 'Untitled activity'),
            note: trip.reminderNote.trim(),
            date: until.toLocal(),
            detail: alerts
                ? dateTimeFormat('MMM d · h:mm a', until.toLocal())
                : [
                    if (activity.isNotEmpty) activity,
                    dateTimeFormat('MMMEd', until.toLocal())
                  ].join(' · '),
          ));
        }
        publish(alerts, 'ready', rows);
        if (nextChange != null) {
          expiry = Timer(nextChange.difference(now), refresh);
        }
      }

      final listener = query.snapshots().listen((snapshot) {
        records = snapshot.docs
            .map((doc) => safeGet(
                  () => PackingListsRecord.fromSnapshot(doc),
                  (error) => debugPrint('Could not read packing list: $error'),
                ))
            .whereType<PackingListsRecord>()
            .toList();
        refresh();
      }, onError: (Object error) {
        expiry?.cancel();
        if (context.mounted) {
          publish(alerts, 'error');
        } else {
          stop();
        }
      });
      stopQueries.add(() {
        expiry?.cancel();
        unawaited(listener.cancel());
      });
    }
  }

  _stopReminderWatch = stop;
  var uid = auth.FirebaseAuth.instance.currentUser?.uid;
  watch(uid);
  authChanges = auth.FirebaseAuth.instance.authStateChanges().listen((user) {
    if (!context.mounted) {
      stop();
      return;
    }
    if (uid == user?.uid) return;
    uid = user?.uid;
    watch(uid);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (identical(_stopReminderWatch, stop) && !context.mounted) stop();
    });
  });
  if (route != null) {
    unawaited(route.popped.then((_) {
      if (!identical(_stopReminderWatch, stop)) return;
      stop();
      publish(true, 'loading');
      publish(false, 'loading');
    }));
  }
}
