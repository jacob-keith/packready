import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/button2_widget.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/components/settings_group_child2_widget.dart';
import '/components/settings_group_child3_widget.dart';
import '/components/settings_group_child_widget.dart';
import '/components/settings_group_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  Local state fields for this page.

  bool dailyReminderEnabled = true;

  bool darkModeEnabled = true;

  ///  State fields for stateful widgets in this page.

  // Model for SettingsGroup.
  late SettingsGroupModel settingsGroupModel1;
  // Model for SettingsGroup.
  late SettingsGroupModel settingsGroupModel2;
  // Model for SettingsGroup.
  late SettingsGroupModel settingsGroupModel3;
  // Model for Button.
  late Button2Model buttonModel;
  // Model for PackReadyTabBar component.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    settingsGroupModel1 = createModel(context, () => SettingsGroupModel());
    settingsGroupModel2 = createModel(context, () => SettingsGroupModel());
    settingsGroupModel3 = createModel(context, () => SettingsGroupModel());
    buttonModel = createModel(context, () => Button2Model());
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    settingsGroupModel1.dispose();
    settingsGroupModel2.dispose();
    settingsGroupModel3.dispose();
    buttonModel.dispose();
    packReadyTabBarModel.dispose();
  }
}
