import '/components/switch_component4_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'settings_switch_widget.dart' show SettingsSwitchWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsSwitchModel extends FlutterFlowModel<SettingsSwitchWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Switch.
  late SwitchComponent4Model switchModel;

  @override
  void initState(BuildContext context) {
    switchModel = createModel(context, () => SwitchComponent4Model());
  }

  @override
  void dispose() {
    switchModel.dispose();
  }
}
