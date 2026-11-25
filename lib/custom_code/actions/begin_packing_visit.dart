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

import 'package:firebase_analytics/firebase_analytics.dart';

final _visits = Expando<_PackingVisit>();

class _PackingVisit {
  final elapsed = Stopwatch()..start();
  bool? grouped;
  int packed = 0;
  int total = 0;
}

Future<void> beginPackingVisit(
  BuildContext context,
  DocumentReference? listRef,
) async {
  if (!context.mounted || listRef == null) return;
  final route = ModalRoute.of(context);
  if (route == null || _visits[route] != null) return;

  final visit = _visits[route] = _PackingVisit();
  bool isGrouped() =>
      getRemoteConfigBool('group_by_category') && visit.total >= 10;

  void refreshGrouping(AnimationStatus _) {
    if (visit.grouped != null) visit.grouped = isGrouped();
  }

  final coverAnimation = route.secondaryAnimation;
  coverAnimation?.addStatusListener(refreshGrouping);
  final subscription = PackingListsRecord.getDocument(listRef).listen(
    (list) {
      visit.total = list.items.length;
      visit.grouped ??= isGrouped();
    },
    onError: (Object _) {},
  );

  // Completion waits for the exit animation and covers system back.
  unawaited(route.completed.then((_) {
    _visits[route] = null;
    coverAnimation?.removeStatusListener(refreshGrouping);
    unawaited(subscription.cancel());
    final grouped = visit.grouped;
    if (grouped == null) return;
    _packingMetric('items_packed_per_visit', {
      'items_packed': visit.packed,
      'total_items': visit.total,
      'group_by_category': grouped ? 'true' : 'false',
    });
  }));
}

void recordPackingVisitCheck(
  BuildContext context,
  bool wasPacked,
  int totalItems,
) {
  if (wasPacked) return;
  final route = ModalRoute.of(context);
  final visit = route == null ? null : _visits[route];
  if (visit == null) return;
  visit.total = totalItems;
  if (++visit.packed == 1) {
    final grouped = visit.grouped ??=
        getRemoteConfigBool('group_by_category') && totalItems >= 10;
    _packingMetric('first_item_packed', {
      'seconds_to_first_check': visit.elapsed.elapsedMilliseconds / 1000,
      'total_items': totalItems,
      'group_by_category': grouped ? 'true' : 'false',
    });
  }
}

void _packingMetric(String event, Map<String, Object> parameters) {
  unawaited(
    FirebaseAnalytics.instance
        .logEvent(name: event, parameters: parameters)
        .catchError((Object _) {}),
  );
}
