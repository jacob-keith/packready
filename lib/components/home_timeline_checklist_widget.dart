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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_timeline_checklist_model.dart';
export 'home_timeline_checklist_model.dart';

class HomeTimelineChecklistWidget extends StatefulWidget {
  const HomeTimelineChecklistWidget({super.key});

  @override
  State<HomeTimelineChecklistWidget> createState() =>
      _HomeTimelineChecklistWidgetState();
}

class _HomeTimelineChecklistWidgetState
    extends State<HomeTimelineChecklistWidget> {
  late HomeTimelineChecklistModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeTimelineChecklistModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_TIMELINE_CHECKLIST_HomeTimelineChec');
      _model.selectedTripIndex = FFAppState().homeInitialTripIndex;
      safeSetState(() {});
      _model.homeTripSelectedSubscription?.cancel();

      _model.homeTripSelectedSubscription = FFAppEventService
          .instance.localEventsStream
          .where((event) => event is HomeTripSelectedEvent)
          .cast<HomeTripSelectedEvent>()
          .listen((HomeTripSelectedEvent event) async {
        await _model.updateHomeChecklistSelection(
          context,
          data: event.data,
        );
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (functions
                .homeTimelineSelectedItems(
                    FFAppState().homeTimelineTrips.toList(),
                    _model.selectedTripIndex)
                ?.length ==
            0)
          Text(
            'No items in this trip',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
        Builder(
          builder: (context) {
            final packingItem = functions
                    .homeTimelineSelectedItems(
                        FFAppState().homeTimelineTrips.toList(),
                        _model.selectedTripIndex)
                    ?.toList() ??
                [];

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: List.generate(packingItem.length, (packingItemIndex) {
                final packingItemItem = packingItem[packingItemIndex];
                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent(
                        'HOME_TIMELINE_CHECKLIST_HomePackingItem_');
                    // Save the item checkmark
                    await actions.setPackingItemPacked(
                      context,
                      packingItemItem.listRef,
                      packingItemItem.itemIndex,
                      !packingItemItem.packed,
                    );
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: !(packingItemItem.detail == '') ? 64.0 : 56.0,
                    ),
                    decoration: BoxDecoration(
                      color: packingItemItem.packed
                          ? FlutterFlowTheme.of(context).accent1
                          : FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.0, 12.0, 20.0, 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: 24.0,
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                if (packingItemItem.packed)
                                  Icon(
                                    Icons.check_box,
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    size: 24.0,
                                  ),
                                if (!packingItemItem.packed)
                                  Icon(
                                    Icons.check_box_outline_blank,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            width: 23.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.start).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  packingItemItem.name,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                if (!(packingItemItem.detail == ''))
                                  Text(
                                    packingItemItem.detail,
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                  ),
                              ].divide(SizedBox(height: 2.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).divide(SizedBox(height: 6.0)),
            );
          },
        ),
      ],
    );
  }
}
