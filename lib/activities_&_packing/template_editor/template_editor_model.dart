import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'template_editor_widget.dart' show TemplateEditorWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TemplateEditorModel extends FlutterFlowModel<TemplateEditorWidget> {
  ///  Local state fields for this page.

  List<PackItemStruct> tItems = [];
  void addToTItems(PackItemStruct item) => tItems.add(item);
  void removeFromTItems(PackItemStruct item) => tItems.remove(item);
  void removeAtIndexFromTItems(int index) => tItems.removeAt(index);
  void insertAtIndexInTItems(int index, PackItemStruct item) =>
      tItems.insert(index, item);
  void updateTItemsAtIndex(int index, Function(PackItemStruct) updateFn) =>
      tItems[index] = updateFn(tItems[index]);

  List<PackItemStruct> remainingAiItems = [];
  void addToRemainingAiItems(PackItemStruct item) => remainingAiItems.add(item);
  void removeFromRemainingAiItems(PackItemStruct item) =>
      remainingAiItems.remove(item);
  void removeAtIndexFromRemainingAiItems(int index) =>
      remainingAiItems.removeAt(index);
  void insertAtIndexInRemainingAiItems(int index, PackItemStruct item) =>
      remainingAiItems.insert(index, item);
  void updateRemainingAiItemsAtIndex(
          int index, Function(PackItemStruct) updateFn) =>
      remainingAiItems[index] = updateFn(remainingAiItems[index]);

  bool? hasAiDraft = false;

  bool? showAiPrompt = false;

  bool? aiGenerating = false;

  bool? modifyPromptOpen = false;

  bool? modifyPromptBusy = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - openCalendarAiEditor] action in TemplateEditor widget.
  AiEditorDraftStruct? calendarAiPrefill;
  // State field(s) for NameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldTextController;
  String? Function(BuildContext, String?)? nameFieldTextControllerValidator;
  // State field(s) for ModifyChecklistPrompt widget.
  FocusNode? modifyChecklistPromptFocusNode;
  TextEditingController? modifyChecklistPromptTextController;
  String? Function(BuildContext, String?)?
      modifyChecklistPromptTextControllerValidator;
  // Stores action output result for [Custom Action - nativeChecklistDictation] action in RecordChecklistPrompt widget.
  String? nativeChecklistTranscript;
  // Stores action output result for [Custom Action - nativeChecklistDictation] action in StopChecklistRecording widget.
  String? nativeChecklistDictationResult;
  // Stores action output result for [Custom Action - modifyNativeChecklist] action in ApplyChecklistModification widget.
  AiEditorDraftStruct? nativeModifiedChecklist;
  // State field(s) for AiDraftPrompt widget.
  FocusNode? aiDraftPromptFocusNode;
  TextEditingController? aiDraftPromptTextController;
  String? Function(BuildContext, String?)? aiDraftPromptTextControllerValidator;
  // Stores action output result for [Custom Action - generateAiEditorDraft] action in AiGenerateButton widget.
  AiEditorDraftStruct? liveAiDraft;
  // Stores action output result for [Custom Action - generateAiEditorDraft] action in AiSampleButton widget.
  AiEditorDraftStruct? sampleAiDraft;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // State field(s) for AiDraftLocation widget.
  FocusNode? aiDraftLocationFocusNode;
  TextEditingController? aiDraftLocationTextController;
  String? Function(BuildContext, String?)?
      aiDraftLocationTextControllerValidator;
  // State field(s) for AiAlsoSaveTemplate widget.
  bool? aiAlsoSaveTemplateValue;
  // State field(s) for ItemNameField widget.
  FocusNode? itemNameFieldFocusNode;
  TextEditingController? itemNameFieldTextController;
  String? Function(BuildContext, String?)? itemNameFieldTextControllerValidator;
  // State field(s) for ItemDetailField widget.
  FocusNode? itemDetailFieldFocusNode;
  TextEditingController? itemDetailFieldTextController;
  String? Function(BuildContext, String?)?
      itemDetailFieldTextControllerValidator;
  // State field(s) for PackingItemCategory widget.
  FormFieldController<List<String>>? packingItemCategoryValueController;
  String? get packingItemCategoryValue =>
      packingItemCategoryValueController?.value?.firstOrNull;
  set packingItemCategoryValue(String? val) =>
      packingItemCategoryValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFieldFocusNode?.dispose();
    nameFieldTextController?.dispose();

    modifyChecklistPromptFocusNode?.dispose();
    modifyChecklistPromptTextController?.dispose();

    aiDraftPromptFocusNode?.dispose();
    aiDraftPromptTextController?.dispose();

    aiDraftLocationFocusNode?.dispose();
    aiDraftLocationTextController?.dispose();

    itemNameFieldFocusNode?.dispose();
    itemNameFieldTextController?.dispose();

    itemDetailFieldFocusNode?.dispose();
    itemDetailFieldTextController?.dispose();
  }
}
