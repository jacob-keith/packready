import '/components/profile_&_preferences/pref_section_component/pref_section_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'pref_section_widget.dart' show PrefSectionWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
