import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/pricing_card_child2_widget.dart';
import '/components/pricing_card_child_widget.dart';
import '/components/pricing_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'subscription_plans_widget.dart' show SubscriptionPlansWidget;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SubscriptionPlansModel extends FlutterFlowModel<SubscriptionPlansWidget> {
  ///  Local state fields for this page.

  String? planLabel = '';

  String? endDateLabel = '';

  String? playProduct = '';

  bool? showCancel = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in SubscriptionPlans widget.
  List<SubscriptionsRecord>? plans;
  // Model for PricingCard.
  late PricingCardModel pricingCardModel1;
  // Model for PricingCard.
  late PricingCardModel pricingCardModel2;
  // Model for PricingCard.
  late PricingCardModel pricingCardModel3;

  @override
  void initState(BuildContext context) {
    pricingCardModel1 = createModel(context, () => PricingCardModel());
    pricingCardModel2 = createModel(context, () => PricingCardModel());
    pricingCardModel3 = createModel(context, () => PricingCardModel());
  }

  @override
  void dispose() {
    pricingCardModel1.dispose();
    pricingCardModel2.dispose();
    pricingCardModel3.dispose();
  }
}
