import '/components/button_widget.dart';
import '/components/pref_section_widget.dart';
import '/components/stat_mini_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel;
  // Model for StatMini.
  late StatMiniModel statMiniModel1;
  // Model for StatMini.
  late StatMiniModel statMiniModel2;
  // Model for StatMini.
  late StatMiniModel statMiniModel3;
  // Model for PrefSection component.
  late PrefSectionModel prefSectionModel1;
  // Model for PrefSection.
  late PrefSectionModel prefSectionModel2;
  // Model for PrefSection.
  late PrefSectionModel prefSectionModel3;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
    statMiniModel1 = createModel(context, () => StatMiniModel());
    statMiniModel2 = createModel(context, () => StatMiniModel());
    statMiniModel3 = createModel(context, () => StatMiniModel());
    prefSectionModel1 = createModel(context, () => PrefSectionModel());
    prefSectionModel2 = createModel(context, () => PrefSectionModel());
    prefSectionModel3 = createModel(context, () => PrefSectionModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
    statMiniModel1.dispose();
    statMiniModel2.dispose();
    statMiniModel3.dispose();
    prefSectionModel1.dispose();
    prefSectionModel2.dispose();
    prefSectionModel3.dispose();
  }
}
