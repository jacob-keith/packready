import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plan_feature_model.dart';
export 'plan_feature_model.dart';

class PlanFeatureWidget extends StatefulWidget {
  const PlanFeatureWidget({
    super.key,
    this.icon,
    Color? color,
    String? text,
  })  : this.color = color ?? const Color(0x00000000),
        this.text = text ?? 'Up to 3 packing template slots';

  final Widget? icon;
  final Color color;
  final String text;

  @override
  State<PlanFeatureWidget> createState() => _PlanFeatureWidgetState();
}

class _PlanFeatureWidgetState extends State<PlanFeatureWidget> {
  late PlanFeatureModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlanFeatureModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget!.icon!,
        Expanded(
          flex: 1,
          child: Text(
            valueOrDefault<String>(
              widget!.text,
              'Up to 3 packing template slots',
            ),
            maxLines: 2,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  lineHeight: 1.6,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
