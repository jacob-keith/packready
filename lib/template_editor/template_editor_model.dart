import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'template_editor_widget.dart' show TemplateEditorWidget;
import 'package:flutter/material.dart';

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

  ///  State fields for stateful widgets in this page.

  // State field(s) for NameField widget.
  FocusNode? nameFieldFocusNode;
  TextEditingController? nameFieldTextController;
  String? Function(BuildContext, String?)? nameFieldTextControllerValidator;
  // State field(s) for ItemNameField widget.
  FocusNode? itemNameFieldFocusNode;
  TextEditingController? itemNameFieldTextController;
  String? Function(BuildContext, String?)? itemNameFieldTextControllerValidator;
  // State field(s) for ItemDetailField widget.
  FocusNode? itemDetailFieldFocusNode;
  TextEditingController? itemDetailFieldTextController;
  String? Function(BuildContext, String?)?
      itemDetailFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFieldFocusNode?.dispose();
    nameFieldTextController?.dispose();

    itemNameFieldFocusNode?.dispose();
    itemNameFieldTextController?.dispose();

    itemDetailFieldFocusNode?.dispose();
    itemDetailFieldTextController?.dispose();
  }
}
