import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'reminder_editor_widget.dart' show ReminderEditorWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReminderEditorModel extends FlutterFlowModel<ReminderEditorWidget> {
  ///  Local state fields for this component.

  DocumentReference? selectedList;

  DateTime? reminderDate;

  ///  State fields for stateful widgets in this component.

  DateTime? datePicked;
  // State field(s) for ReminderNoteField widget.
  FocusNode? reminderNoteFieldFocusNode;
  TextEditingController? reminderNoteFieldTextController;
  String? Function(BuildContext, String?)?
      reminderNoteFieldTextControllerValidator;
  // Stores action output result for [Custom Action - readPackingTripName] action in btn_SaveReminder widget.
  String? packingTripName;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reminderNoteFieldFocusNode?.dispose();
    reminderNoteFieldTextController?.dispose();
  }
}
