import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'pack_ready_ai_widget.dart' show PackReadyAiWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PackReadyAiModel extends FlutterFlowModel<PackReadyAiWidget> {
  ///  Local state fields for this page.

  bool? aiBusy = false;

  String? aiOwner = '';

  String? aiLoadStatus = 'loading';

  List<PackReadyAiHistoryCardStruct> aiHistory = [];
  void addToAiHistory(PackReadyAiHistoryCardStruct item) => aiHistory.add(item);
  void removeFromAiHistory(PackReadyAiHistoryCardStruct item) =>
      aiHistory.remove(item);
  void removeAtIndexFromAiHistory(int index) => aiHistory.removeAt(index);
  void insertAtIndexInAiHistory(int index, PackReadyAiHistoryCardStruct item) =>
      aiHistory.insert(index, item);
  void updateAiHistoryAtIndex(
          int index, Function(PackReadyAiHistoryCardStruct) updateFn) =>
      aiHistory[index] = updateFn(aiHistory[index]);

  String? aiError = '';

  String? aiUndoId = '';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in PackReadyAi widget.
  PackReadyAiReplyStruct? aiLoaded;
  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in PackReadyAi widget.
  PackReadyAiReplyStruct? aiLoadedTutorial;
  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in AiTutorialButton widget.
  PackReadyAiReplyStruct? aiManualTutorial;
  // State field(s) for AiPrompt widget.
  FocusNode? aiPromptFocusNode;
  TextEditingController? aiPromptTextController;
  String? Function(BuildContext, String?)? aiPromptTextControllerValidator;
  // Stores action output result for [Custom Action - packReadyAiVoice] action in AiRecordPromptButton widget.
  PackReadyAiVoiceResultStruct? aiHeard;
  // Stores action output result for [Custom Action - packReadyAiVoice] action in AiStopRecordingButton widget.
  PackReadyAiVoiceResultStruct? packReadyAiVoiceResult;
  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in AiRunButton widget.
  PackReadyAiReplyStruct? aiRan;
  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in RetryLoadingAiHistory widget.
  PackReadyAiReplyStruct? aiRetried;
  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in RetryLoadingAiHistory widget.
  PackReadyAiReplyStruct? aiRetriedTutorial;
  // Stores action output result for [Custom Action - packReadyAiWorkspaceAction] action in AiUndoButton widget.
  PackReadyAiReplyStruct? aiUndone;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    aiPromptFocusNode?.dispose();
    aiPromptTextController?.dispose();

    packReadyTabBarModel.dispose();
  }
}
