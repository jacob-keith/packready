import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/schedule_preset_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'checklist_run_widget.dart' show ChecklistRunWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ChecklistRunModel extends FlutterFlowModel<ChecklistRunWidget> {
  ///  Local state fields for this page.

  List<PackItemStruct> pageItems = [];
  void addToPageItems(PackItemStruct item) => pageItems.add(item);
  void removeFromPageItems(PackItemStruct item) => pageItems.remove(item);
  void removeAtIndexFromPageItems(int index) => pageItems.removeAt(index);
  void insertAtIndexInPageItems(int index, PackItemStruct item) =>
      pageItems.insert(index, item);
  void updatePageItemsAtIndex(int index, Function(PackItemStruct) updateFn) =>
      pageItems[index] = updateFn(pageItems[index]);

  DateTime? leaveDate;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ActivityNameField widget.
  FocusNode? activityNameFieldFocusNode;
  TextEditingController? activityNameFieldTextController;
  String? Function(BuildContext, String?)?
      activityNameFieldTextControllerValidator;
  // Model for SchedulePreset.
  late SchedulePresetModel schedulePresetModel;
  // State field(s) for RepeatChips widget.
  FormFieldController<List<String>>? repeatChipsValueController;
  String? get repeatChipsValue =>
      repeatChipsValueController?.value?.firstOrNull;
  set repeatChipsValue(String? val) =>
      repeatChipsValueController?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - savePackingList] action in CreateActivityFromChecklist widget.
  DocumentReference? goldenSavedList;

  @override
  void initState(BuildContext context) {
    schedulePresetModel = createModel(context, () => SchedulePresetModel());
  }

  @override
  void dispose() {
    activityNameFieldFocusNode?.dispose();
    activityNameFieldTextController?.dispose();

    schedulePresetModel.dispose();
  }
}
