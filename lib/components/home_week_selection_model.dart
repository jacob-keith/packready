import '/components/home_timeline_week_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_week_selection_widget.dart' show HomeWeekSelectionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeWeekSelectionModel extends FlutterFlowModel<HomeWeekSelectionWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for HomeTimelineWeek.
  late HomeTimelineWeekModel homeTimelineWeekModel;

  @override
  void initState(BuildContext context) {
    homeTimelineWeekModel = createModel(context, () => HomeTimelineWeekModel());
  }

  @override
  void dispose() {
    homeTimelineWeekModel.dispose();
  }
}
