import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_styled_border.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'calendar_model.dart';
export 'calendar_model.dart';

/// DSL page Calendar
class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
    bool? embedInTabShell,
  }) : this.embedInTabShell = embedInTabShell ?? false;

  /// Internal flag.
  ///
  /// Hides the standalone bar when the shell embeds this page.
  final bool embedInTabShell;

  static String routeName = 'Calendar';
  static String routePath = '/calendar';

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Calendar'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('CALENDAR_PAGE_Calendar_ON_INIT_STATE');
      if (!_model.calendarBusy!) {
        _model.calendarBusy = true;
        safeSetState(() {});
        _model.loadedCalendar = await actions.calendarStudio(
          context,
          'load',
          _model.calendarView?.date,
          _model.calendarMonth,
          '',
          '',
          '',
        );
        _model.calendarView = _model.loadedCalendar;
        safeSetState(() {});
        _model.calendarBusy = false;
        safeSetState(() {});
      }
    });

    _model.calendarAppleUrlTextController ??= TextEditingController();
    _model.calendarAppleUrlFocusNode ??= FocusNode();

    _model.calendarAppleNameTextController ??= TextEditingController();
    _model.calendarAppleNameFocusNode ??= FocusNode();

    _model.calendarAppleColorTextController ??= TextEditingController();
    _model.calendarAppleColorFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
            crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.stretch).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primaryBackground,
                              FlutterFlowTheme.of(context).tabBarSurface
                            ],
                            stops: [0.0, 1.0],
                            begin: AlignmentDirectional(0.0, -1.0),
                            end: AlignmentDirectional(0, 1.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 9.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.stretch).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Container(
                                height: 40.0,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.start).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.center)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_PAGE_CalendarPrevious_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.calendarDetailsOpen = false;
                                          safeSetState(() {});
                                          _model.previousCalendarPeriod =
                                              await actions.calendarStudio(
                                            context,
                                            'previous',
                                            _model.calendarView?.date,
                                            _model.calendarMonth,
                                            '',
                                            '',
                                            '',
                                          );
                                          _model.calendarView =
                                              _model.previousCalendarPeriod;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        width: 33.0,
                                        height: 40.0,
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.5, 0.0, 0.0, 0.0),
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 17.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_PAGE_CalendarMonthToggle_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.calendarDetailsOpen = false;
                                          safeSetState(() {});
                                          _model.toggledCalendarView =
                                              await actions.calendarStudio(
                                            context,
                                            'mode',
                                            _model.calendarView?.date,
                                            !_model.calendarMonth!,
                                            '',
                                            '',
                                            '',
                                          );
                                          _model.calendarView =
                                              _model.toggledCalendarView;
                                          safeSetState(() {});
                                          _model.calendarMonth =
                                              !_model.calendarMonth!;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 4.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                _model.calendarView!.monthTitle,
                                                maxLines: 1,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.5,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                      lineHeight: 1.05,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              if (!_model.calendarMonth!)
                                                Icon(
                                                  Icons.expand_more,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 15.0,
                                                ),
                                              if (_model.calendarMonth ?? true)
                                                Icon(
                                                  Icons.expand_less,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 15.0,
                                                ),
                                            ].divide(SizedBox(width: 2.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'CALENDAR_PAGE_CalendarNext_ON_TAP');
                                            if (!_model.calendarBusy!) {
                                              _model.calendarBusy = true;
                                              safeSetState(() {});
                                              _model.calendarDetailsOpen =
                                                  false;
                                              safeSetState(() {});
                                              _model.nextCalendarPeriod =
                                                  await actions.calendarStudio(
                                                context,
                                                'next',
                                                _model.calendarView?.date,
                                                _model.calendarMonth,
                                                '',
                                                '',
                                                '',
                                              );
                                              _model.calendarView =
                                                  _model.nextCalendarPeriod;
                                              safeSetState(() {});
                                              _model.calendarBusy = false;
                                              safeSetState(() {});
                                            }

                                            safeSetState(() {});
                                          },
                                          child: Container(
                                            width: 44.0,
                                            height: 40.0,
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(3.5, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.chevron_right,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                size: 17.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_PAGE_CalendarToday_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.calendarDetailsOpen = false;
                                          safeSetState(() {});
                                          _model.calendarForToday =
                                              await actions.calendarStudio(
                                            context,
                                            'today',
                                            _model.calendarView?.date,
                                            _model.calendarMonth,
                                            '',
                                            '',
                                            '',
                                          );
                                          _model.calendarView =
                                              _model.calendarForToday;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreenTint,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .packedGreen,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 3.0, 8.0, 3.0),
                                          child: Text(
                                            'TODAY',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .packedGreen,
                                                  fontSize: 9.5,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                  lineHeight: 1.05,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 5.0,
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_PAGE_CalendarDayAi_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.calendarAfterAiEditor =
                                              await actions.calendarStudio(
                                            context,
                                            'draft',
                                            _model.calendarView?.date,
                                            _model.calendarMonth,
                                            '',
                                            '',
                                            '',
                                          );
                                          _model.calendarView =
                                              _model.calendarAfterAiEditor;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreenTint,
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .packedGreen,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 4.0, 0.0),
                                          child: Text(
                                            '+ AI',
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .packedGreen,
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                  lineHeight: 1.05,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarManageButton_ON_TAP');
                                        _model.calendarSourcesOpen =
                                            !(_model.calendarSourcesOpen ??
                                                true);
                                        safeSetState(() {});
                                        _model.calendarDetailsOpen = false;
                                        safeSetState(() {});
                                      },
                                      child: Container(
                                        height: 34.0,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  7.0, 0.0, 7.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Container(
                                                width: 7.0,
                                                height: 7.0,
                                                decoration: BoxDecoration(
                                                  color: _model.calendarView!
                                                          .connected
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .packedGreen
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryText,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ),
                                              Text(
                                                'Calendars',
                                                maxLines: 1,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .labelMedium
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 11.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                      lineHeight: 1.05,
                                                    ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ].divide(SizedBox(width: 4.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_model.calendarMonth ?? true)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      9.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    height: 18.0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'S',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'M',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'T',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'W',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'T',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'F',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              'S',
                                              maxLines: 1,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .subtleText,
                                                    fontSize: 9.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                    lineHeight: 1.05,
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      9.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'SUN',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '22',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'MON',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '23',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'TUE',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .pendingYellowTint,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        border:
                                                            FlutterFlowStyledBorder(
                                                          side: BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .pendingYellow,
                                                            width: 1.0,
                                                          ),
                                                          style:
                                                              FlutterFlowDashStyle
                                                                  .dashed,
                                                        ),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '24',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                                height: 48.0,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .spaceBetween)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .spaceBetween)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Container(
                                                          width: 7.0,
                                                          height: 7.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                              left: BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 7.0,
                                                          height: 7.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              top: BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                              right: BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .spaceBetween)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Container(
                                                          width: 7.0,
                                                          height: 7.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              bottom:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                              left: BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 7.0,
                                                          height: 7.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border(
                                                              right: BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                              bottom:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .pendingYellow,
                                                                width: 1.4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'WED',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '25',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'THU',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '26',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'FRI',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '27',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 58.0,
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Stack(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Container(
                                                width: 42.0,
                                                height: double.infinity,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      height: 14.0,
                                                      child: Text(
                                                        'SAT',
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.45,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 27.0,
                                                      height: 20.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Text(
                                                        '28',
                                                        maxLines: 1,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .roboto(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontSize: 12.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                              lineHeight: 1.05,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 42.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (!(_model.calendarView?.weeks?.length == 0))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      9.0, 0.0, 0.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final weekRow = _model.calendarView?.weeks
                                              ?.toList() ??
                                          [];

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.start)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.center)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: List.generate(weekRow.length,
                                            (weekRowIndex) {
                                          final weekRowItem =
                                              weekRow[weekRowIndex];
                                          return Builder(
                                            builder: (context) {
                                              final dayCell =
                                                  weekRowItem.days.toList();

                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    (FFMainAxisAlignment.start)
                                                        .flutterValue,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment
                                                            .center)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: List.generate(
                                                    dayCell.length,
                                                    (dayCellIndex) {
                                                  final dayCellItem =
                                                      dayCell[dayCellIndex];
                                                  return Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        logFirebaseEvent(
                                                            'CALENDAR_PAGE_CalendarDayCell_ON_TAP');
                                                        if (!_model
                                                            .calendarBusy!) {
                                                          _model.calendarBusy =
                                                              true;
                                                          safeSetState(() {});
                                                          _model.calendarDetailsOpen =
                                                              false;
                                                          safeSetState(() {});
                                                          _model.calendarForSelectedDay =
                                                              await actions
                                                                  .calendarStudio(
                                                            context,
                                                            'date',
                                                            _model.calendarView
                                                                ?.date,
                                                            _model
                                                                .calendarMonth,
                                                            dayCellItem.date,
                                                            '',
                                                            '',
                                                          );
                                                          _model.calendarView =
                                                              _model
                                                                  .calendarForSelectedDay;
                                                          safeSetState(() {});
                                                          _model.calendarBusy =
                                                              false;
                                                          safeSetState(() {});
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: _model
                                                                .calendarMonth!
                                                            ? 39.0
                                                            : 58.0,
                                                        child: Stack(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, -1.0),
                                                          children: [
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                children: [
                                                                  Container(
                                                                    width: 42.0,
                                                                    height: double
                                                                        .infinity,
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          (FFMainAxisAlignment.center)
                                                                              .flutterValue,
                                                                      crossAxisAlignment:
                                                                          (FFCrossAxisAlignment.center)
                                                                              .flutterValue,
                                                                      textBaseline:
                                                                          TextBaseline
                                                                              .alphabetic,
                                                                      children: [
                                                                        if (!_model
                                                                            .calendarMonth!)
                                                                          Container(
                                                                            height:
                                                                                14.0,
                                                                            child:
                                                                                Text(
                                                                              dayCellItem.weekday,
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.roboto(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).subtleText,
                                                                                    fontSize: 9.0,
                                                                                    letterSpacing: 0.45,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    lineHeight: 1.05,
                                                                                  ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        Stack(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          children: [
                                                                            Container(
                                                                              width: 27.0,
                                                                              height: 20.0,
                                                                              decoration: BoxDecoration(
                                                                                color: () {
                                                                                  if (dayCellItem.selected ? (dayCellItem.status == 'packed') : false) {
                                                                                    return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                  } else if (dayCellItem.selected ? (dayCellItem.status == 'incomplete') : false) {
                                                                                    return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                  } else if (dayCellItem.selected ? (dayCellItem.status == 'unpacked') : false) {
                                                                                    return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                  } else if (dayCellItem.selected ? (dayCellItem.status == 'event') : false) {
                                                                                    return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                  } else if (dayCellItem.status == 'packed') {
                                                                                    return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                  } else if (dayCellItem.status == 'incomplete') {
                                                                                    return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                  } else if (dayCellItem.status == 'unpacked') {
                                                                                    return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                  } else if (dayCellItem.status == 'event') {
                                                                                    return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                  } else {
                                                                                    return Colors.transparent;
                                                                                  }
                                                                                }(),
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: () {
                                                                                    if (dayCellItem.standalone) {
                                                                                      return Colors.transparent;
                                                                                    } else if (dayCellItem.status == 'packed') {
                                                                                      return FlutterFlowTheme.of(context).packedGreen;
                                                                                    } else if (dayCellItem.status == 'incomplete') {
                                                                                      return FlutterFlowTheme.of(context).pendingYellow;
                                                                                    } else if (dayCellItem.status == 'unpacked') {
                                                                                      return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                    } else if (dayCellItem.status == 'event') {
                                                                                      return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                    } else {
                                                                                      return Colors.transparent;
                                                                                    }
                                                                                  }(),
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Text(
                                                                                dayCellItem.label,
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      font: GoogleFonts.roboto(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      ),
                                                                                      color: dayCellItem.outside ? FlutterFlowTheme.of(context).subtleText : FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 12.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                      lineHeight: 1.05,
                                                                                    ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                            if (dayCellItem.standalone)
                                                                              Container(
                                                                                width: 27.0,
                                                                                height: 20.0,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: FlutterFlowStyledBorder(
                                                                                    side: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.selected ? (dayCellItem.status == 'packed') : false) {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.selected ? (dayCellItem.status == 'incomplete') : false) {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.selected ? (dayCellItem.status == 'unpacked') : false) {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.selected ? (dayCellItem.status == 'event') : false) {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return Colors.transparent;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.0,
                                                                                    ),
                                                                                    style: FlutterFlowDashStyle.dashed,
                                                                                    dashLength: 3.2,
                                                                                    dashGap: 2.2,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if (dayCellItem
                                                                      .selected)
                                                                    Container(
                                                                      width:
                                                                          42.0,
                                                                      height:
                                                                          48.0,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            (FFMainAxisAlignment.spaceBetween).flutterValue,
                                                                        crossAxisAlignment:
                                                                            (FFCrossAxisAlignment.center).flutterValue,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                (FFMainAxisAlignment.spaceBetween).flutterValue,
                                                                            crossAxisAlignment:
                                                                                (FFCrossAxisAlignment.center).flutterValue,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                            children: [
                                                                              Container(
                                                                                width: 7.0,
                                                                                height: 7.0,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                    top: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                    left: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 7.0,
                                                                                height: 7.0,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                    top: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                    right: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                (FFMainAxisAlignment.spaceBetween).flutterValue,
                                                                            crossAxisAlignment:
                                                                                (FFCrossAxisAlignment.center).flutterValue,
                                                                            textBaseline:
                                                                                TextBaseline.alphabetic,
                                                                            children: [
                                                                              Container(
                                                                                width: 7.0,
                                                                                height: 7.0,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                    bottom: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                    left: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 7.0,
                                                                                height: 7.0,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                    right: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                    bottom: BorderSide(
                                                                                      color: () {
                                                                                        if (dayCellItem.status == 'packed') {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        } else if (dayCellItem.status == 'incomplete') {
                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                        } else if (dayCellItem.status == 'unpacked') {
                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                        } else if (dayCellItem.status == 'event') {
                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                        } else {
                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                        }
                                                                                      }(),
                                                                                      width: 1.4,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              );
                                            },
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              if (_model.calendarMonth ?? true)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      9.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    height: 21.0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.center)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .unpackedOrange,
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                          ),
                                        ),
                                        Text(
                                          'UNPACKED',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                fontSize: 8.0,
                                                letterSpacing: 0.15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.05,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: 3.0,
                                        ),
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .pendingYellow,
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                          ),
                                        ),
                                        Text(
                                          'INCOMPLETE',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                fontSize: 8.0,
                                                letterSpacing: 0.15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.05,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: 3.0,
                                        ),
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .packedGreen,
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                          ),
                                        ),
                                        Text(
                                          'PACKED',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                fontSize: 8.0,
                                                letterSpacing: 0.15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.05,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: 3.0,
                                        ),
                                        Container(
                                          width: 6.0,
                                          height: 6.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .calendarEventSlate,
                                            borderRadius:
                                                BorderRadius.circular(3.0),
                                          ),
                                        ),
                                        Text(
                                          'EVENT',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                fontSize: 8.0,
                                                letterSpacing: 0.15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.05,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: 3.0,
                                        ),
                                        Container(
                                          width: 9.0,
                                          height: 7.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2.0),
                                            border: FlutterFlowStyledBorder(
                                              side: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                width: 1.0,
                                              ),
                                              style:
                                                  FlutterFlowDashStyle.dashed,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'PACKREADY',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                fontSize: 8.0,
                                                letterSpacing: 0.15,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.05,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ].divide(SizedBox(width: 4.0)),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    9.0, 0.0, 0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'CALENDAR_CalendarExpandControl_ON_TAP');
                                    if (!_model.calendarBusy!) {
                                      _model.calendarBusy = true;
                                      safeSetState(() {});
                                      _model.calendarDetailsOpen = false;
                                      safeSetState(() {});
                                      _model.expandedCalendarView =
                                          await actions.calendarStudio(
                                        context,
                                        'mode',
                                        _model.calendarView?.date,
                                        !_model.calendarMonth!,
                                        '',
                                        '',
                                        '',
                                      );
                                      _model.calendarView =
                                          _model.expandedCalendarView;
                                      safeSetState(() {});
                                      _model.calendarMonth =
                                          !_model.calendarMonth!;
                                      safeSetState(() {});
                                      _model.calendarBusy = false;
                                      safeSetState(() {});
                                    }

                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    height: 26.0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.center)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          width: 34.0,
                                          height: 3.5,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        Text(
                                          _model.calendarMonth!
                                              ? 'COLLAPSE TO WEEK'
                                              : 'EXPAND MONTH',
                                          maxLines: 1,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .subtleText,
                                                fontSize: 9.0,
                                                letterSpacing: 1.2,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.05,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    9.0, 0.0, 0.0, 0.0),
                                child: Container(
                                  height: 1.0,
                                  decoration: BoxDecoration(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_model.calendarBusy ?? true)
                        LinearPercentIndicator(
                          percent: 0.35,
                          lineHeight: 2.0,
                          animation: false,
                          animateFromLastPercent: true,
                          progressColor: FlutterFlowTheme.of(context).primary,
                          backgroundColor: FlutterFlowTheme.of(context).accent4,
                          barRadius: Radius.circular(1.0),
                          padding: EdgeInsets.zero,
                        ),
                      if (!(_model.calendarView?.message == ''))
                        Container(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 4.0, 12.0, 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.center).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    _model.calendarView!.message,
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
                                              .pendingYellow,
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
                                ),
                                if (_model.calendarView?.reconnect ?? true)
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CALENDAR_PAGE_CalendarReconnect_ON_TAP');
                                      if (!_model.calendarBusy!) {
                                        _model.calendarBusy = true;
                                        safeSetState(() {});
                                        _model.reconnectedCalendar =
                                            await actions.calendarStudio(
                                          context,
                                          'google',
                                          _model.calendarView?.date,
                                          _model.calendarMonth,
                                          '',
                                          '',
                                          '',
                                        );
                                        _model.calendarView =
                                            _model.reconnectedCalendar;
                                        safeSetState(() {});
                                        _model.calendarBusy = false;
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Reconnect',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Colors.transparent,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                      ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                if (!_model.calendarView!.reconnect)
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CALENDAR_PAGE_CalendarRetry_ON_TAP');
                                      if (!_model.calendarBusy!) {
                                        _model.calendarBusy = true;
                                        safeSetState(() {});
                                        _model.retriedCalendar =
                                            await actions.calendarStudio(
                                          context,
                                          'refresh',
                                          _model.calendarView?.date,
                                          _model.calendarMonth,
                                          '',
                                          '',
                                          '',
                                        );
                                        _model.calendarView =
                                            _model.retriedCalendar;
                                        safeSetState(() {});
                                        _model.calendarBusy = false;
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Retry',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Colors.transparent,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                      ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      if (!_model.calendarSourcesOpen!
                          ? !_model.calendarDetailsOpen!
                          : false)
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 8.0, 12.0, 14.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.stretch).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Container(
                                    height: 20.0,
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 2.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.spaceBetween)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.center)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            _model.calendarView!.dayTitle,
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 12.5,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                  lineHeight: 1.05,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            _model.calendarView!.summary,
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                  lineHeight: 1.05,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    children: [
                                      if (false)
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.start)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.stretch)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Container(
                                              height: 2.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '9 AM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '10 AM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '11 AM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '12 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '1 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '2 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '3 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '4 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '5 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '6 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '7 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '8 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 29.5),
                                              child: Container(
                                                width: double.infinity,
                                                height: 12.0,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .center)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: 31.0,
                                                      child: Text(
                                                        '9 PM',
                                                        textAlign:
                                                            TextAlign.end,
                                                        maxLines: 1,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .roboto(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .subtleText,
                                                                  fontSize: 9.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                  lineHeight:
                                                                      1.05,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        height: 1.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .subtleDivider,
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 7.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (!(_model.calendarView?.hourLabels
                                              ?.length ==
                                          0))
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.start)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.stretch)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: _model
                                                  .calendarView?.hourInset,
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                children: [],
                                              ),
                                            ),
                                            Builder(
                                              builder: (context) {
                                                final entry = _model
                                                        .calendarView
                                                        ?.hourLabels
                                                        ?.toList() ??
                                                    [];

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .stretch)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: List.generate(
                                                      entry.length,
                                                      (entryIndex) {
                                                    final entryItem =
                                                        entry[entryIndex];
                                                    return Container(
                                                      width: double.infinity,
                                                      height: _model
                                                          .calendarView
                                                          ?.hourStep,
                                                      child: Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        children: [
                                                          Container(
                                                            height: 12.0,
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  (FFMainAxisAlignment
                                                                          .start)
                                                                      .flutterValue,
                                                              crossAxisAlignment:
                                                                  (FFCrossAxisAlignment
                                                                          .center)
                                                                      .flutterValue,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: [
                                                                Container(
                                                                  width: 31.0,
                                                                  child: Text(
                                                                    entryItem,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    maxLines: 1,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.roboto(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).subtleText,
                                                                          fontSize:
                                                                              9.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                          lineHeight:
                                                                              1.05,
                                                                        ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    height: 1.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .subtleDivider,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 7.0)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      if (!(_model.calendarView?.nowLabel ==
                                          ''))
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.start)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.stretch)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: _model
                                                  .calendarView?.nowOffset,
                                              child: Stack(
                                                alignment: AlignmentDirectional(
                                                    -1.0, -1.0),
                                                children: [],
                                              ),
                                            ),
                                            Container(
                                              height: 12.0,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    (FFMainAxisAlignment.start)
                                                        .flutterValue,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment
                                                            .center)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Container(
                                                    width: 32.0,
                                                    child: Text(
                                                      _model.calendarView!
                                                          .nowLabel,
                                                      textAlign: TextAlign.end,
                                                      maxLines: 1,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .labelSmall
                                                          .override(
                                                            font: GoogleFonts
                                                                .roboto(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .packedGreen,
                                                            fontSize: 9.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                            lineHeight: 1.05,
                                                          ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 3.0,
                                                  ),
                                                  Container(
                                                    width: 7.0,
                                                    height: 7.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .packedGreen,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: 2.0,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .packedGreen,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .packedGreen
                                                          ],
                                                          stops: [0.0, 1.0],
                                                          begin:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          end:
                                                              AlignmentDirectional(
                                                                  1.0, 0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (_model.calendarView?.hasEvents ??
                                          true)
                                        Builder(
                                          builder: (context) {
                                            final eventCard = _model
                                                    .calendarView?.bands
                                                    ?.toList() ??
                                                [];

                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  (FFMainAxisAlignment.start)
                                                      .flutterValue,
                                              crossAxisAlignment:
                                                  (FFCrossAxisAlignment.stretch)
                                                      .flutterValue,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: List.generate(
                                                  eventCard.length,
                                                  (eventCardIndex) {
                                                final eventCardItem =
                                                    eventCard[eventCardIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .stretch)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: eventCardItem.gap,
                                                      child: Stack(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, -1.0),
                                                        children: [],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          (FFMainAxisAlignment
                                                                  .start)
                                                              .flutterValue,
                                                      crossAxisAlignment:
                                                          (FFCrossAxisAlignment
                                                                  .center)
                                                              .flutterValue,
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        if (!eventCardItem
                                                            .allDay)
                                                          Container(
                                                            width: 45.0,
                                                          ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Builder(
                                                            builder: (context) {
                                                              final entry =
                                                                  eventCardItem
                                                                      .lanes
                                                                      .toList();

                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    (FFMainAxisAlignment
                                                                            .start)
                                                                        .flutterValue,
                                                                crossAxisAlignment:
                                                                    (FFCrossAxisAlignment
                                                                            .start)
                                                                        .flutterValue,
                                                                textBaseline:
                                                                    TextBaseline
                                                                        .alphabetic,
                                                                children: List.generate(
                                                                    entry
                                                                        .length,
                                                                    (entryIndex) {
                                                                  final entryItem =
                                                                      entry[
                                                                          entryIndex];
                                                                  return Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final entry = entryItem
                                                                            .cards
                                                                            .toList();

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              (FFMainAxisAlignment.start).flutterValue,
                                                                          crossAxisAlignment:
                                                                              (FFCrossAxisAlignment.stretch).flutterValue,
                                                                          textBaseline:
                                                                              TextBaseline.alphabetic,
                                                                          children: List.generate(
                                                                              entry.length,
                                                                              (entryIndex) {
                                                                            final entryItem =
                                                                                entry[entryIndex];
                                                                            return Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                              crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                                                                              textBaseline: TextBaseline.alphabetic,
                                                                              children: [
                                                                                Container(
                                                                                  width: double.infinity,
                                                                                  height: entryItem.gap,
                                                                                  child: Stack(
                                                                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                    children: [],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: double.infinity,
                                                                                  height: entryItem.height,
                                                                                  child: Stack(
                                                                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                        crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                                                                                        textBaseline: TextBaseline.alphabetic,
                                                                                        children: [
                                                                                          if (entryItem.allDay)
                                                                                            Container(
                                                                                              width: 45.0,
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Text(
                                                                                                'ALL\nDAY',
                                                                                                textAlign: TextAlign.center,
                                                                                                style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                      font: GoogleFonts.roboto(
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).subtleText,
                                                                                                      fontSize: 8.5,
                                                                                                      letterSpacing: 0.4,
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                      lineHeight: 1.05,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          Expanded(
                                                                                            flex: 1,
                                                                                            child: Stack(
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              children: [
                                                                                                if (!entryItem.standalone)
                                                                                                  Container(
                                                                                                    width: double.infinity,
                                                                                                    height: double.infinity,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: () {
                                                                                                        if (entryItem.status == 'packed') {
                                                                                                          return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                                        } else if (entryItem.status == 'incomplete') {
                                                                                                          return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                        } else if (entryItem.status == 'unpacked') {
                                                                                                          return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                                        } else if (entryItem.status == 'event') {
                                                                                                          return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                        }
                                                                                                      }(),
                                                                                                      borderRadius: BorderRadius.circular(7.0),
                                                                                                      border: Border.all(
                                                                                                        color: () {
                                                                                                          if (entryItem.status == 'packed') {
                                                                                                            return FlutterFlowTheme.of(context).packedGreen;
                                                                                                          } else if (entryItem.status == 'incomplete') {
                                                                                                            return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                          } else if (entryItem.status == 'unpacked') {
                                                                                                            return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                          } else if (entryItem.status == 'event') {
                                                                                                            return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                          } else {
                                                                                                            return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                          }
                                                                                                        }(),
                                                                                                        width: 1.0,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                if (entryItem.standalone)
                                                                                                  Container(
                                                                                                    width: double.infinity,
                                                                                                    height: double.infinity,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: () {
                                                                                                        if (entryItem.status == 'packed') {
                                                                                                          return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                                        } else if (entryItem.status == 'incomplete') {
                                                                                                          return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                        } else if (entryItem.status == 'unpacked') {
                                                                                                          return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                                        } else if (entryItem.status == 'event') {
                                                                                                          return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                        }
                                                                                                      }(),
                                                                                                      borderRadius: BorderRadius.circular(7.0),
                                                                                                      border: FlutterFlowStyledBorder(
                                                                                                        side: BorderSide(
                                                                                                          color: () {
                                                                                                            if (entryItem.status == 'packed') {
                                                                                                              return FlutterFlowTheme.of(context).packedGreen;
                                                                                                            } else if (entryItem.status == 'incomplete') {
                                                                                                              return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                            } else if (entryItem.status == 'unpacked') {
                                                                                                              return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                            } else if (entryItem.status == 'event') {
                                                                                                              return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                            } else {
                                                                                                              return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                            }
                                                                                                          }(),
                                                                                                          width: 1.4,
                                                                                                        ),
                                                                                                        style: FlutterFlowDashStyle.dashed,
                                                                                                        dashLength: 5.5,
                                                                                                        dashGap: 3.5,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    logFirebaseEvent('CALENDAR_CalendarEventCardContent_ON_TAP');
                                                                                                    if (entryItem.standalone) {
                                                                                                      if (!_model.calendarBusy!) {
                                                                                                        _model.calendarBusy = true;
                                                                                                        safeSetState(() {});
                                                                                                        _model.calendarAfterPackingList = await actions.calendarStudio(
                                                                                                          context,
                                                                                                          'open',
                                                                                                          _model.calendarView?.date,
                                                                                                          _model.calendarMonth,
                                                                                                          entryItem.path,
                                                                                                          '',
                                                                                                          '',
                                                                                                        );
                                                                                                        _model.calendarView = _model.calendarAfterPackingList;
                                                                                                        safeSetState(() {});
                                                                                                        _model.calendarBusy = false;
                                                                                                        safeSetState(() {});
                                                                                                      }
                                                                                                    } else {
                                                                                                      _model.calendarSelectedCard = entryItem;
                                                                                                      safeSetState(() {});
                                                                                                      _model.calendarDetailsOpen = true;
                                                                                                      safeSetState(() {});
                                                                                                    }

                                                                                                    safeSetState(() {});
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: double.infinity,
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                                      crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                                                                                                      textBaseline: TextBaseline.alphabetic,
                                                                                                      children: [
                                                                                                        if (!entryItem.standalone)
                                                                                                          Container(
                                                                                                            width: 3.0,
                                                                                                            height: double.infinity,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: () {
                                                                                                                if (entryItem.status == 'packed') {
                                                                                                                  return FlutterFlowTheme.of(context).packedGreen;
                                                                                                                } else if (entryItem.status == 'incomplete') {
                                                                                                                  return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                } else if (entryItem.status == 'unpacked') {
                                                                                                                  return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                                } else if (entryItem.status == 'event') {
                                                                                                                  return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                                } else {
                                                                                                                  return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                }
                                                                                                              }(),
                                                                                                            ),
                                                                                                          ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Container(
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(9.0, 0.0, 9.0, 0.0),
                                                                                                              child: Row(
                                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                                                crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                                                                                                                textBaseline: TextBaseline.alphabetic,
                                                                                                                children: [
                                                                                                                  Expanded(
                                                                                                                    flex: 1,
                                                                                                                    child: Column(
                                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                                      mainAxisAlignment: (FFMainAxisAlignment.center).flutterValue,
                                                                                                                      crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                                                                                                                      textBaseline: TextBaseline.alphabetic,
                                                                                                                      children: [
                                                                                                                        Row(
                                                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                                                          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                                                          crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                                                                                                                          textBaseline: TextBaseline.alphabetic,
                                                                                                                          children: [
                                                                                                                            if (entryItem.standalone)
                                                                                                                              Icon(
                                                                                                                                Icons.backpack_outlined,
                                                                                                                                color: () {
                                                                                                                                  if (entryItem.status == 'packed') {
                                                                                                                                    return FlutterFlowTheme.of(context).packedGreen;
                                                                                                                                  } else if (entryItem.status == 'incomplete') {
                                                                                                                                    return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                                  } else if (entryItem.status == 'unpacked') {
                                                                                                                                    return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                                                  } else if (entryItem.status == 'event') {
                                                                                                                                    return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                                                  } else {
                                                                                                                                    return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                                  }
                                                                                                                                }(),
                                                                                                                                size: 11.0,
                                                                                                                              ),
                                                                                                                            Expanded(
                                                                                                                              flex: 1,
                                                                                                                              child: Text(
                                                                                                                                entryItem.title,
                                                                                                                                maxLines: 1,
                                                                                                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                                      font: GoogleFonts.roboto(
                                                                                                                                        fontWeight: FontWeight.bold,
                                                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                      ),
                                                                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                                                                      fontSize: 12.0,
                                                                                                                                      letterSpacing: 0.0,
                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                      lineHeight: 1.05,
                                                                                                                                    ),
                                                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ].divide(SizedBox(width: 4.0)),
                                                                                                                        ),
                                                                                                                        if (!(entryItem.height == 25.0))
                                                                                                                          Text(
                                                                                                                            entryItem.subtitle,
                                                                                                                            maxLines: 1,
                                                                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                                  font: GoogleFonts.roboto(
                                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                                  fontSize: 10.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                  lineHeight: 1.05,
                                                                                                                                ),
                                                                                                                            overflow: TextOverflow.ellipsis,
                                                                                                                          ),
                                                                                                                      ],
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  if (entryItem.showProgress)
                                                                                                                    Container(
                                                                                                                      decoration: BoxDecoration(
                                                                                                                        color: () {
                                                                                                                          if (entryItem.status == 'packed') {
                                                                                                                            return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                                                          } else if (entryItem.status == 'incomplete') {
                                                                                                                            return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                                          } else if (entryItem.status == 'unpacked') {
                                                                                                                            return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                                                          } else if (entryItem.status == 'event') {
                                                                                                                            return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                                                          } else {
                                                                                                                            return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                                          }
                                                                                                                        }(),
                                                                                                                        borderRadius: BorderRadius.circular(12.0),
                                                                                                                        border: Border.all(
                                                                                                                          color: () {
                                                                                                                            if (entryItem.status == 'packed') {
                                                                                                                              return FlutterFlowTheme.of(context).packedGreen;
                                                                                                                            } else if (entryItem.status == 'incomplete') {
                                                                                                                              return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                            } else if (entryItem.status == 'unpacked') {
                                                                                                                              return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                                            } else if (entryItem.status == 'event') {
                                                                                                                              return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                                            } else {
                                                                                                                              return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                            }
                                                                                                                          }(),
                                                                                                                          width: 1.0,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                      child: Padding(
                                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(6.0, 3.0, 6.0, 3.0),
                                                                                                                        child: Text(
                                                                                                                          entryItem.progress,
                                                                                                                          maxLines: 1,
                                                                                                                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                                font: GoogleFonts.roboto(
                                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                ),
                                                                                                                                color: () {
                                                                                                                                  if (entryItem.status == 'packed') {
                                                                                                                                    return FlutterFlowTheme.of(context).packedGreen;
                                                                                                                                  } else if (entryItem.status == 'incomplete') {
                                                                                                                                    return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                                  } else if (entryItem.status == 'unpacked') {
                                                                                                                                    return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                                                  } else if (entryItem.status == 'event') {
                                                                                                                                    return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                                                  } else {
                                                                                                                                    return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                                                  }
                                                                                                                                }(),
                                                                                                                                fontSize: 10.0,
                                                                                                                                letterSpacing: 0.0,
                                                                                                                                fontWeight: FontWeight.bold,
                                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                lineHeight: 1.05,
                                                                                                                              ),
                                                                                                                          overflow: TextOverflow.ellipsis,
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  if (!entryItem.showProgress)
                                                                                                                    InkWell(
                                                                                                                      splashColor: Colors.transparent,
                                                                                                                      focusColor: Colors.transparent,
                                                                                                                      hoverColor: Colors.transparent,
                                                                                                                      highlightColor: Colors.transparent,
                                                                                                                      onTap: () async {
                                                                                                                        logFirebaseEvent('CALENDAR_PAGE_CalendarEventAi_ON_TAP');
                                                                                                                        if (!_model.calendarBusy!) {
                                                                                                                          _model.calendarBusy = true;
                                                                                                                          safeSetState(() {});
                                                                                                                          _model.calendarAfterEventDraft = await actions.calendarStudio(
                                                                                                                            context,
                                                                                                                            'draft',
                                                                                                                            _model.calendarView?.date,
                                                                                                                            _model.calendarMonth,
                                                                                                                            entryItem.eventKey,
                                                                                                                            '',
                                                                                                                            '',
                                                                                                                          );
                                                                                                                          _model.calendarView = _model.calendarAfterEventDraft;
                                                                                                                          safeSetState(() {});
                                                                                                                          _model.calendarBusy = false;
                                                                                                                          safeSetState(() {});
                                                                                                                        }

                                                                                                                        safeSetState(() {});
                                                                                                                      },
                                                                                                                      child: Container(
                                                                                                                        decoration: BoxDecoration(
                                                                                                                          color: FlutterFlowTheme.of(context).packedGreenTint,
                                                                                                                          borderRadius: BorderRadius.circular(7.0),
                                                                                                                          border: Border.all(
                                                                                                                            color: FlutterFlowTheme.of(context).packedGreen,
                                                                                                                            width: 1.0,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        child: Padding(
                                                                                                                          padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                                                                                                                          child: Text(
                                                                                                                            'AI Draft',
                                                                                                                            maxLines: 1,
                                                                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                                                  font: GoogleFonts.roboto(
                                                                                                                                    fontWeight: FontWeight.bold,
                                                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                  ),
                                                                                                                                  color: FlutterFlowTheme.of(context).packedGreen,
                                                                                                                                  fontSize: 10.0,
                                                                                                                                  letterSpacing: 0.0,
                                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                                                  lineHeight: 1.05,
                                                                                                                                ),
                                                                                                                            overflow: TextOverflow.ellipsis,
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                ].divide(SizedBox(width: 5.0)),
                                                                                                              ),
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
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                }).divide(
                                                                    SizedBox(
                                                                        width:
                                                                            2.0)),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                  if (valueOrDefault<bool>(
                                    (!_model.calendarBusy!
                                            ? (!_model.calendarView!.hasEvents
                                                ? !_model
                                                    .calendarView!.connected
                                                : false)
                                            : false)
                                        ? _model.calendarView?.live
                                        : false,
                                    false,
                                  ))
                                    Container(
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CALENDAR_CalendarEmptySources_ON_TAP');
                                          _model.calendarSourcesOpen = true;
                                          safeSetState(() {});
                                        },
                                        text: 'Choose calendars',
                                        options: FFButtonOptions(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Colors.transparent,
                                          textStyle: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .packedGreen,
                                          ),
                                          elevation: 0.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (_model.calendarSourcesOpen ?? true)
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.stretch).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.spaceBetween)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'Choose calendars',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .override(
                                              font: GoogleFonts.manrope(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CALENDAR_CalendarCloseSources_ON_TAP');
                                          _model.calendarSourcesOpen = false;
                                          safeSetState(() {});
                                        },
                                        text: 'Done',
                                        options: FFButtonOptions(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: Colors.transparent,
                                          textStyle: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .packedGreen,
                                          ),
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final calendarSource = _model
                                              .calendarView?.sources
                                              ?.toList() ??
                                          [];

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.start)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.center)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children:
                                            List.generate(calendarSource.length,
                                                (calendarSourceIndex) {
                                          final calendarSourceItem =
                                              calendarSource[
                                                  calendarSourceIndex];
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              if (calendarSourceItem.enabled)
                                                FlutterFlowIconButton(
                                                  buttonSize: 40.0,
                                                  icon: Icon(
                                                    Icons.check_box,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .packedGreen,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'CALENDAR_CalendarSourceDisable_ON_TAP');
                                                    if (!_model.calendarBusy!) {
                                                      _model.calendarBusy =
                                                          true;
                                                      safeSetState(() {});
                                                      _model.calendarWithSourceDisabled =
                                                          await actions
                                                              .calendarStudio(
                                                        context,
                                                        'toggle',
                                                        _model
                                                            .calendarView?.date,
                                                        _model.calendarMonth,
                                                        calendarSourceItem
                                                            .sourceKey,
                                                        '',
                                                        '',
                                                      );
                                                      _model.calendarView = _model
                                                          .calendarWithSourceDisabled;
                                                      safeSetState(() {});
                                                      _model.calendarBusy =
                                                          false;
                                                      safeSetState(() {});
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                ),
                                              if (!calendarSourceItem.enabled)
                                                FlutterFlowIconButton(
                                                  buttonSize: 40.0,
                                                  icon: Icon(
                                                    Icons
                                                        .check_box_outline_blank,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 22.0,
                                                  ),
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'CALENDAR_CalendarSourceEnable_ON_TAP');
                                                    if (!_model.calendarBusy!) {
                                                      _model.calendarBusy =
                                                          true;
                                                      safeSetState(() {});
                                                      _model.calendarWithSourceEnabled =
                                                          await actions
                                                              .calendarStudio(
                                                        context,
                                                        'toggle',
                                                        _model
                                                            .calendarView?.date,
                                                        _model.calendarMonth,
                                                        calendarSourceItem
                                                            .sourceKey,
                                                        '',
                                                        '',
                                                      );
                                                      _model.calendarView = _model
                                                          .calendarWithSourceEnabled;
                                                      safeSetState(() {});
                                                      _model.calendarBusy =
                                                          false;
                                                      safeSetState(() {});
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      (FFMainAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  crossAxisAlignment:
                                                      (FFCrossAxisAlignment
                                                              .start)
                                                          .flutterValue,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Text(
                                                      calendarSourceItem.name,
                                                      maxLines: 1,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .spaceGrotesk(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      calendarSourceItem
                                                          .provider,
                                                      maxLines: 1,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .spaceGrotesk(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (calendarSourceItem.removable)
                                                FlutterFlowIconButton(
                                                  buttonSize: 40.0,
                                                  icon: Icon(
                                                    Icons.link_off,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 21.0,
                                                  ),
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'CALENDAR_CalendarDisconnectOne_ON_TAP');
                                                    if (!_model.calendarBusy!) {
                                                      _model.calendarBusy =
                                                          true;
                                                      safeSetState(() {});
                                                      _model.calendarAfterDisconnectingSource =
                                                          await actions
                                                              .calendarStudio(
                                                        context,
                                                        'disconnect',
                                                        _model
                                                            .calendarView?.date,
                                                        _model.calendarMonth,
                                                        calendarSourceItem
                                                            .sourceKey,
                                                        '',
                                                        '',
                                                      );
                                                      _model.calendarView = _model
                                                          .calendarAfterDisconnectingSource;
                                                      safeSetState(() {});
                                                      _model.calendarBusy =
                                                          false;
                                                      safeSetState(() {});
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                ),
                                            ].divide(SizedBox(width: 4.0)),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CALENDAR_CalendarConnectGoogle_ON_TAP');
                                      if (!_model.calendarBusy!) {
                                        _model.calendarBusy = true;
                                        safeSetState(() {});
                                        _model.calendarAfterConnectingGoogle =
                                            await actions.calendarStudio(
                                          context,
                                          'google',
                                          _model.calendarView?.date,
                                          _model.calendarMonth,
                                          '',
                                          '',
                                          '',
                                        );
                                        _model.calendarView = _model
                                            .calendarAfterConnectingGoogle;
                                        safeSetState(() {});
                                        _model.calendarBusy = false;
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Connect Google Calendar',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Colors.transparent,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  if (_model.calendarView?.live ?? true)
                                    FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarRefreshSources_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.refreshedCalendars =
                                              await actions.calendarStudio(
                                            context,
                                            'refresh',
                                            _model.calendarView?.date,
                                            _model.calendarMonth,
                                            '',
                                            '',
                                            '',
                                          );
                                          _model.calendarView =
                                              _model.refreshedCalendars;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      text: 'Refresh selected',
                                      options: FFButtonOptions(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.transparent,
                                        textStyle: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreen,
                                        ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  if (_model.calendarView?.live ?? true)
                                    FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarDisconnectAll_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.calendarAfterDisconnectingSources =
                                              await actions.calendarStudio(
                                            context,
                                            'disconnect',
                                            _model.calendarView?.date,
                                            _model.calendarMonth,
                                            '',
                                            '',
                                            '',
                                          );
                                          _model.calendarView = _model
                                              .calendarAfterDisconnectingSources;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      text: 'Disconnect calendars',
                                      options: FFButtonOptions(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.transparent,
                                        textStyle: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .pendingYellow,
                                        ),
                                        elevation: 0.0,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  Container(
                                    height: 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                    ),
                                  ),
                                  Text(
                                    'Add Apple calendar',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    'Use a public iCloud Calendar link.',
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
                                  TextFormField(
                                    controller:
                                        _model.calendarAppleUrlTextController,
                                    focusNode: _model.calendarAppleUrlFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.calendarAppleUrlTextController',
                                      Duration(milliseconds: 2000),
                                      () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarAppleUrl_ON_TEXTFIELD_C');
                                        _model.calendarAppleUrl = _model
                                            .calendarAppleUrlTextController
                                            .text;
                                        safeSetState(() {});
                                      },
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Apple Calendar public link',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                    ),
                                    style: TextStyle(),
                                    maxLines: null,
                                    validator: _model
                                        .calendarAppleUrlTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller:
                                        _model.calendarAppleNameTextController,
                                    focusNode:
                                        _model.calendarAppleNameFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.calendarAppleNameTextController',
                                      Duration(milliseconds: 2000),
                                      () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarAppleName_ON_TEXTFIELD_');
                                        _model.calendarAppleName = _model
                                            .calendarAppleNameTextController
                                            .text;
                                        safeSetState(() {});
                                      },
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Calendar name (optional)',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                    ),
                                    style: TextStyle(),
                                    maxLines: null,
                                    validator: _model
                                        .calendarAppleNameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  TextFormField(
                                    controller:
                                        _model.calendarAppleColorTextController,
                                    focusNode:
                                        _model.calendarAppleColorFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.calendarAppleColorTextController',
                                      Duration(milliseconds: 2000),
                                      () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarAppleColor_ON_TEXTFIELD');
                                        _model.calendarAppleColor = _model
                                            .calendarAppleColorTextController
                                            .text;
                                        safeSetState(() {});
                                      },
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Calendar color (optional)',
                                      hintText: '#75A8DF',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                    ),
                                    style: TextStyle(),
                                    maxLines: null,
                                    validator: _model
                                        .calendarAppleColorTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CALENDAR_CalendarConnectApple_ON_TAP');
                                      if (!_model.calendarBusy!) {
                                        _model.calendarBusy = true;
                                        safeSetState(() {});
                                        _model.calendarAfterConnectingApple =
                                            await actions.calendarStudio(
                                          context,
                                          'apple',
                                          _model.calendarView?.date,
                                          _model.calendarMonth,
                                          _model.calendarAppleUrl,
                                          _model.calendarAppleName,
                                          _model.calendarAppleColor,
                                        );
                                        _model.calendarView =
                                            _model.calendarAfterConnectingApple;
                                        safeSetState(() {});
                                        _model.calendarBusy = false;
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Add calendar',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Colors.transparent,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 9.0)),
                              ),
                            ),
                          ),
                        ),
                      if (_model.calendarDetailsOpen!
                          ? !_model.calendarSourcesOpen!
                          : false)
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.stretch).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.spaceBetween)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.center)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          _model.calendarSelectedCard!.title,
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.close,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          logFirebaseEvent(
                                              'CALENDAR_CalendarCloseDetails_ON_TAP');
                                          _model.calendarDetailsOpen = false;
                                          safeSetState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _model.calendarSelectedCard!.source,
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _model.calendarSelectedCard!.dateLabel,
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.spaceGrotesk(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (_model.calendarSelectedCard?.repeats ??
                                      true)
                                    Text(
                                      _model.calendarSelectedCard!.repeatLabel,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if (!(_model.calendarSelectedCard?.location ==
                                      ''))
                                    Text(
                                      _model.calendarSelectedCard!.location,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.spaceGrotesk(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  if (!(_model.calendarSelectedCard?.notes ==
                                      ''))
                                    Text(
                                      _model.calendarSelectedCard!.notes,
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
                                  Builder(
                                    builder: (context) {
                                      final linkedList = _model
                                              .calendarSelectedCard?.lists
                                              ?.toList() ??
                                          [];

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            (FFMainAxisAlignment.start)
                                                .flutterValue,
                                        crossAxisAlignment:
                                            (FFCrossAxisAlignment.center)
                                                .flutterValue,
                                        textBaseline: TextBaseline.alphabetic,
                                        children:
                                            List.generate(linkedList.length,
                                                (linkedListIndex) {
                                          final linkedListItem =
                                              linkedList[linkedListIndex];
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                (FFMainAxisAlignment.start)
                                                    .flutterValue,
                                            crossAxisAlignment:
                                                (FFCrossAxisAlignment.center)
                                                    .flutterValue,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'CALENDAR_PAGE_CalendarOpenList_ON_TAP');
                                                    if (!_model.calendarBusy!) {
                                                      _model.calendarBusy =
                                                          true;
                                                      safeSetState(() {});
                                                      _model.calendarDetailsOpen =
                                                          false;
                                                      safeSetState(() {});
                                                      _model.calendarAfterLinkedPackingList =
                                                          await actions
                                                              .calendarStudio(
                                                        context,
                                                        'open',
                                                        _model
                                                            .calendarView?.date,
                                                        _model.calendarMonth,
                                                        linkedListItem.path,
                                                        '',
                                                        '',
                                                      );
                                                      _model.calendarView = _model
                                                          .calendarAfterLinkedPackingList;
                                                      safeSetState(() {});
                                                      _model.calendarBusy =
                                                          false;
                                                      safeSetState(() {});
                                                    }

                                                    safeSetState(() {});
                                                  },
                                                  text: linkedListItem.title,
                                                  options: FFButtonOptions(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Colors.transparent,
                                                    textStyle: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .packedGreen,
                                                    ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                linkedListItem.progress,
                                                maxLines: 1,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .pendingYellow,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ].divide(SizedBox(width: 7.0)),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CALENDAR_PAGE_CalendarDetailAi_ON_TAP');
                                      if (!_model.calendarBusy!) {
                                        _model.calendarBusy = true;
                                        safeSetState(() {});
                                        _model.calendarDetailsOpen = false;
                                        safeSetState(() {});
                                        _model.calendarAfterDetailsDraft =
                                            await actions.calendarStudio(
                                          context,
                                          'draft',
                                          _model.calendarView?.date,
                                          _model.calendarMonth,
                                          _model.calendarSelectedCard?.eventKey,
                                          '',
                                          '',
                                        );
                                        _model.calendarView =
                                            _model.calendarAfterDetailsDraft;
                                        safeSetState(() {});
                                        _model.calendarBusy = false;
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'AI Draft',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Colors.transparent,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'CALENDAR_CalendarDetailCreate_ON_TAP');
                                      if (!_model.calendarBusy!) {
                                        _model.calendarBusy = true;
                                        safeSetState(() {});
                                        _model.calendarDetailsOpen = false;
                                        safeSetState(() {});
                                        _model.calendarAfterCreatingPackingList =
                                            await actions.calendarStudio(
                                          context,
                                          'manual',
                                          _model.calendarView?.date,
                                          _model.calendarMonth,
                                          _model.calendarSelectedCard?.eventKey,
                                          '',
                                          '',
                                        );
                                        _model.calendarView = _model
                                            .calendarAfterCreatingPackingList;
                                        safeSetState(() {});
                                        _model.calendarBusy = false;
                                        safeSetState(() {});
                                      }

                                      safeSetState(() {});
                                    },
                                    text: 'Create packing list',
                                    options: FFButtonOptions(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Colors.transparent,
                                      textStyle: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                      ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  if (_model.calendarSelectedCard?.repeats ??
                                      true)
                                    FFButtonWidget(
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'CALENDAR_CalendarDetailSeries_ON_TAP');
                                        if (!_model.calendarBusy!) {
                                          _model.calendarBusy = true;
                                          safeSetState(() {});
                                          _model.calendarDetailsOpen = false;
                                          safeSetState(() {});
                                          _model.calendarAfterEditingSeries =
                                              await actions.calendarStudio(
                                            context,
                                            'series',
                                            _model.calendarView?.date,
                                            _model.calendarMonth,
                                            _model
                                                .calendarSelectedCard?.eventKey,
                                            '',
                                            '',
                                          );
                                          _model.calendarView =
                                              _model.calendarAfterEditingSeries;
                                          safeSetState(() {});
                                          _model.calendarBusy = false;
                                          safeSetState(() {});
                                        }

                                        safeSetState(() {});
                                      },
                                      text: 'Create a series packing list',
                                      options: FFButtonOptions(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Colors.transparent,
                                        textStyle: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreen,
                                        ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (!widget!.embedInTabShell)
                wrapWithModel(
                  model: _model.packReadyTabBarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PackReadyTabBarWidget(
                    activeTab: 'Calendar',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
