// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class SubscriptionPlanLabel extends StatefulWidget {
  const SubscriptionPlanLabel({super.key, this.width, this.height, this.uid});
  final double? width;
  final double? height;
  final String? uid;

  @override
  State<SubscriptionPlanLabel> createState() => _SubscriptionPlanLabelState();
}

class _SubscriptionPlanLabelState extends State<SubscriptionPlanLabel> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? plans;

  void bindPlan() {
    final uid = widget.uid;
    plans = uid == null || uid.isEmpty
        ? null
        : FirebaseFirestore.instance
            .collection('subscriptions')
            .where('uid', isEqualTo: uid)
            .limit(1)
            .snapshots();
  }

  @override
  void initState() {
    super.initState();
    bindPlan();
  }

  @override
  void didUpdateWidget(SubscriptionPlanLabel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid) bindPlan();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      key: ValueKey(widget.uid),
      stream: plans,
      builder: (context, snapshot) {
        var label = plans == null || snapshot.hasError ? 'Unavailable' : '…';
        if (!snapshot.hasError && snapshot.hasData) {
          final docs = snapshot.data!.docs;
          final data = docs.isEmpty ? null : docs.first.data();
          final until = data?['premiumUntil'];
          label = functions.effectivePlan(data?['billingPlan'] as String?,
              until is Timestamp ? until.toDate() : null, DateTime.now());
        }
        final theme = FlutterFlowTheme.of(context);
        return Text(label,
            style: theme.bodyMedium.copyWith(color: theme.secondaryText));
      },
    );
  }
}
