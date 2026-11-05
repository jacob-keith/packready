import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'packing_list_widget.dart' show PackingListWidget;
import 'package:flutter/material.dart';

class PackingListModel extends FlutterFlowModel<PackingListWidget> {
  ///  Local state fields for this page.

  List<PackItemStruct> pageItems = [];
  void addToPageItems(PackItemStruct item) => pageItems.add(item);
  void removeFromPageItems(PackItemStruct item) => pageItems.remove(item);
  void removeAtIndexFromPageItems(int index) => pageItems.removeAt(index);
  void insertAtIndexInPageItems(int index, PackItemStruct item) =>
      pageItems.insert(index, item);
  void updatePageItemsAtIndex(int index, Function(PackItemStruct) updateFn) =>
      pageItems[index] = updateFn(pageItems[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
