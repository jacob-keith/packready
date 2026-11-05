import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pref_section_component_model.dart';
export 'pref_section_component_model.dart';

class PrefSectionComponentWidget extends StatefulWidget {
  const PrefSectionComponentWidget({
    super.key,
    this.parameter1,
    String? parameter2,
    String? parameter3,
    bool? parameter4,
    required this.onHeaderTap,
  })  : this.parameter2 = parameter2 ?? 'Packing Defaults',
        this.parameter3 = parameter3 ?? 'Carry-on, 3-5 days',
        this.parameter4 = parameter4 ?? true;

  final Widget? parameter1;
  final String parameter2;
  final String parameter3;
  final bool parameter4;
  final Future Function()? onHeaderTap;

  @override
  State<PrefSectionComponentWidget> createState() =>
      _PrefSectionComponentWidgetState();
}

class _PrefSectionComponentWidgetState
    extends State<PrefSectionComponentWidget> {
  late PrefSectionComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrefSectionComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        logFirebaseEvent('PREF_SECTION_COMPONENT_Container_ON_TAP');
        await widget.onHeaderTap?.call();
      },
      child: Container(
        decoration: BoxDecoration(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7DCD4),
                    borderRadius: BorderRadius.circular(8.0),
                    shape: BoxShape.rectangle,
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: widget.parameter1!,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.parameter2,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                      Text(
                        widget.parameter3,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                              lineHeight: 1.5,
                            ),
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
                Container(
                  width: 20.0,
                  height: 20.0,
                  child: Stack(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    children: [
                      if (valueOrDefault<bool>(
                        widget.parameter4 ? true : false,
                        true,
                      ))
                        Icon(
                          Icons.expand_less_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                      if (valueOrDefault<bool>(
                        widget.parameter4 ? false : true,
                        false,
                      ))
                        Icon(
                          Icons.expand_more_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                    ],
                  ),
                ),
              ].divide(SizedBox(width: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
