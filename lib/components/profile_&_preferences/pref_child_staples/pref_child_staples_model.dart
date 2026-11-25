import '/components/buttons_&_fields/std_button/std_button_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'pref_child_staples_widget.dart' show PrefChildStaplesWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrefChildStaplesModel extends FlutterFlowModel<PrefChildStaplesWidget> {
  ///  Local state fields for this component.

  bool isExpanded = true;

  List<String> stapleItems = [];
  void addToStapleItems(String item) => stapleItems.add(item);
  void removeFromStapleItems(String item) => stapleItems.remove(item);
  void removeAtIndexFromStapleItems(int index) => stapleItems.removeAt(index);
  void insertAtIndexInStapleItems(int index, String item) =>
      stapleItems.insert(index, item);
  void updateStapleItemsAtIndex(int index, Function(String) updateFn) =>
      stapleItems[index] = updateFn(stapleItems[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for itemInput widget.
  FocusNode? itemInputFocusNode;
  TextEditingController? itemInputTextController;
  String? Function(BuildContext, String?)? itemInputTextControllerValidator;
  // Model for StdButton.
  late StdButtonModel stdButtonModel;

  @override
  void initState(BuildContext context) {
    stdButtonModel = createModel(context, () => StdButtonModel());
  }

  @override
  void dispose() {
    itemInputFocusNode?.dispose();
    itemInputTextController?.dispose();

    stdButtonModel.dispose();
  }
}
