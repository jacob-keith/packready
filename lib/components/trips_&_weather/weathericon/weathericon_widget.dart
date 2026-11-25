import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'weathericon_model.dart';
export 'weathericon_model.dart';

class WeathericonWidget extends StatefulWidget {
  const WeathericonWidget({
    super.key,
    this.day,
    this.condition,
    this.low,
    this.high,
    this.image,
  });

  final String? day;
  final String? condition;
  final String? low;
  final String? high;
  final String? image;

  @override
  State<WeathericonWidget> createState() => _WeathericonWidgetState();
}

class _WeathericonWidgetState extends State<WeathericonWidget> {
  late WeathericonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeathericonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: (FFMainAxisAlignment.spaceBetween).flutterValue,
        crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            valueOrDefault<String>(
              widget!.day,
              'Mon',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.manrope(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SvgPicture.network(
              widget!.image!,
              width: 75.0,
              height: 75.0,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: AutoSizeText(
              valueOrDefault<String>(
                widget!.condition,
                'Clear',
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              minFontSize: 12.0,
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    font: GoogleFonts.manrope(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleLarge.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
            ),
          ),
          Text(
            '${formatNumber(
              (int.parse((widget!.low!)) + int.parse((widget!.high!))) / 2.0,
              formatType: FormatType.custom,
              format: '###',
              locale: '',
            )}°F',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).headlineLarge.override(
                  font: GoogleFonts.manrope(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineLarge.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: (FFMainAxisAlignment.spaceEvenly).flutterValue,
            children: [
              Text(
                '${widget!.low}°F',
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      font: GoogleFonts.spaceGrotesk(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).weatherLowInk,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
              ),
              Text(
                '${widget!.high}°F',
                style: FlutterFlowTheme.of(context).labelMedium.override(
                      font: GoogleFonts.spaceGrotesk(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).weatherHighInk,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
              ),
            ],
          ),
        ].divide(SizedBox(height: 5.0)).around(SizedBox(height: 5.0)),
      ),
    );
  }
}
