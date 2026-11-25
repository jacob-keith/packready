import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'packing_list_widget.dart' show PackingListWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

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

  ///  State fields for stateful widgets in this page.

  // State field(s) for ClothesPackingGroup widget.
  late ExpandableController clothesPackingGroupExpandableController;

  // State field(s) for ToiletriesPackingGroup widget.
  late ExpandableController toiletriesPackingGroupExpandableController;

  // State field(s) for ElectronicsPackingGroup widget.
  late ExpandableController electronicsPackingGroupExpandableController;

  // State field(s) for MiscPackingGroup widget.
  late ExpandableController miscPackingGroupExpandableController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    clothesPackingGroupExpandableController.dispose();
    toiletriesPackingGroupExpandableController.dispose();
    electronicsPackingGroupExpandableController.dispose();
    miscPackingGroupExpandableController.dispose();
  }
}
