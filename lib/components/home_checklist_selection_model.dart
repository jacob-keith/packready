import '/components/home_timeline_checklist_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_checklist_selection_widget.dart' show HomeChecklistSelectionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeChecklistSelectionModel
    extends FlutterFlowModel<HomeChecklistSelectionWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for HomeTimelineChecklist.
  late HomeTimelineChecklistModel homeTimelineChecklistModel;

  @override
  void initState(BuildContext context) {
    homeTimelineChecklistModel =
        createModel(context, () => HomeTimelineChecklistModel());
  }

  @override
  void dispose() {
    homeTimelineChecklistModel.dispose();
  }
}
