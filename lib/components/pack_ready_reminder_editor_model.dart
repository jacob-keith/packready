import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'pack_ready_reminder_editor_widget.dart'
    show PackReadyReminderEditorWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PackReadyReminderEditorModel
    extends FlutterFlowModel<PackReadyReminderEditorWidget> {
  ///  Local state fields for this component.

  DateTime? pickedDate;

  bool? saving = false;

  String? saveError = '';

  ///  State fields for stateful widgets in this component.

  // State field(s) for ReminderActivity widget.
  String? reminderActivityValue;
  FormFieldController<String>? reminderActivityValueController;
  DateTime? datePicked;
  // State field(s) for ReminderNote widget.
  FocusNode? reminderNoteFocusNode;
  TextEditingController? reminderNoteTextController;
  String? Function(BuildContext, String?)? reminderNoteTextControllerValidator;
  // Stores action output result for [Custom Action - writePackReadyReminder] action in SaveReminder widget.
  PackReadyReminderWriteResultStruct? savedReminder;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reminderNoteFocusNode?.dispose();
    reminderNoteTextController?.dispose();
  }
}
