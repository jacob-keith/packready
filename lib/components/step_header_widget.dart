import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'step_header_model.dart';
export 'step_header_model.dart';

class StepHeaderWidget extends StatefulWidget {
  const StepHeaderWidget({
    super.key,
    String? subtitle,
    String? title,
  })  : this.subtitle = subtitle ?? 'Personalize your packing experience.',
        this.title = title ?? 'Profile Setup';

  final String subtitle;
  final String title;

  @override
  State<StepHeaderWidget> createState() => _StepHeaderWidgetState();
}

class _StepHeaderWidgetState extends State<StepHeaderWidget> {
  late StepHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepHeaderModel());

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget.title,
            'Profile Setup',
          ),
          style: FlutterFlowTheme.of(context).headlineLarge.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight:
                    FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                lineHeight: 1.25,
              ),
        ),
        Text(
          valueOrDefault<String>(
            widget.subtitle,
            'Personalize your packing experience.',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.6,
              ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
