import '/components/text_field4_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pref_child_defaults_widget.dart' show PrefChildDefaultsWidget;
import 'package:flutter/material.dart';

class PrefChildDefaultsModel extends FlutterFlowModel<PrefChildDefaultsWidget> {
  ///  Local state fields for this component.

  String? tripLength;

  ///  State fields for stateful widgets in this component.

  // Model for TextField.
  late TextField4Model textFieldModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextField4Model());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
  }
}
