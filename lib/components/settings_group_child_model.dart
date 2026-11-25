import '/components/settings_item_widget.dart';
import '/components/settings_switch_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'settings_group_child_widget.dart' show SettingsGroupChildWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsGroupChildModel
    extends FlutterFlowModel<SettingsGroupChildWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SettingsItem.
  late SettingsItemModel settingsItemModel;
  // Model for SettingsSwitch.
  late SettingsSwitchModel settingsSwitchModel1;
  // Model for SettingsSwitch.
  late SettingsSwitchModel settingsSwitchModel2;

  @override
  void initState(BuildContext context) {
    settingsItemModel = createModel(context, () => SettingsItemModel());
    settingsSwitchModel1 = createModel(context, () => SettingsSwitchModel());
    settingsSwitchModel2 = createModel(context, () => SettingsSwitchModel());
  }

  @override
  void dispose() {
    settingsItemModel.dispose();
    settingsSwitchModel1.dispose();
    settingsSwitchModel2.dispose();
  }
}
