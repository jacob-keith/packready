import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'std_button_model.dart';
export 'std_button_model.dart';

class StdButtonWidget extends StatefulWidget {
  const StdButtonWidget({
    super.key,
    String? variant,
    this.icon,
    String? content,
  })  : this.variant = variant ?? 'outline',
        this.content = content ?? 'Edit Profile';

  final String variant;
  final Widget? icon;
  final String content;

  @override
  State<StdButtonWidget> createState() => _StdButtonWidgetState();
}

class _StdButtonWidgetState extends State<StdButtonWidget> {
  late StdButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StdButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          valueOrDefault<String>(
                    widget.variant,
                    'outline',
                  ) ==
                  'primary'
              ? FlutterFlowTheme.of(context).primary
              : Colors.transparent,
          Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: valueOrDefault<Color>(
            valueOrDefault<String>(
                      widget.variant,
                      'outline',
                    ) ==
                    'outline'
                ? FlutterFlowTheme.of(context).alternate
                : Colors.transparent,
            FlutterFlowTheme.of(context).alternate,
          ),
          width: valueOrDefault<double>(
            valueOrDefault<String>(
                      widget.variant,
                      'outline',
                    ) ==
                    'outline'
                ? 1.0
                : 0.0,
            1.0,
          ),
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional(0.0, 0.0),
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.content,
                    'Edit Profile',
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.spaceGrotesk(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        color: valueOrDefault<Color>(
                          valueOrDefault<String>(
                                    widget.variant,
                                    'outline',
                                  ) ==
                                  'primary'
                              ? FlutterFlowTheme.of(context).primaryBackground
                              : FlutterFlowTheme.of(context).primaryText,
                          FlutterFlowTheme.of(context).primaryText,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        lineHeight: 1.2,
                      ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
          ),
          Container(
            width: 0.0,
            height: 0.0,
          ),
        ],
      ),
    );
  }
}
