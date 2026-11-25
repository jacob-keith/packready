import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/components/schedule_preset_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'activities_widget.dart' show ActivitiesWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ActivitiesModel extends FlutterFlowModel<ActivitiesWidget> {
  ///  Local state fields for this page.

  DateTime? leaveDate;

  bool? scheduleStep = false;

  bool? activityRecurring = false;

  bool? activitySaving = false;

  bool? createAiDraftOpen = false;

  bool? createAiDraftBusy = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for CreateStarterTabs widget.
  TabController? createStarterTabsController;
  int get createStarterTabsCurrentIndex => createStarterTabsController != null
      ? createStarterTabsController!.index
      : 0;
  int get createStarterTabsPreviousIndex => createStarterTabsController != null
      ? createStarterTabsController!.previousIndex
      : 0;

  // State field(s) for CustomItemName widget.
  FocusNode? customItemNameFocusNode;
  TextEditingController? customItemNameTextController;
  String? Function(BuildContext, String?)?
      customItemNameTextControllerValidator;
  // State field(s) for CreateAiDraftPrompt widget.
  FocusNode? createAiDraftPromptFocusNode;
  TextEditingController? createAiDraftPromptTextController;
  String? Function(BuildContext, String?)?
      createAiDraftPromptTextControllerValidator;
  // Stores action output result for [Custom Action - nativeChecklistDictation] action in RecordDraftPrompt widget.
  String? nativeChecklistTranscript;
  // Stores action output result for [Custom Action - nativeChecklistDictation] action in StopDraftRecording widget.
  String? nativeChecklistDictationResult;
  // State field(s) for ActivityName widget.
  FocusNode? activityNameFocusNode;
  TextEditingController? activityNameTextController;
  String? Function(BuildContext, String?)? activityNameTextControllerValidator;
  // State field(s) for ActivityLocation widget.
  FocusNode? activityLocationFocusNode;
  TextEditingController? activityLocationTextController;
  String? Function(BuildContext, String?)?
      activityLocationTextControllerValidator;
  // Model for SchedulePreset.
  late SchedulePresetModel schedulePresetModel;
  // Stores action output result for [Custom Action - saveNativeActivity] action in SaveNativeActivity widget.
  DocumentReference? savedActivity;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    schedulePresetModel = createModel(context, () => SchedulePresetModel());
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    createStarterTabsController?.dispose();
    customItemNameFocusNode?.dispose();
    customItemNameTextController?.dispose();

    createAiDraftPromptFocusNode?.dispose();
    createAiDraftPromptTextController?.dispose();

    activityNameFocusNode?.dispose();
    activityNameTextController?.dispose();

    activityLocationFocusNode?.dispose();
    activityLocationTextController?.dispose();

    schedulePresetModel.dispose();
    packReadyTabBarModel.dispose();
  }
}
