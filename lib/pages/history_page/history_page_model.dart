import '/components/stat_mini2_widget.dart';
import '/components/tab_group_widget.dart';
import '/components/trip_log_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'history_page_widget.dart' show HistoryPageWidget;
import 'package:flutter/material.dart';

class HistoryPageModel extends FlutterFlowModel<HistoryPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StatMini.
  late StatMini2Model statMiniModel1;
  // Model for StatMini.
  late StatMini2Model statMiniModel2;
  // Model for StatMini.
  late StatMini2Model statMiniModel3;
  // Model for TabGroup.
  late TabGroupModel tabGroupModel;
  // Model for TripLogItem.
  late TripLogItemModel tripLogItemModel1;
  // Model for TripLogItem.
  late TripLogItemModel tripLogItemModel2;
  // Model for TripLogItem.
  late TripLogItemModel tripLogItemModel3;
  // Model for TripLogItem.
  late TripLogItemModel tripLogItemModel4;
  // Model for TripLogItem.
  late TripLogItemModel tripLogItemModel5;

  @override
  void initState(BuildContext context) {
    statMiniModel1 = createModel(context, () => StatMini2Model());
    statMiniModel2 = createModel(context, () => StatMini2Model());
    statMiniModel3 = createModel(context, () => StatMini2Model());
    tabGroupModel = createModel(context, () => TabGroupModel());
    tripLogItemModel1 = createModel(context, () => TripLogItemModel());
    tripLogItemModel2 = createModel(context, () => TripLogItemModel());
    tripLogItemModel3 = createModel(context, () => TripLogItemModel());
    tripLogItemModel4 = createModel(context, () => TripLogItemModel());
    tripLogItemModel5 = createModel(context, () => TripLogItemModel());
  }

  @override
  void dispose() {
    statMiniModel1.dispose();
    statMiniModel2.dispose();
    statMiniModel3.dispose();
    tabGroupModel.dispose();
    tripLogItemModel1.dispose();
    tripLogItemModel2.dispose();
    tripLogItemModel3.dispose();
    tripLogItemModel4.dispose();
    tripLogItemModel5.dispose();
  }
}
