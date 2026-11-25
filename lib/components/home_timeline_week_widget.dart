import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_styled_border.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/app_events/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_timeline_week_model.dart';
export 'home_timeline_week_model.dart';

class HomeTimelineWeekWidget extends StatefulWidget {
  const HomeTimelineWeekWidget({
    super.key,
    this.openTrip,
  });

  final Future Function(int tripIndex)? openTrip;

  @override
  State<HomeTimelineWeekWidget> createState() => _HomeTimelineWeekWidgetState();
}

class _HomeTimelineWeekWidgetState extends State<HomeTimelineWeekWidget> {
  late HomeTimelineWeekModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeTimelineWeekModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('HOME_TIMELINE_WEEK_HomeTimelineWeek_ON_I');
      _model.selectedTripIndex = FFAppState().homeInitialTripIndex;
      _model.selectedDayIndex = valueOrDefault<int>(
        FFAppState()
            .homeTimelineTrips
            .elementAtOrNull(FFAppState().homeInitialTripIndex)
            ?.dayIndex,
        0,
      );
      safeSetState(() {});
      _model.homeTripSelectedSubscription?.cancel();

      _model.homeTripSelectedSubscription = FFAppEventService
          .instance.localEventsStream
          .where((event) => event is HomeTripSelectedEvent)
          .cast<HomeTripSelectedEvent>()
          .listen((HomeTripSelectedEvent event) async {
        await _model.updateHomeWeekSelection(
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

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
      crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            alignment: AlignmentDirectional(0.0, 0.0),
            children: [
              if (!(FFAppState().homeTimelineTrips.length == 0))
                Container(
                  key: ValueKey('PackReadyHomeDateStrip'),
                  height: 58.0,
                  child: Builder(
                    builder: (context) {
                      final dayEntry = FFAppState().homeTimelineDays.toList();

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: dayEntry.length,
                        itemBuilder: (context, dayEntryIndex) {
                          final dayEntryItem = dayEntry[dayEntryIndex];
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              logFirebaseEvent(
                                  'HOME_TIMELINE_WEEK_HomeDayCell_ON_TAP');
                              if (!(dayEntryItem.tripIndex == -1)) {
                                await widget.openTrip?.call(
                                  dayEntryItem.tripIndex,
                                );
                              }
                            },
                            child: Container(
                              width: 48.0,
                              height: 52.0,
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 42.0,
                                height: 48.0,
                                child: Stack(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  children: [
                                    if (dayEntryIndex ==
                                        _model.selectedDayIndex)
                                      Container(
                                        width: 42.0,
                                        height: 48.0,
                                        child: Stack(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, -1.0),
                                              child: Container(
                                                width: 7.0,
                                                height: 7.0,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                    left: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Container(
                                                width: 7.0,
                                                height: 7.0,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                    right: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -1.0, 1.0),
                                              child: Container(
                                                width: 7.0,
                                                height: 7.0,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                    left: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 1.0),
                                              child: Container(
                                                width: 7.0,
                                                height: 7.0,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .packedGreen;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .unpackedOrange;
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .calendarEventSlate;
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.25,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.center)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          dayEntryItem.weekday,
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .subtleText,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9.0,
                                          ),
                                        ),
                                        Container(
                                          width: 27.0,
                                          height: 21.0,
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 27.0,
                                                height: 21.0,
                                                decoration: BoxDecoration(
                                                  color: () {
                                                    if (dayEntryItem.status ==
                                                        'packed') {
                                                      return (dayEntryIndex ==
                                                              _model
                                                                  .selectedDayIndex
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .packedGreenTint
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .packedGreenTint);
                                                    } else if (dayEntryItem
                                                            .status ==
                                                        'incomplete') {
                                                      return (dayEntryIndex ==
                                                              _model
                                                                  .selectedDayIndex
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .pendingYellowTint
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .pendingYellowTint);
                                                    } else if (dayEntryItem
                                                            .status ==
                                                        'unpacked') {
                                                      return (dayEntryIndex ==
                                                              _model
                                                                  .selectedDayIndex
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .unpackedOrangeTint
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .unpackedOrangeTint);
                                                    } else if (dayEntryItem
                                                            .status ==
                                                        'event') {
                                                      return (dayEntryIndex ==
                                                              _model
                                                                  .selectedDayIndex
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .calendarEventTint
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .calendarEventTint);
                                                    } else {
                                                      return Colors.transparent;
                                                    }
                                                  }(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              if (!(dayEntryItem.tripIndex ==
                                                      -1)
                                                  ? !dayEntryItem.localOnly
                                                  : false)
                                                Container(
                                                  width: 27.0,
                                                  height: 21.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    border: Border.all(
                                                      color: () {
                                                        if (dayEntryItem
                                                                .status ==
                                                            'packed') {
                                                          return (dayEntryIndex ==
                                                                  _model
                                                                      .selectedDayIndex
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .packedGreen
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .packedGreen);
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'incomplete') {
                                                          return (dayEntryIndex ==
                                                                  _model
                                                                      .selectedDayIndex
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .pendingYellow
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .pendingYellow);
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'unpacked') {
                                                          return (dayEntryIndex ==
                                                                  _model
                                                                      .selectedDayIndex
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .unpackedOrange
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .unpackedOrange);
                                                        } else if (dayEntryItem
                                                                .status ==
                                                            'event') {
                                                          return (dayEntryIndex ==
                                                                  _model
                                                                      .selectedDayIndex
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .calendarEventSlate
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .calendarEventSlate);
                                                        } else {
                                                          return FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary;
                                                        }
                                                      }(),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              if (!(dayEntryItem.tripIndex ==
                                                      -1)
                                                  ? dayEntryItem.localOnly
                                                  : false)
                                                Container(
                                                  width: 27.0,
                                                  height: 21.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    border:
                                                        FlutterFlowStyledBorder(
                                                      side: BorderSide(
                                                        color: () {
                                                          if (dayEntryItem
                                                                  .status ==
                                                              'packed') {
                                                            return (dayEntryIndex ==
                                                                    _model
                                                                        .selectedDayIndex
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .packedGreen
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .packedGreen);
                                                          } else if (dayEntryItem
                                                                  .status ==
                                                              'incomplete') {
                                                            return (dayEntryIndex ==
                                                                    _model
                                                                        .selectedDayIndex
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow);
                                                          } else if (dayEntryItem
                                                                  .status ==
                                                              'unpacked') {
                                                            return (dayEntryIndex ==
                                                                    _model
                                                                        .selectedDayIndex
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .unpackedOrange
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .unpackedOrange);
                                                          } else if (dayEntryItem
                                                                  .status ==
                                                              'event') {
                                                            return (dayEntryIndex ==
                                                                    _model
                                                                        .selectedDayIndex
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .calendarEventSlate
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .calendarEventSlate);
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary;
                                                          }
                                                        }(),
                                                        width: 1.15,
                                                      ),
                                                      style:
                                                          FlutterFlowDashStyle
                                                              .dashed,
                                                      dashLength: 3.2,
                                                      dashGap: 2.2,
                                                    ),
                                                  ),
                                                ),
                                              Text(
                                                dayEntryItem.dateLabel,
                                                style: GoogleFonts.robotoMono(
                                                  color: dayEntryIndex ==
                                                          _model
                                                              .selectedDayIndex
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText
                                                      : () {
                                                          if (dayEntryItem
                                                                  .status ==
                                                              'packed') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .packedGreen;
                                                          } else if (dayEntryItem
                                                                  .status ==
                                                              'incomplete') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .pendingYellow;
                                                          } else if (dayEntryItem
                                                                  .status ==
                                                              'unpacked') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .unpackedOrange;
                                                          } else if (dayEntryItem
                                                                  .status ==
                                                              'event') {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .calendarEventSlate;
                                                          } else {
                                                            return FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText;
                                                          }
                                                        }(),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 2.0)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              if (false)
                Container(
                  height: 58.0,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(11.0, 0.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'SAT',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '21',
                                            style: GoogleFonts.robotoMono(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'SUN',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '22',
                                            style: GoogleFonts.robotoMono(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'MON',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '23',
                                            style: GoogleFonts.robotoMono(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'TUE',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x42C2720C),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: Color(0xEBC2720C),
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '24',
                                            style: GoogleFonts.robotoMono(
                                              color: Color(0xFF122016),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'WED',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '25',
                                            style: GoogleFonts.robotoMono(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color: Color(0xFFC2720C),
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'THU',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Color(0x26C2720C),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: Color(0xC2C2720C),
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '26',
                                            style: GoogleFonts.robotoMono(
                                              color: Color(0xFF855511),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 48.0,
                          height: 52.0,
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            width: 42.0,
                            height: 48.0,
                            child: Stack(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              children: [
                                Container(
                                  width: 42.0,
                                  height: 48.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              left: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, 1.0),
                                        child: Container(
                                          width: 7.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                              bottom: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.25,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.center).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      'FRI',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .subtleText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.0,
                                      ),
                                    ),
                                    Container(
                                      width: 27.0,
                                      height: 21.0,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        children: [
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 27.0,
                                            height: 21.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: FlutterFlowStyledBorder(
                                                side: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  width: 1.15,
                                                ),
                                                style:
                                                    FlutterFlowDashStyle.dashed,
                                                dashLength: 3.2,
                                                dashGap: 2.2,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '27',
                                            style: GoogleFonts.robotoMono(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ].divide(SizedBox(height: 2.0)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (!(FFAppState().homeNextTripIndex == -1)
            ? !(FFAppState().homeNextTripIndex == _model.selectedTripIndex)
            : false)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
            child: FFButtonWidget(
              onPressed: () async {
                logFirebaseEvent('HOME_TIMELINE_WEEK_HomeNextTrip_ON_TAP');
                await widget.openTrip?.call(
                  FFAppState().homeNextTripIndex,
                );
              },
              text: 'Next trip',
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Colors.transparent,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).linkGreen,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
      ],
    );
  }
}
