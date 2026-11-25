import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'pack_ready_shared_with_you_widget.dart'
    show PackReadySharedWithYouWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class PackReadySharedWithYouModel
    extends FlutterFlowModel<PackReadySharedWithYouWidget> {
  ///  Local state fields for this component.

  bool? connectionBusy = false;

  String? connectionMessage = '';

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in SharedTemplateAddCopy widget.
  String? connectionOperationError;
  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in SharedActivityAddCopy widget.
  String? connectionOperationError2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
