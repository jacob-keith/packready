import '/components/plan_feature_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'pricing_card_child2_widget.dart' show PricingCardChild2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PricingCardChild2Model extends FlutterFlowModel<PricingCardChild2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for PlanFeature.
  late PlanFeatureModel planFeatureModel1;
  // Model for PlanFeature.
  late PlanFeatureModel planFeatureModel2;
  // Model for PlanFeature.
  late PlanFeatureModel planFeatureModel3;
  // Model for PlanFeature.
  late PlanFeatureModel planFeatureModel4;
  // Model for PlanFeature.
  late PlanFeatureModel planFeatureModel5;

  @override
  void initState(BuildContext context) {
    planFeatureModel1 = createModel(context, () => PlanFeatureModel());
    planFeatureModel2 = createModel(context, () => PlanFeatureModel());
    planFeatureModel3 = createModel(context, () => PlanFeatureModel());
    planFeatureModel4 = createModel(context, () => PlanFeatureModel());
    planFeatureModel5 = createModel(context, () => PlanFeatureModel());
  }

  @override
  void dispose() {
    planFeatureModel1.dispose();
    planFeatureModel2.dispose();
    planFeatureModel3.dispose();
    planFeatureModel4.dispose();
    planFeatureModel5.dispose();
  }
}
