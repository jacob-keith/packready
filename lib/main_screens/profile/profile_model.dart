import '/auth/firebase_auth/auth_util.dart';
import '/components/buttons_&_fields/button/button_widget.dart';
import '/components/profile_&_preferences/pref_child_defaults/pref_child_defaults_widget.dart';
import '/components/profile_&_preferences/pref_child_staples/pref_child_staples_widget.dart';
import '/components/profile_&_preferences/pref_section/pref_section_widget.dart';
import '/components/trips_&_weather/stat_mini/stat_mini_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'profile_widget.dart' show ProfileWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileModel extends FlutterFlowModel<ProfileWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel;
  // Model for StatMini.
  late StatMiniModel statMiniModel1;
  // Model for StatMini.
  late StatMiniModel statMiniModel2;
  // Model for StatMini.
  late StatMiniModel statMiniModel3;
  // Model for PrefSection component.
  late PrefSectionModel prefSectionModel1;
  // Model for PrefSection.
  late PrefSectionModel prefSectionModel2;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
    statMiniModel1 = createModel(context, () => StatMiniModel());
    statMiniModel2 = createModel(context, () => StatMiniModel());
    statMiniModel3 = createModel(context, () => StatMiniModel());
    prefSectionModel1 = createModel(context, () => PrefSectionModel());
    prefSectionModel2 = createModel(context, () => PrefSectionModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
    statMiniModel1.dispose();
    statMiniModel2.dispose();
    statMiniModel3.dispose();
    prefSectionModel1.dispose();
    prefSectionModel2.dispose();
  }
}
