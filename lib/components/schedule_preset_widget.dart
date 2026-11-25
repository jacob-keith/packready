import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'schedule_preset_model.dart';
export 'schedule_preset_model.dart';

/// Quick dates and date and time pickers for a packing activity.
class SchedulePresetWidget extends StatefulWidget {
  const SchedulePresetWidget({
    super.key,
    this.selectedDate,
    bool? allowEarlierDates,
    this.onScheduleChanged,
  }) : this.allowEarlierDates = allowEarlierDates ?? false;

  /// Date and time currently selected by this page.
  final DateTime? selectedDate;

  /// Allow dates before the current selection.
  final bool allowEarlierDates;

  /// Update the page after a preset or picker changes the date and time.
  final Future Function(

      /// New date and time.
      DateTime newDate)? onScheduleChanged;

  @override
  State<SchedulePresetWidget> createState() => _SchedulePresetWidgetState();
}

class _SchedulePresetWidgetState extends State<SchedulePresetWidget> {
  late SchedulePresetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SchedulePresetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
      crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'Date',
          style: FlutterFlowTheme.of(context).titleSmall.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
        ),
        Wrap(
          spacing: 6.0,
          runSpacing: 0.0,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.none,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                logFirebaseEvent('Today_ON_TAP');
                // Return selected date and time
                await widget.onScheduleChanged?.call(
                  functions.scheduleCombineDateAndTime(
                      functions.schedulePresetDate(
                          getCurrentTimestamp, 0, false),
                      functions.scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)),
                );
              },
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: functions.scheduleSameDay(
                          functions.schedulePresetDate(
                              getCurrentTimestamp, 0, false),
                          functions.scheduleSelectedDate(
                              widget!.selectedDate, getCurrentTimestamp))
                      ? FlutterFlowTheme.of(context).accent1
                      : FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(9.0, 0.0, 9.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.center).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Today',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ].divide(SizedBox(width: 6.0)),
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
                logFirebaseEvent('Tomorrow_ON_TAP');
                // Return selected date and time
                await widget.onScheduleChanged?.call(
                  functions.scheduleCombineDateAndTime(
                      functions.schedulePresetDate(
                          getCurrentTimestamp, 1, false),
                      functions.scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)),
                );
              },
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: functions.scheduleSameDay(
                          functions.schedulePresetDate(
                              getCurrentTimestamp, 1, false),
                          functions.scheduleSelectedDate(
                              widget!.selectedDate, getCurrentTimestamp))
                      ? FlutterFlowTheme.of(context).accent1
                      : FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(9.0, 0.0, 9.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.center).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Tomorrow',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ].divide(SizedBox(width: 6.0)),
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
                logFirebaseEvent('ThisWeekend_ON_TAP');
                // Return selected date and time
                await widget.onScheduleChanged?.call(
                  functions.scheduleCombineDateAndTime(
                      functions.schedulePresetDate(
                          getCurrentTimestamp, 0, true),
                      functions.scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)),
                );
              },
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                  color: functions.scheduleSameDay(
                          functions.schedulePresetDate(
                              getCurrentTimestamp, 0, true),
                          functions.scheduleSelectedDate(
                              widget!.selectedDate, getCurrentTimestamp))
                      ? FlutterFlowTheme.of(context).accent1
                      : FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(9.0, 0.0, 9.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                        (FFMainAxisAlignment.center).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'This Weekend',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.spaceGrotesk(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ].divide(SizedBox(width: 6.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('ChooseDate_ON_TAP');
            // Choose a date
            final _datePicked1Date = await showDatePicker(
              context: context,
              initialDate: functions.scheduleSelectedDate(
                  widget!.selectedDate, getCurrentTimestamp),
              firstDate: (functions.scheduleEarliestDate(
                      widget!.allowEarlierDates,
                      functions.scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)) ??
                  DateTime(1900)),
              lastDate: DateTime(2050),
              builder: (context, child) {
                return wrapInMaterialDatePickerTheme(
                  context,
                  child!,
                  headerBackgroundColor: Color(0x00000000),
                  headerForegroundColor: Color(0x00000000),
                  headerTextStyle: TextStyle(),
                  pickerBackgroundColor: Color(0x00000000),
                  pickerForegroundColor: Color(0x00000000),
                  selectedDateTimeBackgroundColor: Color(0x00000000),
                  selectedDateTimeForegroundColor: Color(0x00000000),
                  actionButtonForegroundColor: Color(0x00000000),
                  iconSize: 24,
                );
              },
            );

            if (_datePicked1Date != null) {
              safeSetState(() {
                _model.datePicked1 = DateTime(
                  _datePicked1Date.year,
                  _datePicked1Date.month,
                  _datePicked1Date.day,
                );
              });
            } else if (_model.datePicked1 != null) {
              safeSetState(() {
                _model.datePicked1 = functions.scheduleSelectedDate(
                    widget!.selectedDate, getCurrentTimestamp);
              });
            }
            if (_model.datePicked1 != null) {
              // Return selected date and time
              await widget.onScheduleChanged?.call(
                functions.scheduleCombineDateAndTime(
                    _model.datePicked1!,
                    functions.scheduleSelectedDate(
                        widget!.selectedDate, getCurrentTimestamp)),
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: 90.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(27.0, 0.0, 27.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.center).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    width: double.infinity,
                    height: 24.0,
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 238.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            flex: 118,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "MMMM",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'month',
                                          -1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 52,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "d",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'day',
                                          -1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 52,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "y",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'year',
                                          -1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 34.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).selectedSurface,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 238.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            flex: 118,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "MMMM",
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 52,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "d",
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 52,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "y",
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 24.0,
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 238.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            flex: 118,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "MMMM",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'month',
                                          1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 52,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "d",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'day',
                                          1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 52,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "y",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'year',
                                          1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 8.0,
        ),
        Text(
          'Time',
          style: FlutterFlowTheme.of(context).titleSmall.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).titleSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('ChooseTime_ON_TAP');
            // Choose a time

            final _datePicked2Time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(
                  functions.scheduleSelectedDate(
                      widget!.selectedDate, getCurrentTimestamp)),
              builder: (context, child) {
                return wrapInMaterialTimePickerTheme(
                  context,
                  child!,
                  headerBackgroundColor: Color(0x00000000),
                  headerForegroundColor: Color(0x00000000),
                  headerTextStyle: TextStyle(),
                  pickerBackgroundColor: Color(0x00000000),
                  pickerForegroundColor: Color(0x00000000),
                  selectedDateTimeBackgroundColor: Color(0x00000000),
                  selectedDateTimeForegroundColor: Color(0x00000000),
                  actionButtonForegroundColor: Color(0x00000000),
                  iconSize: 24,
                );
              },
            );
            if (_datePicked2Time != null) {
              safeSetState(() {
                _model.datePicked2 = DateTime(
                  functions
                      .scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)
                      .year,
                  functions
                      .scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)
                      .month,
                  functions
                      .scheduleSelectedDate(
                          widget!.selectedDate, getCurrentTimestamp)
                      .day,
                  _datePicked2Time.hour,
                  _datePicked2Time.minute,
                );
              });
            } else if (_model.datePicked2 != null) {
              safeSetState(() {
                _model.datePicked2 = functions.scheduleSelectedDate(
                    widget!.selectedDate, getCurrentTimestamp);
              });
            }
            if (_model.datePicked2 != null) {
              // Return selected date and time
              await widget.onScheduleChanged?.call(
                functions.scheduleCombineDateAndTime(
                    functions.scheduleSelectedDate(
                        widget!.selectedDate, getCurrentTimestamp),
                    _model.datePicked2!),
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: 90.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
            ),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(27.0, 0.0, 27.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.center).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Container(
                    width: double.infinity,
                    height: 24.0,
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 164.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            flex: 42,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "hh",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'hour',
                                          -1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 34,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          ),
                          Expanded(
                            flex: 42,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "mm",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'minute',
                                          -1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 46,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Visibility(
                                visible: functions.scheduleIsAfternoon(
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                child: Opacity(
                                  opacity: 0.55,
                                  child: Text(
                                    dateTimeFormat(
                                        "a",
                                        functions.scheduleWheelNeighbor(
                                            functions.scheduleSelectedDate(
                                                widget!.selectedDate,
                                                getCurrentTimestamp),
                                            'period',
                                            1)),
                                    maxLines: 1,
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
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.05,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 34.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).selectedSurface,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 164.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            flex: 42,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "hh",
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 34,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                ':',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 42,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "mm",
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 46,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "a",
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.05,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 24.0,
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 164.0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Expanded(
                            flex: 42,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "hh",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'hour',
                                          1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 34,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                            ),
                          ),
                          Expanded(
                            flex: 42,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Opacity(
                                opacity: 0.55,
                                child: Text(
                                  dateTimeFormat(
                                      "mm",
                                      functions.scheduleWheelNeighbor(
                                          functions.scheduleSelectedDate(
                                              widget!.selectedDate,
                                              getCurrentTimestamp),
                                          'minute',
                                          1)),
                                  maxLines: 1,
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
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.05,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 46,
                            child: Container(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Visibility(
                                visible: !functions.scheduleIsAfternoon(
                                    functions.scheduleSelectedDate(
                                        widget!.selectedDate,
                                        getCurrentTimestamp)),
                                child: Opacity(
                                  opacity: 0.55,
                                  child: Text(
                                    dateTimeFormat(
                                        "a",
                                        functions.scheduleWheelNeighbor(
                                            functions.scheduleSelectedDate(
                                                widget!.selectedDate,
                                                getCurrentTimestamp),
                                            'period',
                                            1)),
                                    maxLines: 1,
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
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                          lineHeight: 1.05,
                                        ),
                                  ),
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
          ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
