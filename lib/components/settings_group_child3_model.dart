import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'settings_group_child3_widget.dart' show SettingsGroupChild3Widget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsGroupChild3Model
    extends FlutterFlowModel<SettingsGroupChild3Widget> {
  ///  Local state fields for this component.

  String? locationText = 'Getting location…';

  String? retryLabel = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks.
  Future refreshLocation(BuildContext context) async {
    CityLookupResultStruct? place;

    locationText = 'Getting location…';
    updatePage(() {});
    retryLabel = '';
    updatePage(() {});
    place = await actions.currentCityAndCountry(
      context,
    );
    locationText = place?.message;
    updatePage(() {});
    retryLabel = place?.retryLabel;
    updatePage(() {});
  }
}
