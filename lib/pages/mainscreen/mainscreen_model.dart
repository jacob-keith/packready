import '/components/checklist_widget_widget.dart';
import '/components/pack_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'mainscreen_widget.dart' show MainscreenWidget;
import 'package:flutter/material.dart';

class MainscreenModel extends FlutterFlowModel<MainscreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PackHeader component.
  late PackHeaderModel packHeaderModel;
  // Model for Gym_Group.
  late ChecklistWidgetModel gymGroupModel;
  // Model for Travel_Group.
  late ChecklistWidgetModel travelGroupModel;
  // Model for Camping_Group.
  late ChecklistWidgetModel campingGroupModel;
  // Model for Custom_widget.
  late ChecklistWidgetModel customWidgetModel;

  @override
  void initState(BuildContext context) {
    packHeaderModel = createModel(context, () => PackHeaderModel());
    gymGroupModel = createModel(context, () => ChecklistWidgetModel());
    travelGroupModel = createModel(context, () => ChecklistWidgetModel());
    campingGroupModel = createModel(context, () => ChecklistWidgetModel());
    customWidgetModel = createModel(context, () => ChecklistWidgetModel());
  }

  @override
  void dispose() {
    packHeaderModel.dispose();
    gymGroupModel.dispose();
    travelGroupModel.dispose();
    campingGroupModel.dispose();
    customWidgetModel.dispose();
  }
}
