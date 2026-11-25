import '/components/profile_&_preferences/switch_component3/switch_component3_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'pref_section_child2_widget.dart' show PrefSectionChild2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrefSectionChild2Model extends FlutterFlowModel<PrefSectionChild2Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for Switch.
  late SwitchComponent3Model switchModel1;
  // Model for Switch.
  late SwitchComponent3Model switchModel2;

  @override
  void initState(BuildContext context) {
    switchModel1 = createModel(context, () => SwitchComponent3Model());
    switchModel2 = createModel(context, () => SwitchComponent3Model());
  }

  @override
  void dispose() {
    switchModel1.dispose();
    switchModel2.dispose();
  }
}
