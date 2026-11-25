import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_styled_border.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/app_events/index.dart';
import 'dart:async';
import 'home_timeline_week_widget.dart' show HomeTimelineWeekWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTimelineWeekModel extends FlutterFlowModel<HomeTimelineWeekWidget> {
  ///  Local state fields for this component.

  int selectedTripIndex = 0;

  int selectedDayIndex = 0;

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
  Future updateHomeWeekSelection(
    BuildContext context, {
    required HomeTripSelectionStruct? data,
  }) async {
    selectedTripIndex = data!.tripIndex;
    selectedDayIndex = valueOrDefault<int>(
      FFAppState().homeTimelineTrips.elementAtOrNull(data!.tripIndex)?.dayIndex,
      0,
    );
    updatePage(() {});
  }
}
