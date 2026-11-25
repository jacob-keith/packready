import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/schedule_preset_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'activity_editor_widget.dart' show ActivityEditorWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ActivityEditorModel extends FlutterFlowModel<ActivityEditorWidget> {
  ///  Local state fields for this page.

  String? activityStatus = 'loading';

  NativeActivityDraftStruct? activityDraft;
  void updateActivityDraftStruct(Function(NativeActivityDraftStruct) updateFn) {
    updateFn(activityDraft ??= NativeActivityDraftStruct());
  }

  List<PackItemStruct> activityItems = [];
  void addToActivityItems(PackItemStruct item) => activityItems.add(item);
  void removeFromActivityItems(PackItemStruct item) =>
      activityItems.remove(item);
  void removeAtIndexFromActivityItems(int index) =>
      activityItems.removeAt(index);
  void insertAtIndexInActivityItems(int index, PackItemStruct item) =>
      activityItems.insert(index, item);
  void updateActivityItemsAtIndex(
          int index, Function(PackItemStruct) updateFn) =>
      activityItems[index] = updateFn(activityItems[index]);

  bool? activityHasDate = false;

  bool? activityRecurring = false;

  bool? activitySaving = false;

  DateTime? leaveDate;

  PackItemStruct? editingItem;
  void updateEditingItemStruct(Function(PackItemStruct) updateFn) {
    updateFn(editingItem ??= PackItemStruct());
  }

  int? editingItemIndex = -2;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - loadNativeActivity] action in ActivityEditor widget.
  NativeActivityDraftStruct? loadedActivity;
  // State field(s) for ActivityName widget.
  FocusNode? activityNameFocusNode;
  TextEditingController? activityNameTextController;
  String? Function(BuildContext, String?)? activityNameTextControllerValidator;
  // State field(s) for ActivityLocation widget.
  FocusNode? activityLocationFocusNode;
  TextEditingController? activityLocationTextController;
  String? Function(BuildContext, String?)?
      activityLocationTextControllerValidator;
  // State field(s) for SetActivityDate widget.
  bool? setActivityDateValue;
  // Model for SchedulePreset.
  late SchedulePresetModel schedulePresetModel;
  // State field(s) for EditPackingItemName widget.
  FocusNode? editPackingItemNameFocusNode;
  TextEditingController? editPackingItemNameTextController;
  String? Function(BuildContext, String?)?
      editPackingItemNameTextControllerValidator;
  // Stores action output result for [Custom Action - saveNativeActivity] action in SaveNativeActivity widget.
  DocumentReference? savedActivity;
  // Stores action output result for [Custom Action - loadNativeActivity] action in RetryLoadingActivity widget.
  NativeActivityDraftStruct? loadedActivity2;

  @override
  void initState(BuildContext context) {
    schedulePresetModel = createModel(context, () => SchedulePresetModel());
  }

  @override
  void dispose() {
    activityNameFocusNode?.dispose();
    activityNameTextController?.dispose();

    activityLocationFocusNode?.dispose();
    activityLocationTextController?.dispose();

    schedulePresetModel.dispose();
    editPackingItemNameFocusNode?.dispose();
    editPackingItemNameTextController?.dispose();
  }
}
