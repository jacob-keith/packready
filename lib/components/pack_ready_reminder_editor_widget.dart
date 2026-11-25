import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'pack_ready_reminder_editor_model.dart';
export 'pack_ready_reminder_editor_model.dart';

/// Native dialog for creating or editing a reminder.
class PackReadyReminderEditorWidget extends StatefulWidget {
  const PackReadyReminderEditorWidget({
    super.key,
    bool? editing,
    String? listPath,
    String? title,
    String? initialNote,
    this.initialDate,
  })  : this.editing = editing ?? false,
        this.listPath = listPath ?? '',
        this.title = title ?? '',
        this.initialNote = initialNote ?? '';

  final bool editing;
  final String listPath;
  final String title;
  final String initialNote;
  final DateTime? initialDate;

  @override
  State<PackReadyReminderEditorWidget> createState() =>
      _PackReadyReminderEditorWidgetState();
}

class _PackReadyReminderEditorWidgetState
    extends State<PackReadyReminderEditorWidget> {
  late PackReadyReminderEditorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackReadyReminderEditorModel());

    _model.reminderNoteTextController ??=
        TextEditingController(text: widget!.initialNote);
    _model.reminderNoteFocusNode ??= FocusNode();

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

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
      child: Container(
        child: Container(
          width: 420.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    widget!.editing ? 'Edit reminder' : 'New reminder',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  Container(
                    height: 16.0,
                  ),
                  if (!!(widget!.listPath == '')
                      ? (FFAppState().packReadySuggestionStatus == 'loading')
                      : false)
                    Container(
                      child: LinearPercentIndicator(
                        percent: 0.25,
                        lineHeight: 3.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).primary,
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        barRadius: Radius.circular(1.5),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  if (!!(widget!.listPath == '')
                      ? (FFAppState().packReadySuggestionStatus == 'error')
                      : false)
                    Text(
                      'Could not load activities. Close and try again.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
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
                  if (FFAppState().packReadySuggestionStatus == 'ready'
                      ? !(!(widget!.listPath == '')
                          ? true
                          : (FFAppState().packReadySuggestionStatus == 'ready'
                              ? !(FFAppState().packReadySuggestions.length == 0)
                              : false))
                      : false)
                    Text(
                      'No upcoming activities without a reminder.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
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
                  if (!(widget!.listPath == '')
                      ? true
                      : (FFAppState().packReadySuggestionStatus == 'ready'
                          ? !(FFAppState().packReadySuggestions.length == 0)
                          : false))
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.stretch).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (!(widget!.listPath == ''))
                          Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 4.0, 12.0, 4.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.center).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.start).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    'Activity',
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
                                  ),
                                  Text(
                                    widget!.title,
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
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!!(widget!.listPath == ''))
                          FlutterFlowDropDown<String>(
                            controller:
                                _model.reminderActivityValueController ??=
                                    FormFieldController<String>(null),
                            options: List<String>.from(
                                functions.packReadyReminderActivityOptions(
                                    FFAppState().packReadySuggestions.toList(),
                                    false)!),
                            optionLabels:
                                functions.packReadyReminderActivityOptions(
                                    FFAppState().packReadySuggestions.toList(),
                                    true)!,
                            onChanged: (val) async {
                              safeSetState(
                                  () => _model.reminderActivityValue = val);
                              logFirebaseEvent(
                                  'PACK_READY_REMINDER_EDITOR_ReminderActiv');
                              _model.saveError = '';
                              safeSetState(() {});
                            },
                            height: 48.0,
                            textStyle: FlutterFlowTheme.of(context)
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
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: 'Choose an activity',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24.0,
                            ),
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            elevation: 0.0,
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderWidth: 1.0,
                            borderRadius: 10.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            hidesUnderline: true,
                            disabled: _model.saving!,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                            labelText: 'Activity',
                            labelTextStyle: TextStyle(),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: _model.saving!
                                ? null
                                : () async {
                                    logFirebaseEvent(
                                        'PACK_READY_REMINDER_EDITOR_ReminderDateP');
                                    final _datePickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: (functions
                                              .packReadyReminderEditorDate(
                                                  _model.pickedDate,
                                                  widget!.initialDate,
                                                  true) ??
                                          DateTime.now()),
                                      firstDate: DateTime(1900),
                                      lastDate: (functions
                                              .packReadyReminderPickerLimit() ??
                                          DateTime(2050)),
                                      builder: (context, child) {
                                        return wrapInMaterialDatePickerTheme(
                                          context,
                                          child!,
                                          headerBackgroundColor:
                                              Color(0x00000000),
                                          headerForegroundColor:
                                              Color(0x00000000),
                                          headerTextStyle: TextStyle(),
                                          pickerBackgroundColor:
                                              Color(0x00000000),
                                          pickerForegroundColor:
                                              Color(0x00000000),
                                          selectedDateTimeBackgroundColor:
                                              Color(0x00000000),
                                          selectedDateTimeForegroundColor:
                                              Color(0x00000000),
                                          actionButtonForegroundColor:
                                              Color(0x00000000),
                                          iconSize: 24,
                                        );
                                      },
                                    );

                                    TimeOfDay? _datePickedTime;
                                    if (_datePickedDate != null) {
                                      _datePickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                            (functions
                                                    .packReadyReminderEditorDate(
                                                        _model.pickedDate,
                                                        widget!.initialDate,
                                                        true) ??
                                                DateTime.now())),
                                        builder: (context, child) {
                                          return wrapInMaterialTimePickerTheme(
                                            context,
                                            child!,
                                            headerBackgroundColor:
                                                Color(0x00000000),
                                            headerForegroundColor:
                                                Color(0x00000000),
                                            headerTextStyle: TextStyle(),
                                            pickerBackgroundColor:
                                                Color(0x00000000),
                                            pickerForegroundColor:
                                                Color(0x00000000),
                                            selectedDateTimeBackgroundColor:
                                                Color(0x00000000),
                                            selectedDateTimeForegroundColor:
                                                Color(0x00000000),
                                            actionButtonForegroundColor:
                                                Color(0x00000000),
                                            iconSize: 24,
                                          );
                                        },
                                      );
                                    }

                                    if (_datePickedDate != null &&
                                        _datePickedTime != null) {
                                      safeSetState(() {
                                        _model.datePicked = DateTime(
                                          _datePickedDate.year,
                                          _datePickedDate.month,
                                          _datePickedDate.day,
                                          _datePickedTime!.hour,
                                          _datePickedTime.minute,
                                        );
                                      });
                                    } else if (_model.datePicked != null) {
                                      safeSetState(() {
                                        _model.datePicked = functions
                                            .packReadyReminderEditorDate(
                                                _model.pickedDate,
                                                widget!.initialDate,
                                                true);
                                      });
                                    }
                                    if (_model.datePicked != null) {
                                      _model.pickedDate = _model.datePicked;
                                      safeSetState(() {});
                                      _model.saveError = '';
                                      safeSetState(() {});
                                    }
                                  },
                            text: functions.packReadyReminderDateLabel(
                                functions.packReadyReminderEditorDate(
                                    _model.pickedDate,
                                    widget!.initialDate,
                                    false))!,
                            icon: Icon(
                              Icons.event_outlined,
                              size: 20.0,
                            ),
                            options: FFButtonOptions(
                              height: 48.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _model.reminderNoteTextController,
                          focusNode: _model.reminderNoteFocusNode,
                          readOnly: (!(widget!.listPath == '')
                                  ? true
                                  : (FFAppState().packReadySuggestionStatus ==
                                          'ready'
                                      ? !(FFAppState()
                                              .packReadySuggestions
                                              .length ==
                                          0)
                                      : false))
                              ? _model.saving!
                              : true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Note (optional)',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                          ),
                          style: TextStyle(),
                          maxLines: 2,
                          minLines: 2,
                          validator: _model.reminderNoteTextControllerValidator
                              .asValidator(context),
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                  if (!(_model.saveError == ''))
                    Container(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: Text(
                          _model.saveError!,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                        ),
                      ),
                    ),
                  Container(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        flex: 1,
                        child: FFButtonWidget(
                          onPressed: _model.saving!
                              ? null
                              : () async {
                                  logFirebaseEvent(
                                      'PACK_READY_REMINDER_EDITOR_CancelReminde');
                                  Navigator.pop(context);
                                },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            height: 44.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            textStyle: TextStyle(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FFButtonWidget(
                          onPressed: ((!(widget!.listPath == '')
                                      ? true
                                      : (FFAppState()
                                                  .packReadySuggestionStatus ==
                                              'ready'
                                          ? !(FFAppState()
                                                  .packReadySuggestions
                                                  .length ==
                                              0)
                                          : false))
                                  ? _model.saving!
                                  : true)
                              ? null
                              : () async {
                                  logFirebaseEvent(
                                      'PACK_READY_REMINDER_EDITOR_SaveReminder_');
                                  _model.saving = true;
                                  safeSetState(() {});
                                  _model.saveError = '';
                                  safeSetState(() {});
                                  _model.savedReminder =
                                      await actions.writePackReadyReminder(
                                    'save',
                                    functions.packReadyReminderActivityPath(
                                        widget!.listPath,
                                        _model.reminderActivityValue),
                                    functions.packReadyReminderEditorDate(
                                        _model.pickedDate,
                                        widget!.initialDate,
                                        false),
                                    _model.reminderNoteTextController.text,
                                  );
                                  if (_model.savedReminder?.status == 'error') {
                                    _model.saving = false;
                                    safeSetState(() {});
                                    _model.saveError =
                                        _model.savedReminder?.message;
                                    safeSetState(() {});
                                  } else {
                                    if (_model.savedReminder?.status ==
                                        'queueWarning') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            _model.savedReminder!.message,
                                            style: TextStyle(),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                        ),
                                      );
                                    }
                                    Navigator.pop(context);
                                  }

                                  safeSetState(() {});
                                },
                          text: _model.saving! ? 'Saving…' : 'Save',
                          options: FFButtonOptions(
                            height: 44.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: TextStyle(
                              color: FlutterFlowTheme.of(context).onPrimary,
                            ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
