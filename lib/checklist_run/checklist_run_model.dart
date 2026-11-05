import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'checklist_run_widget.dart' show ChecklistRunWidget;
import 'package:flutter/material.dart';

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

  ///  State fields for stateful widgets in this page.

  // State field(s) for ActivityNameField widget.
  FocusNode? activityNameFieldFocusNode;
  TextEditingController? activityNameFieldTextController;
  String? Function(BuildContext, String?)?
      activityNameFieldTextControllerValidator;
  DateTime? datePicked;
  // State field(s) for RepeatChips widget.
  FormFieldController<List<String>>? repeatChipsValueController;
  String? get repeatChipsValue =>
      repeatChipsValueController?.value?.firstOrNull;
  set repeatChipsValue(String? val) =>
      repeatChipsValueController?.value = val != null ? [val] : [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    activityNameFieldFocusNode?.dispose();
    activityNameFieldTextController?.dispose();
  }
}
