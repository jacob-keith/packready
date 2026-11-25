import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/components/trips_&_weather/weather/weather_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'testpage_widget.dart' show TestpageWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TestpageModel extends FlutterFlowModel<TestpageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for weather component.
  late WeatherModel weatherModel;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    weatherModel = createModel(context, () => WeatherModel());
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    weatherModel.dispose();
    packReadyTabBarModel.dispose();
  }
}
