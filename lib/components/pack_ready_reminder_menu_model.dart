import '/backend/schema/structs/index.dart';
import '/components/pack_ready_reminder_editor_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'pack_ready_reminder_menu_widget.dart' show PackReadyReminderMenuWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PackReadyReminderMenuModel
    extends FlutterFlowModel<PackReadyReminderMenuWidget> {
  ///  Local state fields for this component.

  bool? removing = false;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - writePackReadyReminder] action in RemoveReminderOption widget.
  PackReadyReminderWriteResultStruct? removedReminder;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
