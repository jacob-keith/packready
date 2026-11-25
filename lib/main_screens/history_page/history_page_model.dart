import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'history_page_widget.dart' show HistoryPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HistoryPageModel extends FlutterFlowModel<HistoryPageWidget> {
  ///  Local state fields for this page.

  int totalItems = 0;

  String selectedCategory = 'All Trips';

  ///  State fields for stateful widgets in this page.

  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    packReadyTabBarModel.dispose();
  }
}
