import '/components/plan_feature_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pricing_card_child2_model.dart';
export 'pricing_card_child2_model.dart';

class PricingCardChild2Widget extends StatefulWidget {
  const PricingCardChild2Widget({super.key});

  @override
  State<PricingCardChild2Widget> createState() =>
      _PricingCardChild2WidgetState();
}

class _PricingCardChild2WidgetState extends State<PricingCardChild2Widget> {
  late PricingCardChild2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PricingCardChild2Model());

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
            text: 'Unlimited template slots',
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
            text: 'AI-powered packing suggestions',
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
            text: 'Advanced customization',
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
            text: 'Unlimited sharing',
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
            text: 'All Free Tier features',
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x1A00B894),
                borderRadius: BorderRadius.circular(8.0),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Or \$24.99/year (Save 30%)',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.spaceGrotesk(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).success,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                          lineHeight: 1.2,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
