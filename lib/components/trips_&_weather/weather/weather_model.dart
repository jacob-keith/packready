import '/backend/api_requests/api_calls.dart';
import '/components/trips_&_weather/weathericon/weathericon_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'weather_widget.dart' show WeatherWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WeatherModel extends FlutterFlowModel<WeatherWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (weather)] action in weather widget.
  ApiCallResponse? apiResultedz;
  // Model for weathericon component.
  late WeathericonModel weathericonModel1;
  // Model for weathericon component.
  late WeathericonModel weathericonModel2;
  // Model for weathericon component.
  late WeathericonModel weathericonModel3;

  @override
  void initState(BuildContext context) {
    weathericonModel1 = createModel(context, () => WeathericonModel());
    weathericonModel2 = createModel(context, () => WeathericonModel());
    weathericonModel3 = createModel(context, () => WeathericonModel());
  }

  @override
  void dispose() {
    weathericonModel1.dispose();
    weathericonModel2.dispose();
    weathericonModel3.dispose();
  }
}
