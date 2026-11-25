// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/generate_ai_editor_draft.dart'
    show setPendingAiChecklistModifyPrompt, modifyAiEditorDraft;

Future<AiEditorDraftStruct> modifyNativeChecklist(
  BuildContext context,
  String prompt,
  String currentName,
  List<PackItemStruct> currentItems,
) async {
  FocusScope.of(context).unfocus();
  setPendingAiChecklistModifyPrompt(context, prompt.trim());
  return modifyAiEditorDraft(context, currentName, currentItems);
}
