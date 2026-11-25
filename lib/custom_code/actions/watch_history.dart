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
import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';

VoidCallback? _stopHistoryWatch;

Future<void> watchHistory(BuildContext context) async {
  final pageLifetime = ModalRoute.of(context)?.popped;
  if (pageLifetime == null) return;
  _stopHistoryWatch?.call();

  final state = FFAppState();
  StreamSubscription<List<HistoryTripStruct>>? trips;
  StreamSubscription<User?>? auth;
  var active = true;

  void publish(String status, [List<HistoryTripStruct> rows = const []]) {
    if (!active || !context.mounted) return;
    state.update(() {
      state.historyStatus = status;
      state.historyTrips = rows;
    });
  }

  void watch(DocumentReference? owner) {
    trips?.cancel();
    if (owner == null) {
      publish('signedOut');
      return;
    }
    publish('loading');
    // The un-ordered query includes legacy trips with missing creation dates.
    // The generated query helper consumes Firestore errors before callers see them.
    trips = PackingListsRecord.collection(owner).snapshots().map((snapshot) {
      final records =
          snapshot.docs.map(PackingListsRecord.fromSnapshot).toList();
      int date(PackingListsRecord t) =>
          (t.createdTime ?? t.leaveDate)?.millisecondsSinceEpoch ?? 0;
      records.sort((a, b) {
        final newest = date(b).compareTo(date(a));
        return newest == 0 ? a.reference.id.compareTo(b.reference.id) : newest;
      });
      return records.map((trip) {
        final name = trip.tripName.trim();
        final activity = trip.activity.trim();
        final when = trip.leaveDate?.toLocal();
        final total = trip.items.length;
        final packed = trip.items.where((item) => item.packed).length;
        final complete = trip.completed || (total > 0 && packed == total);
        return HistoryTripStruct(
          listRef: trip.reference,
          title: name.isEmpty ? 'Packing list' : name,
          activity: activity,
          details: [
            if (activity.isNotEmpty) activity,
            if (when != null) dateTimeFormat('MMM d, y', when),
          ].join(' · '),
          itemCount: total,
          progress: total == 0 ? '0 items' : '$packed of $total packed',
          complete: complete,
          status: complete
              ? 'Packed'
              : packed > 0
                  ? 'In progress'
                  : 'To pack',
        );
      }).toList();
    }).listen((rows) => publish('ready', rows),
        onError: (Object _) => publish('error'));
  }

  void stop() {
    active = false;
    trips?.cancel();
    auth?.cancel();
  }

  _stopHistoryWatch = stop;
  unawaited(pageLifetime.then((_) {
    if (!identical(_stopHistoryWatch, stop)) return;
    stop();
    _stopHistoryWatch = null;
    state.historyTrips = [];
    state.historyStatus = 'loading';
  }));
  var currentOwner = currentUserReference;
  watch(currentOwner);
  auth = FirebaseAuth.instance.authStateChanges().listen((user) {
    final owner = user == null ? null : UsersRecord.collection.doc(user.uid);
    if (owner == currentOwner) return;
    currentOwner = owner;
    watch(owner);
  });
}
