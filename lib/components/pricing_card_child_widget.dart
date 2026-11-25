import '/components/plan_feature_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pricing_card_child_model.dart';
export 'pricing_card_child_model.dart';

class PricingCardChildWidget extends StatefulWidget {
  const PricingCardChildWidget({super.key});

  @override
  State<PricingCardChildWidget> createState() => _PricingCardChildWidgetState();
}

class _PricingCardChildWidgetState extends State<PricingCardChildWidget> {
  late PricingCardChildModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PricingCardChildModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        wrapWithModel(
          model: _model.planFeatureModel1,
          updateCallback: () => safeSetState(() {}),
          child: PlanFeatureWidget(
            icon: Icon(
              Icons.add,
              color: Colors.transparent,
              size: 0.0,
            ),
            color: Color(0x00000000),
            text: 'Up to 3 packing template slots',
          ),
        ),
        wrapWithModel(
          model: _model.planFeatureModel2,
          updateCallback: () => safeSetState(() {}),
          child: PlanFeatureWidget(
            icon: Icon(
              Icons.add,
              color: Colors.transparent,
              size: 0.0,
            ),
            color: Color(0x00000000),
            text: 'Basic packing templates',
          ),
        ),
        wrapWithModel(
          model: _model.planFeatureModel3,
          updateCallback: () => safeSetState(() {}),
          child: PlanFeatureWidget(
            icon: Icon(
              Icons.add,
              color: Colors.transparent,
              size: 0.0,
            ),
            color: Color(0x00000000),
            text: 'Manual item management',
          ),
        ),
        wrapWithModel(
          model: _model.planFeatureModel4,
          updateCallback: () => safeSetState(() {}),
          child: PlanFeatureWidget(
            icon: Icon(
              Icons.add,
              color: Colors.transparent,
              size: 0.0,
            ),
            color: Color(0x00000000),
            text: 'Share with 1 person',
          ),
        ),
        wrapWithModel(
          model: _model.planFeatureModel5,
          updateCallback: () => safeSetState(() {}),
          child: PlanFeatureWidget(
            icon: Icon(
              Icons.add,
              color: Colors.transparent,
              size: 0.0,
            ),
            color: Color(0x00000000),
            text: 'Save & manage lists',
          ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
