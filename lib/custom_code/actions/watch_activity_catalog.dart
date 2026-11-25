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
import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/widgets/calendar_event_list.dart'
    show
        calendarActivityTitles,
        effectiveCalendarActivityDate,
        ensureCalendarSessionLoaded,
        linkedCalendarActivityTitle;

final _catalogStops = Expando<VoidCallback>();

Future<void> watchActivityCatalog(BuildContext context, bool templates) async {
  final lifetime = ModalRoute.of(context);
  if (lifetime == null) return;
  _catalogStops[lifetime]?.call();
  final app = FFAppState();
  final subscriptions = <StreamSubscription>[];
  StreamSubscription<User?>? auth;
  final categories = ['Gym', 'Travel', 'Camping', 'Custom'];
  VoidCallback stopTitles = () {};
  bool active = true;
  int revision = 0;

  void emit(String status, [List<NativeActivityRowStruct> rows = const []]) {
    if (!active || !context.mounted) return;
    app.update(() {
      if (templates) {
        app.nativeTemplates = rows;
        app.nativeTemplatesStatus = status;
      } else {
        app.nativeActivities = rows;
        app.nativeActivitiesStatus = status;
      }
    });
  }

  String itemKey(PackItemStruct item) =>
      jsonEncode([item.name, item.detail, item.packed]);

  void watch(DocumentReference? user) {
    final token = ++revision;
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
    subscriptions.clear();
    stopTitles();
    stopTitles = () {};
    if (user == null) {
      emit('signedOut');
      return;
    }
    emit('loading');
    void error(Object error) {
      if (token == revision) emit('error');
    }

    if (!templates) {
      List<PackingListsRecord>? records;
      void update() {
        final lists = records;
        if (token != revision || lists == null) return;
        emit('ready', [
          for (final list in lists)
            (() {
              final eventTitle = linkedCalendarActivityTitle(list);
              final date = effectiveCalendarActivityDate(list);
              final total = list.items.length;
              final packed = list.items.where((item) => item.packed).length;
              return NativeActivityRowStruct(
                listRef: list.reference,
                title: eventTitle ?? list.tripName,
                shareName: list.tripName,
                subtitle: eventTitle == null ? list.activity : list.tripName,
                activity: list.activity,
                items: list.items,
                editable: list.reference.id.startsWith('shared_'),
                trailing: '$packed of $total packed',
                dateLabel: date == null
                    ? ''
                    : (date.isBefore(DateTime.now()) ? 'left ' : 'leaves ') +
                        dateTimeFormat('MMMEd', date),
              );
            })(),
        ]);
      }

      calendarActivityTitles.addListener(update);
      stopTitles = () => calendarActivityTitles.removeListener(update);
      ensureCalendarSessionLoaded(user);
      subscriptions.add(
        PackingListsRecord.collection(user).snapshots().listen((snapshot) {
          final epoch = DateTime.fromMillisecondsSinceEpoch(0);
          records = snapshot.docs.map(PackingListsRecord.fromSnapshot).toList()
            ..sort((a, b) {
              final newest = (b.createdTime ?? b.leaveDate ?? epoch)
                  .compareTo(a.createdTime ?? a.leaveDate ?? epoch);
              return newest == 0
                  ? a.reference.id.compareTo(b.reference.id)
                  : newest;
            });
          update();
        }, onError: error),
      );
      return;
    }

    List<ChecklistTemplatesRecord>? saved;
    UsersRecord? profile;
    bool profileReady = false;
    bool? hasPackingLists;
    void update() {
      final records = saved;
      if (token != revision || !profileReady || records == null) return;
      final showStarters = profile?.activities.isEmpty ?? true;
      final rows = <NativeActivityRowStruct>[];
      final seen = <String>{};
      for (final category in categories) {
        var first = true;
        for (final record in records.where(
          (record) => record.activity == category,
        )) {
          final signature = jsonEncode([
            record.name.trim(),
            category,
            record.items.map(itemKey).toList(),
          ]);
          if (!record.reference.id.startsWith('shared_') &&
              !seen.add(signature)) continue;
          rows.add(
            NativeActivityRowStruct(
              templateRef: record.reference,
              title: record.name,
              shareName: record.name,
              subtitle:
                  '$category · ' + record.items.length.toString() + ' items',
              activity: category,
              starter: record.starterName,
              items: record.items,
              trailing: 'Use ›',
              heading: first ? category : '',
            ),
          );
          first = false;
        }
      }
      if (showStarters) {
        for (final entry in <String, List<PackItemStruct>>{
          'Gym': app.gymItems,
          'Travel': app.travelItems,
          'Camping': app.campingItems,
        }.entries) {
          final signature = jsonEncode(entry.value.map(itemKey).toList());
          if (records.any(
            (record) =>
                record.activity == entry.key &&
                jsonEncode(record.items.map(itemKey).toList()) == signature,
          )) continue;
          rows.add(
            NativeActivityRowStruct(
              title: entry.key + ' checklist',
              shareName: entry.key + ' checklist',
              subtitle:
                  entry.key + ' · ' + entry.value.length.toString() + ' items',
              activity: entry.key,
              starter: entry.key,
              items: entry.value,
              trailing: 'Use ›',
            ),
          );
        }
      }
      emit(
        rows.isEmpty && !showStarters && hasPackingLists == false
            ? 'first'
            : 'ready',
        rows,
      );
    }

    subscriptions.add(
      ChecklistTemplatesRecord.collection(
        user,
      ).where('activity', whereIn: categories).snapshots().listen((snapshot) {
        saved =
            snapshot.docs.map(ChecklistTemplatesRecord.fromSnapshot).toList();
        update();
      }, onError: error),
    );
    subscriptions.add(
      user.snapshots().listen((snapshot) {
        profile = snapshot.exists ? UsersRecord.fromSnapshot(snapshot) : null;
        profileReady = true;
        update();
      }, onError: error),
    );
    subscriptions.add(
      PackingListsRecord.collection(
        user,
      ).limit(1).snapshots(includeMetadataChanges: true).listen((snapshot) {
        if (!snapshot.metadata.isFromCache || snapshot.docs.isNotEmpty) {
          hasPackingLists = snapshot.docs.isNotEmpty;
          update();
        }
      }, onError: (Object _) {}),
    );
  }

  void stop() {
    active = false;
    ++revision;
    auth?.cancel();
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
    stopTitles();
  }

  _catalogStops[lifetime] = stop;
  unawaited(
    lifetime.popped.then((_) {
      if (!identical(_catalogStops[lifetime], stop)) return;
      stop();
      _catalogStops[lifetime] = null;
    }),
  );
  var owner = currentUserReference;
  watch(owner);
  auth = FirebaseAuth.instance.authStateChanges().listen((user) {
    final next = user == null ? null : UsersRecord.collection.doc(user.uid);
    if (next == owner || !active) return;
    owner = next;
    watch(next);
  });
}
