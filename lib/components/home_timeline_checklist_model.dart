import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/app_events/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'dart:async';
import 'home_timeline_checklist_widget.dart' show HomeTimelineChecklistWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTimelineChecklistModel
    extends FlutterFlowModel<HomeTimelineChecklistWidget> {
  ///  Local state fields for this component.

  int selectedTripIndex = 0;

  ///  State fields for stateful widgets in this component.

  // Subscription for local app event HomeTripSelectedEvent
  StreamSubscription<HomeTripSelectedEvent>? homeTripSelectedSubscription;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    // Cancel the subscription for local app event HomeTripSelectedEvent
    homeTripSelectedSubscription?.cancel();
  }

  /// Action blocks.
  Future updateHomeChecklistSelection(
    BuildContext context, {
    required HomeTripSelectionStruct? data,
  }) async {
    selectedTripIndex = data!.tripIndex;
    updatePage(() {});
  }
}
