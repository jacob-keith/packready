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
    show generateTemplateAiDraft;

Future<void> openNativeTemplateDraft(
  BuildContext context,
  bool generate,
  int starterIndex,
  String prompt,
) async {
  final String activity;
  final String title;
  final List<PackItemStruct> items;
  if (generate) {
    FocusScope.of(context).unfocus();
    final draft = await generateTemplateAiDraft(context, prompt);
    if (!context.mounted || draft.title.isEmpty) return;
    activity = 'Custom';
    title = draft.title;
    items = draft.items;
  } else {
    final app = FFAppState();
    activity = const ['Gym', 'Travel', 'Camping', 'Custom'][starterIndex];
    app.selectedActivity = activity;
    title = 'My $activity checklist';
    items = switch (activity) {
      'Gym' => app.gymItems,
      'Travel' => app.travelItems,
      'Camping' => app.campingItems,
      _ => app.customItems,
    };
  }
  await context.pushNamed<void>(
    'TemplateEditor',
    queryParameters: {
      'startName': serializeParam(title, ParamType.String),
      'startActivity': serializeParam(activity, ParamType.String),
      'startStarter': serializeParam(activity, ParamType.String),
      'startItems': serializeParam(
        items,
        ParamType.DataStruct,
        isList: true,
      ),
    }.withoutNulls,
    extra: {
      'startAiExtras': const <PackItemStruct>[],
      'startFromAiDraft': false,
    },
  );
}
