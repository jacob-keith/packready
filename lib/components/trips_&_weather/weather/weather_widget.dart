import '/backend/api_requests/api_calls.dart';
import '/components/trips_&_weather/weathericon/weathericon_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'weather_model.dart';
export 'weather_model.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late WeatherModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeatherModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('WEATHER_COMP_weather_ON_INIT_STATE');
      _model.apiResultedz = await WeatherCall.call();

      if ((_model.apiResultedz?.succeeded ?? true)) {
        FFAppState().isLoadingWeather = false;
        safeSetState(() {});
      }
      if (!FFAppState().isLoadingWeather) {
        FFAppState().conditioncode = (getJsonField(
          (_model.apiResultedz?.jsonBody ?? ''),
          r'''$.daily.weather_code''',
          true,
        ) as List?)!
            .cast<int>()
            .toList()
            .cast<int>();
        FFAppState().weatherhi = (getJsonField(
          (_model.apiResultedz?.jsonBody ?? ''),
          r'''$.daily.temperature_2m_max''',
          true,
        ) as List?)!
            .cast<double>()
            .toList()
            .cast<double>();
        FFAppState().weatherlo = (getJsonField(
          (_model.apiResultedz?.jsonBody ?? ''),
          r'''$.daily.temperature_2m_min''',
          true,
        ) as List?)!
            .cast<double>()
            .toList()
            .cast<double>();
        FFAppState().weatherdate = (getJsonField(
          (_model.apiResultedz?.jsonBody ?? ''),
          r'''$.daily.time''',
          true,
        ) as List?)!
            .map<String>((e) => e.toString())
            .toList()
            .cast<String>()
            .toList()
            .cast<String>();
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).accent3,
      ),
      child: Visibility(
        visible: !FFAppState().isLoadingWeather,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: (FFMainAxisAlignment.spaceBetween).flutterValue,
            crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: wrapWithModel(
                  model: _model.weathericonModel1,
                  updateCallback: () => safeSetState(() {}),
                  child: WeathericonWidget(
                    day: functions
                        .isoDateToWeekday(FFAppState().weatherdate.firstOrNull),
                    condition: functions
                        .convertWmo(FFAppState().conditioncode.firstOrNull),
                    low: formatNumber(
                      FFAppState().weatherlo.firstOrNull,
                      formatType: FormatType.custom,
                      format: '###',
                      locale: '',
                    ),
                    high: formatNumber(
                      FFAppState().weatherhi.firstOrNull,
                      formatType: FormatType.custom,
                      format: '###',
                      locale: '',
                    ),
                    image: functions
                        .fetchMeteocons(FFAppState().conditioncode.firstOrNull),
                  ),
                ),
              ),
              Flexible(
                child: wrapWithModel(
                  model: _model.weathericonModel2,
                  updateCallback: () => safeSetState(() {}),
                  child: WeathericonWidget(
                    day: functions.isoDateToWeekday(
                        FFAppState().weatherdate.elementAtOrNull(1)),
                    condition: functions.convertWmo(
                        FFAppState().conditioncode.elementAtOrNull(1)),
                    low: formatNumber(
                      FFAppState().weatherlo.elementAtOrNull(1),
                      formatType: FormatType.custom,
                      format: '###',
                      locale: '',
                    ),
                    high: formatNumber(
                      FFAppState().weatherhi.elementAtOrNull(1),
                      formatType: FormatType.custom,
                      format: '###',
                      locale: '',
                    ),
                    image: functions.fetchMeteocons(
                        FFAppState().conditioncode.elementAtOrNull(1)),
                  ),
                ),
              ),
              Flexible(
                child: wrapWithModel(
                  model: _model.weathericonModel3,
                  updateCallback: () => safeSetState(() {}),
                  child: WeathericonWidget(
                    day: functions
                        .isoDateToWeekday(FFAppState().weatherdate.lastOrNull),
                    condition: functions
                        .convertWmo(FFAppState().conditioncode.lastOrNull),
                    low: formatNumber(
                      FFAppState().weatherlo.lastOrNull,
                      formatType: FormatType.custom,
                      format: '###',
                      locale: '',
                    ),
                    high: formatNumber(
                      FFAppState().weatherhi.lastOrNull,
                      formatType: FormatType.custom,
                      format: '###',
                      locale: '',
                    ),
                    image: functions
                        .fetchMeteocons(FFAppState().conditioncode.lastOrNull),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
