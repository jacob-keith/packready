import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'template_editor_model.dart';
export 'template_editor_model.dart';

class TemplateEditorWidget extends StatefulWidget {
  const TemplateEditorWidget({
    super.key,
    this.templateRef,
    this.startName,
    this.startActivity,
    this.startStarter,
    this.startItems,
    this.calendarAi,
    this.calendarPrompt,
    this.calendarActivityMode,
    this.startAiExtras,
    this.startFromAiDraft,
  });

  final DocumentReference? templateRef;
  final String? startName;
  final String? startActivity;
  final String? startStarter;
  final List<PackItemStruct>? startItems;

  /// Edit DSL param calendarAi
  final dynamic calendarAi;

  /// Edit DSL param calendarPrompt
  final bool? calendarPrompt;

  /// Edit DSL param calendarActivityMode
  final bool? calendarActivityMode;

  final List<PackItemStruct>? startAiExtras;

  /// Edit DSL param calendarActivityMode
  final bool? startFromAiDraft;

  static String routeName = 'TemplateEditor';
  static String routePath = '/templateEditor';

  @override
  State<TemplateEditorWidget> createState() => _TemplateEditorWidgetState();
}

class _TemplateEditorWidgetState extends State<TemplateEditorWidget> {
  late TemplateEditorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TemplateEditorModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'TemplateEditor'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('TEMPLATE_EDITOR_TemplateEditor_ON_INIT_S');
      _model.tItems = widget!.startItems!.toList().cast<PackItemStruct>();
      safeSetState(() {});
      if (widget!.startFromAiDraft == true) {
        _model.remainingAiItems =
            widget!.startAiExtras!.toList().cast<PackItemStruct>();
        _model.hasAiDraft = true;
        safeSetState(() {});
      }
      if (widget!.calendarActivityMode == true) {
        // Load checklist draft for this calendar event
        _model.calendarAiPrefill = await actions.openCalendarAiEditor(
          context,
          widget!.calendarAi,
        );
        if (widget!.calendarPrompt == true) {
          _model.showAiPrompt = true;
          safeSetState(() {});
        }
        if (!(_model.calendarAiPrefill?.title == '')) {
          safeSetState(() {
            _model.nameFieldTextController?.text =
                _model.calendarAiPrefill!.title;
          });
          _model.tItems =
              _model.calendarAiPrefill!.items.toList().cast<PackItemStruct>();
          safeSetState(() {});
          _model.remainingAiItems =
              _model.calendarAiPrefill!.extras.toList().cast<PackItemStruct>();
          safeSetState(() {});
          _model.hasAiDraft = true;
          safeSetState(() {});
        }
      }
      // Update the AI draft schedule
      await actions.syncNativeAiSchedule(
        context,
        'refresh',
        getCurrentTimestamp,
        '',
        false,
      );
      safeSetState(() {
        _model.aiDraftLocationTextController?.text =
            FFAppState().nativeAiSchedule.location;
      });
    });

    _model.nameFieldTextController ??=
        TextEditingController(text: widget!.startName);
    _model.nameFieldFocusNode ??= FocusNode();

    _model.modifyChecklistPromptTextController ??= TextEditingController();
    _model.modifyChecklistPromptFocusNode ??= FocusNode();

    _model.aiDraftPromptTextController ??= TextEditingController();
    _model.aiDraftPromptFocusNode ??= FocusNode();

    _model.aiDraftLocationTextController ??= TextEditingController();
    _model.aiDraftLocationFocusNode ??= FocusNode();

    _model.itemNameFieldTextController ??= TextEditingController();
    _model.itemNameFieldFocusNode ??= FocusNode();

    _model.itemDetailFieldTextController ??= TextEditingController();
    _model.itemDetailFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
            crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
            textBaseline: TextBaseline.alphabetic,
            children: [
              FlutterFlowIconButton(
                buttonSize: 40.0,
                icon: Icon(
                  Icons.arrow_back,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 22.0,
                ),
                onPressed: () async {
                  logFirebaseEvent('TEMPLATE_EDITOR_ChecklistBack_ON_TAP');
                  // Go back
                  context.pop();
                },
              ),
              Text(
                functions.calendarAiEditorTitle(widget!.calendarActivityMode)!,
                maxLines: 1,
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      font: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ].divide(SizedBox(width: 8.0)),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Checklist name',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.nameFieldTextController,
                        focusNode: _model.nameFieldFocusNode,
                        autofocus: false,
                        enabled: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
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
                          hintText: 'Name your checklist (e.g. My gym bag)',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.spaceGrotesk(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).linkGreen,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                        validator: _model.nameFieldTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ),
                  if (!(widget!.calendarActivityMode == true))
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.start).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          FFButtonWidget(
                            onPressed: (_model.modifyPromptBusy!
                                    ? true
                                    : !(FFAppState()
                                            .nativeChecklistVoicePhase ==
                                        ''))
                                ? null
                                : () async {
                                    logFirebaseEvent(
                                        'TEMPLATE_EDITOR_OpenModifyChecklist_ON_T');
                                    _model.modifyPromptOpen =
                                        !(_model.modifyPromptOpen ?? true);
                                    safeSetState(() {});
                                  },
                            text: 'Modify with AI',
                            icon: Icon(
                              FFIcons.kautomationWave,
                              size: 16.0,
                            ),
                            options: FFButtonOptions(
                              height: 30.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 8.0, 0.0),
                              iconColor: FlutterFlowTheme.of(context).primary,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
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
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          if (_model.modifyPromptOpen ?? true)
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      (FFMainAxisAlignment.start).flutterValue,
                                  crossAxisAlignment:
                                      (FFCrossAxisAlignment.stretch)
                                          .flutterValue,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
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
                                              child: TextFormField(
                                                controller: _model
                                                    .modifyChecklistPromptTextController,
                                                focusNode: _model
                                                    .modifyChecklistPromptFocusNode,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'e.g. Cut to 5 essentials and add life jackets',
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                ),
                                                style: TextStyle(),
                                                maxLines: 3,
                                                minLines: 2,
                                                validator: _model
                                                    .modifyChecklistPromptTextControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                            if ((isAndroid ? true : isWeb)
                                                ? !!(FFAppState()
                                                        .nativeChecklistVoicePhase ==
                                                    '')
                                                : false)
                                              FlutterFlowIconButton(
                                                buttonSize: 48.0,
                                                icon: Icon(
                                                  Icons.mic_none,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 22.0,
                                                ),
                                                onPressed:
                                                    _model.modifyPromptBusy!
                                                        ? null
                                                        : () async {
                                                            logFirebaseEvent(
                                                                'TEMPLATE_EDITOR_RecordChecklistPrompt_ON');
                                                            // Record the spoken prompt
                                                            _model.nativeChecklistTranscript =
                                                                await actions
                                                                    .nativeChecklistDictation(
                                                              context,
                                                              false,
                                                            );
                                                            if (!(_model
                                                                    .nativeChecklistTranscript ==
                                                                '')) {
                                                              safeSetState(() {
                                                                _model
                                                                    .modifyChecklistPromptTextController
                                                                    ?.text = ((String?
                                                                            before,
                                                                        String?
                                                                            transcript) {
                                                                  return ((before ??
                                                                              '')
                                                                          .trimRight()
                                                                          .isEmpty
                                                                      ? (transcript ??
                                                                          '')
                                                                      : (before ?? '')
                                                                              .trimRight() +
                                                                          '\n' +
                                                                          (transcript ??
                                                                              ''));
                                                                }(
                                                                    _model
                                                                        .modifyChecklistPromptTextController
                                                                        .text,
                                                                    _model
                                                                        .nativeChecklistTranscript))!;
                                                              });
                                                            }

                                                            safeSetState(() {});
                                                          },
                                              ),
                                            if (FFAppState()
                                                    .nativeChecklistVoicePhase ==
                                                'recording')
                                              FlutterFlowIconButton(
                                                buttonSize: 48.0,
                                                icon: Icon(
                                                  Icons.stop_circle,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  size: 22.0,
                                                ),
                                                onPressed: () async {
                                                  logFirebaseEvent(
                                                      'TEMPLATE_EDITOR_StopChecklistRecording_O');
                                                  // Stop recording and transcribe the prompt
                                                  _model.nativeChecklistDictationResult =
                                                      await actions
                                                          .nativeChecklistDictation(
                                                    context,
                                                    true,
                                                  );

                                                  safeSetState(() {});
                                                },
                                              ),
                                            if (!(FFAppState()
                                                        .nativeChecklistVoicePhase ==
                                                    '')
                                                ? !(FFAppState()
                                                        .nativeChecklistVoicePhase ==
                                                    'recording')
                                                : false)
                                              Container(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child:
                                                      CircularPercentIndicator(
                                                    percent: 0.0,
                                                    radius: 12.0,
                                                    lineWidth: 2.0,
                                                    animation: false,
                                                    animateFromLastPercent:
                                                        true,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: (_model.modifyPromptBusy!
                                                  ? true
                                                  : !(FFAppState()
                                                          .nativeChecklistVoicePhase ==
                                                      ''))
                                              ? null
                                              : () async {
                                                  logFirebaseEvent(
                                                      'TEMPLATE_EDITOR_ApplyChecklistModificati');
                                                  if (((String? value) {
                                                    return (value ?? '')
                                                        .trim()
                                                        .isEmpty;
                                                  }(_model
                                                      .modifyChecklistPromptTextController
                                                      .text))!) {
                                                    // Show message: Describe how you want to modify this checklist.
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Describe how you want to modify this checklist.',
                                                          style: TextStyle(),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 4000),
                                                      ),
                                                    );
                                                  } else {
                                                    _model.modifyPromptBusy =
                                                        true;
                                                    safeSetState(() {});
                                                    // Apply AI changes to the checklist
                                                    _model.nativeModifiedChecklist =
                                                        await actions
                                                            .modifyNativeChecklist(
                                                      context,
                                                      _model
                                                          .modifyChecklistPromptTextController
                                                          .text,
                                                      _model
                                                          .nameFieldTextController
                                                          .text,
                                                      _model.tItems.toList(),
                                                    );
                                                    if (!(_model
                                                            .nativeModifiedChecklist
                                                            ?.title ==
                                                        '')) {
                                                      safeSetState(() {
                                                        _model.nameFieldTextController
                                                                ?.text =
                                                            _model
                                                                .nativeModifiedChecklist!
                                                                .title;
                                                      });
                                                      safeSetState(() {
                                                        _model
                                                            .itemNameFieldTextController
                                                            ?.clear();
                                                      });
                                                      safeSetState(() {
                                                        _model
                                                            .itemDetailFieldTextController
                                                            ?.clear();
                                                      });
                                                      _model.tItems = _model
                                                          .nativeModifiedChecklist!
                                                          .items
                                                          .toList()
                                                          .cast<
                                                              PackItemStruct>();
                                                      safeSetState(() {});
                                                      safeSetState(() {
                                                        _model
                                                            .modifyChecklistPromptTextController
                                                            ?.clear();
                                                      });
                                                      _model.modifyPromptOpen =
                                                          false;
                                                      safeSetState(() {});
                                                    }
                                                    _model.modifyPromptBusy =
                                                        false;
                                                    safeSetState(() {});
                                                  }

                                                  safeSetState(() {});
                                                },
                                          text: _model.modifyPromptBusy!
                                              ? 'Updating…'
                                              : 'Apply',
                                          icon: Icon(
                                            FFIcons.kautomationWave,
                                            size: 16.0,
                                          ),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            iconColor:
                                                FlutterFlowTheme.of(context)
                                                    .onPrimary,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .onPrimary,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: (_model.modifyPromptBusy!
                                                  ? true
                                                  : !(FFAppState()
                                                          .nativeChecklistVoicePhase ==
                                                      ''))
                                              ? null
                                              : () async {
                                                  logFirebaseEvent(
                                                      'TEMPLATE_EDITOR_PAGE_Button_ON_TAP');
                                                  _model.modifyPromptOpen =
                                                      false;
                                                  safeSetState(() {});
                                                },
                                          text: 'Cancel',
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Colors.transparent,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                              ),
                            ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ),
                  if (widget!.calendarActivityMode == true)
                    Container(
                      child: Visibility(
                        visible:
                            functions.isNewAiChecklist(widget!.templateRef) ??
                                true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                              (FFMainAxisAlignment.start).flutterValue,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.start).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            if (!_model.hasAiDraft!)
                              FFButtonWidget(
                                onPressed: _model.aiGenerating!
                                    ? null
                                    : () async {
                                        logFirebaseEvent(
                                            'TEMPLATE_EDITOR_PAGE_Button_ON_TAP');
                                        _model.showAiPrompt =
                                            !(_model.showAiPrompt ?? true);
                                        safeSetState(() {});
                                      },
                                text: 'AI Draft',
                                icon: Icon(
                                  Icons.auto_awesome,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  height: 38.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconColor:
                                      FlutterFlowTheme.of(context).primary,
                                  color: Colors.transparent,
                                  textStyle: TextStyle(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            if (_model.hasAiDraft ?? true)
                              FFButtonWidget(
                                onPressed: _model.aiGenerating!
                                    ? null
                                    : () async {
                                        logFirebaseEvent(
                                            'TEMPLATE_EDITOR_PAGE_Button_ON_TAP');
                                        _model.showAiPrompt =
                                            !(_model.showAiPrompt ?? true);
                                        safeSetState(() {});
                                      },
                                text: 'Tweak prompt',
                                icon: Icon(
                                  Icons.auto_awesome,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  height: 44.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 8.0, 12.0, 8.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconColor:
                                      FlutterFlowTheme.of(context).primary,
                                  color: Colors.transparent,
                                  textStyle: TextStyle(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            if (_model.showAiPrompt ?? true)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.start).flutterValue,
                                crossAxisAlignment:
                                    (FFCrossAxisAlignment.start).flutterValue,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  TextFormField(
                                    controller:
                                        _model.aiDraftPromptTextController,
                                    focusNode: _model.aiDraftPromptFocusNode,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText:
                                          'Describe your activity and what you need to pack.',
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
                                    maxLines: 3,
                                    validator: _model
                                        .aiDraftPromptTextControllerValidator
                                        .asValidator(context),
                                  ),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 6.0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.start,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      FFButtonWidget(
                                        onPressed: _model.aiGenerating!
                                            ? null
                                            : () async {
                                                logFirebaseEvent(
                                                    'TEMPLATE_EDITOR_AiGenerateButton_ON_TAP');
                                                _model.aiGenerating = true;
                                                safeSetState(() {});
                                                // Generate checklist suggestions with AI
                                                _model.liveAiDraft =
                                                    await actions
                                                        .generateAiEditorDraft(
                                                  context,
                                                  _model
                                                      .aiDraftPromptTextController
                                                      .text,
                                                  false,
                                                  true,
                                                );
                                                _model.aiGenerating = false;
                                                safeSetState(() {});
                                                if (!(_model
                                                        .liveAiDraft?.title ==
                                                    '')) {
                                                  safeSetState(() {
                                                    _model.nameFieldTextController
                                                            ?.text =
                                                        _model
                                                            .liveAiDraft!.title;
                                                  });
                                                  safeSetState(() {
                                                    _model
                                                        .itemNameFieldTextController
                                                        ?.clear();
                                                  });
                                                  safeSetState(() {
                                                    _model
                                                        .itemDetailFieldTextController
                                                        ?.clear();
                                                  });
                                                  _model.tItems = _model
                                                      .liveAiDraft!.items
                                                      .toList()
                                                      .cast<PackItemStruct>();
                                                  safeSetState(() {});
                                                  _model.remainingAiItems =
                                                      _model
                                                          .liveAiDraft!.extras
                                                          .toList()
                                                          .cast<
                                                              PackItemStruct>();
                                                  safeSetState(() {});
                                                  _model.hasAiDraft = true;
                                                  safeSetState(() {});
                                                  _model.showAiPrompt = false;
                                                  safeSetState(() {});
                                                }
                                                // Update the AI draft schedule
                                                await actions
                                                    .syncNativeAiSchedule(
                                                  context,
                                                  'refresh',
                                                  getCurrentTimestamp,
                                                  '',
                                                  false,
                                                );
                                                safeSetState(() {
                                                  _model.aiDraftLocationTextController
                                                          ?.text =
                                                      FFAppState()
                                                          .nativeAiSchedule
                                                          .location;
                                                });

                                                safeSetState(() {});
                                              },
                                        text: 'Generate draft',
                                        icon: Icon(
                                          Icons.auto_awesome,
                                          size: 20.0,
                                        ),
                                        options: FFButtonOptions(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconColor: Colors.white,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      if (!(widget!.calendarActivityMode ==
                                          true))
                                        FFButtonWidget(
                                          onPressed: _model.aiGenerating!
                                              ? null
                                              : () async {
                                                  logFirebaseEvent(
                                                      'TEMPLATE_EDITOR_AiSampleButton_ON_TAP');
                                                  _model.aiGenerating = true;
                                                  safeSetState(() {});
                                                  // Generate checklist suggestions with AI
                                                  _model.sampleAiDraft =
                                                      await actions
                                                          .generateAiEditorDraft(
                                                    context,
                                                    _model
                                                        .aiDraftPromptTextController
                                                        .text,
                                                    true,
                                                    true,
                                                  );
                                                  _model.aiGenerating = false;
                                                  safeSetState(() {});
                                                  if (!(_model.sampleAiDraft
                                                          ?.title ==
                                                      '')) {
                                                    safeSetState(() {
                                                      _model.nameFieldTextController
                                                              ?.text =
                                                          _model.sampleAiDraft!
                                                              .title;
                                                    });
                                                    safeSetState(() {
                                                      _model
                                                          .itemNameFieldTextController
                                                          ?.clear();
                                                    });
                                                    safeSetState(() {
                                                      _model
                                                          .itemDetailFieldTextController
                                                          ?.clear();
                                                    });
                                                    _model.tItems = _model
                                                        .sampleAiDraft!.items
                                                        .toList()
                                                        .cast<PackItemStruct>();
                                                    safeSetState(() {});
                                                    _model.remainingAiItems =
                                                        _model.sampleAiDraft!
                                                            .extras
                                                            .toList()
                                                            .cast<
                                                                PackItemStruct>();
                                                    safeSetState(() {});
                                                    _model.hasAiDraft = true;
                                                    safeSetState(() {});
                                                    _model.showAiPrompt = false;
                                                    safeSetState(() {});
                                                  }
                                                  // Update the AI draft schedule
                                                  await actions
                                                      .syncNativeAiSchedule(
                                                    context,
                                                    'refresh',
                                                    getCurrentTimestamp,
                                                    '',
                                                    false,
                                                  );
                                                  safeSetState(() {
                                                    _model.aiDraftLocationTextController
                                                            ?.text =
                                                        FFAppState()
                                                            .nativeAiSchedule
                                                            .location;
                                                  });

                                                  safeSetState(() {});
                                                },
                                          text: 'Try a sample',
                                          options: FFButtonOptions(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Colors.transparent,
                                            textStyle: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                            ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                    ],
                                  ),
                                  if (_model.aiGenerating ?? true)
                                    Text(
                                      'Drafting…',
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
                                ].divide(SizedBox(height: 8.0)),
                              ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                    ),
                  if (_model.hasAiDraft ?? true)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.start).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (FFAppState().nativeAiSchedule.ready)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.start).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                if (FFAppState().nativeAiSchedule.linked)
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).accent1,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          11.0, 9.0, 11.0, 9.0),
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
                                          Icon(
                                            Icons.link,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 16.0,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              FFAppState()
                                                  .nativeAiSchedule
                                                  .title,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 8.0)),
                                      ),
                                    ),
                                  ),
                                if (FFAppState().nativeAiSchedule.editableDay)
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    alignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
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
                                          logFirebaseEvent(
                                              'TEMPLATE_EDITOR_PAGE_AiDraftDate_ON_TAP');
                                          final _datePicked1Date =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: (FFAppState()
                                                    .nativeAiSchedule
                                                    .date ??
                                                DateTime.now()),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2050),
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

                                          if (_datePicked1Date != null) {
                                            safeSetState(() {
                                              _model.datePicked1 = DateTime(
                                                _datePicked1Date.year,
                                                _datePicked1Date.month,
                                                _datePicked1Date.day,
                                              );
                                            });
                                          } else if (_model.datePicked1 !=
                                              null) {
                                            safeSetState(() {
                                              _model.datePicked1 = FFAppState()
                                                  .nativeAiSchedule
                                                  .date;
                                            });
                                          }
                                          if (((DateTime? value) {
                                            return value != null;
                                          }(_model.datePicked1))!) {
                                            // Update the AI draft schedule
                                            await actions.syncNativeAiSchedule(
                                              context,
                                              'date',
                                              _model.datePicked1,
                                              '',
                                              false,
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 34.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    9.0, 0.0, 9.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  (FFMainAxisAlignment.center)
                                                      .flutterValue,
                                              crossAxisAlignment:
                                                  (FFCrossAxisAlignment.center)
                                                      .flutterValue,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  size: 15.0,
                                                ),
                                                Text(
                                                  dateTimeFormat(
                                                      "EEE, MMM d",
                                                      FFAppState()
                                                          .nativeAiSchedule
                                                          .date!),
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                ),
                                              ].divide(SizedBox(width: 6.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (FFAppState()
                                          .nativeAiSchedule
                                          .hasCalendar)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'TEMPLATE_EDITOR_AiDraftStartTime_ON_TAP');

                                            final _datePicked2Time =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(
                                                      (FFAppState()
                                                              .nativeAiSchedule
                                                              .start ??
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
                                            if (_datePicked2Time != null) {
                                              safeSetState(() {
                                                _model.datePicked2 = DateTime(
                                                  (FFAppState()
                                                              .nativeAiSchedule
                                                              .start ??
                                                          DateTime.now())
                                                      .year,
                                                  (FFAppState()
                                                              .nativeAiSchedule
                                                              .start ??
                                                          DateTime.now())
                                                      .month,
                                                  (FFAppState()
                                                              .nativeAiSchedule
                                                              .start ??
                                                          DateTime.now())
                                                      .day,
                                                  _datePicked2Time.hour,
                                                  _datePicked2Time.minute,
                                                );
                                              });
                                            } else if (_model.datePicked2 !=
                                                null) {
                                              safeSetState(() {
                                                _model.datePicked2 =
                                                    FFAppState()
                                                        .nativeAiSchedule
                                                        .start;
                                              });
                                            }
                                            if (((DateTime? value) {
                                              return value != null;
                                            }(_model.datePicked2))!) {
                                              // Update the AI draft schedule
                                              await actions
                                                  .syncNativeAiSchedule(
                                                context,
                                                'start',
                                                _model.datePicked2,
                                                '',
                                                false,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 34.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(9.0, 0.0, 9.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    (FFMainAxisAlignment.center)
                                                        .flutterValue,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment
                                                            .center)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Icon(
                                                    Icons.schedule,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 15.0,
                                                  ),
                                                  Text(
                                                    FFAppState()
                                                            .nativeAiSchedule
                                                            .allDay
                                                        ? 'Add time'
                                                        : dateTimeFormat(
                                                            "h:mm a",
                                                            FFAppState()
                                                                .nativeAiSchedule
                                                                .start!),
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                                  ),
                                                ].divide(SizedBox(width: 6.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (FFAppState()
                                              .nativeAiSchedule
                                              .hasCalendar
                                          ? !FFAppState()
                                              .nativeAiSchedule
                                              .allDay
                                          : false)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'TEMPLATE_EDITOR_AiDraftEndTime_ON_TAP');

                                            final _datePicked3Time =
                                                await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(
                                                      (FFAppState()
                                                              .nativeAiSchedule
                                                              .end ??
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
                                            if (_datePicked3Time != null) {
                                              safeSetState(() {
                                                _model.datePicked3 = DateTime(
                                                  (FFAppState()
                                                              .nativeAiSchedule
                                                              .end ??
                                                          DateTime.now())
                                                      .year,
                                                  (FFAppState()
                                                              .nativeAiSchedule
                                                              .end ??
                                                          DateTime.now())
                                                      .month,
                                                  (FFAppState()
                                                              .nativeAiSchedule
                                                              .end ??
                                                          DateTime.now())
                                                      .day,
                                                  _datePicked3Time.hour,
                                                  _datePicked3Time.minute,
                                                );
                                              });
                                            } else if (_model.datePicked3 !=
                                                null) {
                                              safeSetState(() {
                                                _model.datePicked3 =
                                                    FFAppState()
                                                        .nativeAiSchedule
                                                        .end;
                                              });
                                            }
                                            if (((DateTime? value) {
                                              return value != null;
                                            }(_model.datePicked3))!) {
                                              // Update the AI draft schedule
                                              await actions
                                                  .syncNativeAiSchedule(
                                                context,
                                                'end',
                                                _model.datePicked3,
                                                '',
                                                false,
                                              );
                                            }
                                          },
                                          child: Container(
                                            height: 34.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(9.0, 0.0, 9.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    (FFMainAxisAlignment.center)
                                                        .flutterValue,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment
                                                            .center)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Text(
                                                    'End ${dateTimeFormat("h:mm a", FFAppState().nativeAiSchedule.end)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
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
                                                  ),
                                                ].divide(SizedBox(width: 6.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                if (!FFAppState().nativeAiSchedule.editableDay)
                                  Text(
                                    FFAppState().nativeAiSchedule.scheduleLabel,
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
                                    final exceptionNote = FFAppState()
                                        .nativeAiSchedule
                                        .exceptions
                                        .toList();

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.start)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children:
                                          List.generate(exceptionNote.length,
                                              (exceptionNoteIndex) {
                                        final exceptionNoteItem =
                                            exceptionNote[exceptionNoteIndex];
                                        return Text(
                                          exceptionNoteItem,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodySmall
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
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
                                        );
                                      }),
                                    );
                                  },
                                ),
                                if (FFAppState().nativeAiSchedule.hasCalendar)
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
                                      TextFormField(
                                        controller: _model
                                            .aiDraftLocationTextController,
                                        focusNode:
                                            _model.aiDraftLocationFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.aiDraftLocationTextController',
                                          Duration(milliseconds: 2000),
                                          () async {
                                            logFirebaseEvent(
                                                'TEMPLATE_EDITOR_AiDraftLocation_ON_TEXTF');
                                            // Update the AI draft schedule
                                            await actions.syncNativeAiSchedule(
                                              context,
                                              'location',
                                              getCurrentTimestamp,
                                              _model
                                                  .aiDraftLocationTextController
                                                  .text,
                                              false,
                                            );
                                          },
                                        ),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Location',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.spaceGrotesk(
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
                                          hintText: 'Trailhead',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.spaceGrotesk(
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
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          prefixIcon: Icon(
                                            Icons.place_outlined,
                                          ),
                                        ),
                                        style: TextStyle(),
                                        cursorColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        validator: _model
                                            .aiDraftLocationTextControllerValidator
                                            .asValidator(context),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Theme(
                                          data: ThemeData(
                                            checkboxTheme: CheckboxThemeData(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            unselectedWidgetColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                          ),
                                          child: CheckboxListTile(
                                            value: _model
                                                    .aiAlsoSaveTemplateValue ??=
                                                FFAppState()
                                                    .nativeAiSchedule
                                                    .alsoSaveTemplate,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                      .aiAlsoSaveTemplateValue =
                                                  newValue!);
                                              if (newValue!) {
                                                logFirebaseEvent(
                                                    'TEMPLATE_EDITOR_AiAlsoSaveTemplate_ON_TO');
                                                // Update the AI draft schedule
                                                await actions
                                                    .syncNativeAiSchedule(
                                                  context,
                                                  'template',
                                                  getCurrentTimestamp,
                                                  '',
                                                  _model
                                                      .aiAlsoSaveTemplateValue,
                                                );
                                              } else {
                                                logFirebaseEvent(
                                                    'TEMPLATE_EDITOR_AiAlsoSaveTemplate_ON_TO');
                                                // Update the AI draft schedule
                                                await actions
                                                    .syncNativeAiSchedule(
                                                  context,
                                                  'template',
                                                  getCurrentTimestamp,
                                                  '',
                                                  _model
                                                      .aiAlsoSaveTemplateValue,
                                                );
                                              }
                                            },
                                            title: Text(
                                              'Also save as Template',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        font:
                                                            GoogleFonts.manrope(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleLarge
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                            ),
                                            tileColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            checkColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            dense: true,
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12.0, 0.0, 12.0, 0.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (FFAppState().nativeAiSchedule.sample)
                                  Text(
                                    'Sample draft',
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
                                if (!(_model.remainingAiItems.length == 0))
                                  Text(
                                    'Suggested extras',
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
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ),
                        Builder(
                          builder: (context) {
                            final remainingAiItem =
                                _model.remainingAiItems.toList();

                            return Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              runAlignment: WrapAlignment.start,
                              verticalDirection: VerticalDirection.down,
                              clipBehavior: Clip.none,
                              children: List.generate(remainingAiItem.length,
                                  (remainingAiItemIndex) {
                                final remainingAiItemItem =
                                    remainingAiItem[remainingAiItemIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'TEMPLATE_EDITOR_PAGE_Button_ON_TAP');
                                    _model.addToTItems(PackItemStruct(
                                      name: remainingAiItemItem.name,
                                      packed: false,
                                    ));
                                    safeSetState(() {});
                                    _model.removeAtIndexFromRemainingAiItems(
                                        remainingAiItemIndex);
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 8.0, 12.0, 8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            size: 16.0,
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(6.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                remainingAiItemItem.name,
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                              ),
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
                        ),
                      ].divide(SizedBox(height: 6.0)),
                    ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.stretch).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.spaceBetween).flutterValue,
                            children: [
                              Text(
                                'Items (tap one to change it)',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                '${_model.tItems.length.toString()} items',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final editItem = _model.tItems.toList();

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.stretch).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: List.generate(editItem.length,
                                      (editItemIndex) {
                                final editItemItem = editItem[editItemIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    logFirebaseEvent(
                                        'TEMPLATE_EDITOR_Container_7lv58jxx_ON_TA');
                                    safeSetState(() {
                                      _model.itemNameFieldTextController?.text =
                                          editItemItem.name;
                                    });
                                    safeSetState(() {
                                      _model.itemDetailFieldTextController
                                          ?.text = editItemItem.detail;
                                    });
                                    _model
                                        .removeAtIndexFromTItems(editItemIndex);
                                    safeSetState(() {});
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                        width: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? 1.0
                                            : 1.5,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 0.0, 0.0, 0.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    (FFCrossAxisAlignment.start)
                                                        .flutterValue,
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Text(
                                                    editItemItem.name,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    editItemItem.detail,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 11.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          FlutterFlowIconButton(
                                            borderRadius: 8.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              logFirebaseEvent(
                                                  'TEMPLATE_EDITOR_btn_RemoveItem_ON_TAP');
                                              _model.removeAtIndexFromTItems(
                                                  editItemIndex);
                                              safeSetState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                                  .divide(SizedBox(height: 8.0))
                                  .addToStart(SizedBox(height: 12.0)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.itemNameFieldTextController,
                        focusNode: _model.itemNameFieldFocusNode,
                        autofocus: false,
                        enabled: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
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
                          hintText: 'New item (e.g. Water bottle)',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.spaceGrotesk(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).linkGreen,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                        validator: _model.itemNameFieldTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: _model.itemDetailFieldTextController,
                        focusNode: _model.itemDetailFieldFocusNode,
                        autofocus: false,
                        enabled: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
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
                          hintText: 'Detail, optional (e.g. 1 liter, filled)',
                          hintStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.spaceGrotesk(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).linkGreen,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).error,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                        validator: _model.itemDetailFieldTextControllerValidator
                            .asValidator(context),
                      ),
                    ),
                  ),
                  FlutterFlowChoiceChips(
                    options: [
                      ChipData('Clothes'),
                      ChipData('Toiletries'),
                      ChipData('Electronics'),
                      ChipData('Misc')
                    ],
                    onChanged: (val) => safeSetState(() =>
                        _model.packingItemCategoryValue = val?.firstOrNull),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: FlutterFlowTheme.of(context).accent1,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                      iconColor: FlutterFlowTheme.of(context).primaryText,
                      iconSize: 16.0,
                      elevation: 0.0,
                      borderColor: FlutterFlowTheme.of(context).secondary,
                      borderWidth: 1.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
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
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      iconColor: FlutterFlowTheme.of(context).secondaryText,
                      iconSize: 16.0,
                      elevation: 0.0,
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderWidth: 1.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    chipSpacing: 8.0,
                    rowSpacing: 8.0,
                    multiselect: false,
                    initialized: _model.packingItemCategoryValue != null,
                    alignment: WrapAlignment.start,
                    controller: _model.packingItemCategoryValueController ??=
                        FormFieldController<List<String>>(
                      ['Misc'],
                    ),
                    wrapped: true,
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 24.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        logFirebaseEvent(
                            'TEMPLATE_EDITOR_PAGE_btn_AddItem_ON_TAP');
                        if (_model.itemNameFieldTextController.text != null &&
                            _model.itemNameFieldTextController.text != '') {
                          _model.addToTItems(PackItemStruct(
                            name: _model.itemNameFieldTextController.text,
                            detail: _model.itemDetailFieldTextController.text,
                            category: valueOrDefault<String>(
                              _model.packingItemCategoryValue,
                              'Misc',
                            ),
                          ));
                          safeSetState(() {});
                          safeSetState(() {
                            _model.itemDetailFieldTextController?.clear();
                            _model.itemNameFieldTextController?.clear();
                          });
                        } else {
                          // Show message: Type an item name first.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Type an item name first.',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).tertiary,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).accent2,
                            ),
                          );
                        }
                      },
                      text: '+ Add item',
                      options: FFButtonOptions(
                        height: 48.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              font: GoogleFonts.manrope(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  if (_model.hasAiDraft ?? true)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        FFButtonWidget(
                          onPressed: _model.aiGenerating!
                              ? null
                              : () async {
                                  logFirebaseEvent(
                                      'TEMPLATE_EDITOR_SaveAiDraftActivity_ON_T');
                                  // Save the AI checklist and schedule
                                  await actions.saveAiEditorDraft(
                                    context,
                                    _model.nameFieldTextController.text,
                                    _model.tItems.toList(),
                                    _model.itemNameFieldTextController.text,
                                    false,
                                  );
                                },
                          text: 'Create Activity',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 48.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: TextStyle(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        if (!(widget!.calendarActivityMode == true))
                          FFButtonWidget(
                            onPressed: _model.aiGenerating!
                                ? null
                                : () async {
                                    logFirebaseEvent(
                                        'TEMPLATE_EDITOR_SaveAiDraftChecklist_ON_');
                                    // Save the AI checklist and schedule
                                    await actions.saveAiEditorDraft(
                                      context,
                                      _model.nameFieldTextController.text,
                                      _model.tItems.toList(),
                                      _model.itemNameFieldTextController.text,
                                      true,
                                    );
                                  },
                            text: 'Save as Template',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 44.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.transparent,
                              textStyle: TextStyle(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  if (functions.showStandardChecklistSave(
                          widget!.calendarActivityMode, _model.hasAiDraft) ??
                      true)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 24.0),
                      child: FFButtonWidget(
                        onPressed: _model.aiGenerating!
                            ? null
                            : () async {
                                logFirebaseEvent(
                                    'TEMPLATE_EDITOR_SaveChecklist_ON_TAP');
                                if (_model.nameFieldTextController.text !=
                                        null &&
                                    _model.nameFieldTextController.text != '') {
                                  try {
                                    if (widget!.templateRef != null) {
                                      await widget!.templateRef!.update({
                                        ...createChecklistTemplatesRecordData(
                                          name: _model
                                              .nameFieldTextController.text,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'items':
                                                getPackItemListFirestoreData(
                                              _model.tItems,
                                            ),
                                            'updatedTime':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                    } else {
                                      await ChecklistTemplatesRecord.createDoc(
                                              currentUserReference!)
                                          .set({
                                        ...createChecklistTemplatesRecordData(
                                          name: _model
                                              .nameFieldTextController.text,
                                          activity: widget!.startActivity,
                                          starterName: widget!.startStarter,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'createdTime':
                                                FieldValue.serverTimestamp(),
                                            'updatedTime':
                                                FieldValue.serverTimestamp(),
                                            'items':
                                                getPackItemListFirestoreData(
                                              _model.tItems,
                                            ),
                                          },
                                        ),
                                      });
                                    }

                                    logFirebaseEvent('Created Checklist');
                                    // Open Home
                                    if (Navigator.of(context).canPop()) {
                                      context.pop();
                                    }
                                    context
                                        .pushNamed(MainscreenWidget.routeName);
                                  } catch (error_9d1re0vx, stackTrace_9d1re0vx) {
                                    // Show message: Couldn't save your checklist. Please check your connection and try again.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Couldn\'t save your checklist. Please check your connection and try again.',
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondary,
                                      ),
                                    );
                                  }
                                } else {
                                  // Show message: Name your checklist first.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Name your checklist first.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .tertiary,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context).accent2,
                                    ),
                                  );
                                }
                              },
                        text: 'Save checklist',
                        options: FFButtonOptions(
                          height: 48.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).onPrimary,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  if (widget!.templateRef != null)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 24.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          logFirebaseEvent(
                              'TEMPLATE_EDITOR_DeleteChecklist_ON_TAP');
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Delete this checklist?'),
                                    content: Text(
                                        'This removes it from your checklists. Your trips stay as they are.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            await widget!.templateRef!.delete();
                            logFirebaseEvent('Checklist Deleted');
                            // Open Home
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(MainscreenWidget.routeName);
                          }
                        },
                        text: 'Delete checklist',
                        options: FFButtonOptions(
                          height: 48.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                ].divide(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
