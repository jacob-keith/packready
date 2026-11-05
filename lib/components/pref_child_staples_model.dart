import '/components/std_button_widget.dart';
import '/components/text_field4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pref_child_staples_widget.dart' show PrefChildStaplesWidget;
import 'package:flutter/material.dart';

class PrefChildStaplesModel extends FlutterFlowModel<PrefChildStaplesWidget> {
  ///  Local state fields for this component.

  bool isExpanded = true;

  ///  State fields for stateful widgets in this component.

  // Model for TextField.
  late TextField4Model textFieldModel;
  // Model for StdButton.
  late StdButtonModel stdButtonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextField4Model());
    stdButtonModel = createModel(context, () => StdButtonModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    stdButtonModel.dispose();
  }
}
