import '/components/navigation/tab_item/tab_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'tab_group_widget.dart' show TabGroupWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TabGroupModel extends FlutterFlowModel<TabGroupWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for AllTrips.
  late TabItemModel allTripsModel;
  // Model for Business.
  late TabItemModel businessModel;
  // Model for Leisure.
  late TabItemModel leisureModel;
  // Model for Gym.
  late TabItemModel gymModel;
  // Model for TabItem.
  late TabItemModel tabItemModel;

  @override
  void initState(BuildContext context) {
    allTripsModel = createModel(context, () => TabItemModel());
    businessModel = createModel(context, () => TabItemModel());
    leisureModel = createModel(context, () => TabItemModel());
    gymModel = createModel(context, () => TabItemModel());
    tabItemModel = createModel(context, () => TabItemModel());
  }

  @override
  void dispose() {
    allTripsModel.dispose();
    businessModel.dispose();
    leisureModel.dispose();
    gymModel.dispose();
    tabItemModel.dispose();
  }
}
