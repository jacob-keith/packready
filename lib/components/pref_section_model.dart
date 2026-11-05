import '/components/pref_section_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'pref_section_widget.dart' show PrefSectionWidget;
import 'package:flutter/material.dart';

class PrefSectionModel extends FlutterFlowModel<PrefSectionWidget> {
  ///  Local state fields for this component.

  bool? isExpanded = false;

  ///  State fields for stateful widgets in this component.

  // Model for PrefSectionComponent component.
  late PrefSectionComponentModel prefSectionComponentModel;

  @override
  void initState(BuildContext context) {
    prefSectionComponentModel =
        createModel(context, () => PrefSectionComponentModel());
  }

  @override
  void dispose() {
    prefSectionComponentModel.dispose();
  }
}
