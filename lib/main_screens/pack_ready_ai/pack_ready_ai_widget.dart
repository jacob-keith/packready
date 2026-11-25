import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'pack_ready_ai_model.dart';
export 'pack_ready_ai_model.dart';

/// DSL page PackReadyAi
class PackReadyAiWidget extends StatefulWidget {
  const PackReadyAiWidget({
    super.key,
    bool? embedInTabShell,
  }) : this.embedInTabShell = embedInTabShell ?? false;

  /// Internal flag.
  ///
  /// Hides the standalone bar when the shell embeds this page.
  final bool embedInTabShell;

  static String routeName = 'PackReadyAi';
  static String routePath = '/ai';

  @override
  State<PackReadyAiWidget> createState() => _PackReadyAiWidgetState();
}

class _PackReadyAiWidgetState extends State<PackReadyAiWidget> {
  late PackReadyAiModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackReadyAiModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'PackReadyAi'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('PACK_READY_AI_PackReadyAi_ON_INIT_STATE');
      _model.aiLoadStatus = 'loading';
      _model.aiError = '';
      safeSetState(() {});
      // Load saved AI requests
      _model.aiLoaded = await actions.packReadyAiWorkspaceAction(
        context,
        'load',
        '',
      );
      _model.aiOwner = _model.aiLoaded?.ownerUid;
      _model.aiHistory =
          _model.aiLoaded!.turns.toList().cast<PackReadyAiHistoryCardStruct>();
      _model.aiError = _model.aiLoaded?.error;
      _model.aiLoadStatus = _model.aiLoaded!.hasHistory ? 'ready' : 'error';
      safeSetState(() {});
      if (_model.aiLoaded!.hasHistory
          ? !_model.aiLoaded!.tutorialSeen
          : false) {
        // Load saved AI requests
        _model.aiLoadedTutorial = await actions.packReadyAiWorkspaceAction(
          context,
          'firstTutorial',
          '',
        );
      }
    });

    _model.aiPromptTextController ??= TextEditingController();
    _model.aiPromptFocusNode ??= FocusNode();

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
                        height: 46.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border(
                            bottom: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              14.0, 0.0, 14.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.center).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Icon(
                                FFIcons.kautomationWave,
                                color: FlutterFlowTheme.of(context).packedGreen,
                                size: 17.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'PackReady AI',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                        lineHeight: 1.2,
                                      ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: (_model.aiLoadStatus == 'loading'
                                        ? true
                                        : (_model.aiBusy!
                                            ? true
                                            : !(FFAppState()
                                                    .packReadyAiVoicePhase ==
                                                'idle')))
                                    ? null
                                    : () async {
                                        logFirebaseEvent(
                                            'PACK_READY_AI_AiTutorialButton_ON_TAP');
                                        // Open the PackReady AI tutorial
                                        _model.aiManualTutorial = await actions
                                            .packReadyAiWorkspaceAction(
                                          context,
                                          'tutorial',
                                          '',
                                        );

                                        safeSetState(() {});
                                      },
                                text: 'Tutorial',
                                icon: Icon(
                                  Icons.help_outline,
                                  size: 14.0,
                                ),
                                options: FFButtonOptions(
                                  height: 22.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      9.0, 0.0, 9.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 6.0, 0.0),
                                  iconColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  color: Colors.transparent,
                                  textStyle: GoogleFonts.roboto(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.5,
                                  ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                showLoadingIndicator: false,
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          border: Border(
                            bottom: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              14.0, 12.0, 14.0, 12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.stretch).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              TextFormField(
                                controller: _model.aiPromptTextController,
                                focusNode: _model.aiPromptFocusNode,
                                readOnly: _model.aiLoadStatus == 'loading'
                                    ? true
                                    : (_model.aiBusy!
                                        ? true
                                        : !(FFAppState()
                                                .packReadyAiVoicePhase ==
                                            'idle')),
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText:
                                      'Ask PackReady AI to create, edit, or clean up lists…',
                                  hintStyle: GoogleFonts.roboto(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13.0,
                                    height: 1.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .packedGreen,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          12.0, 10.5, 12.0, 10.5),
                                ),
                                style: GoogleFonts.roboto(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13.5,
                                  height: 1.0,
                                ),
                                maxLines: 3,
                                minLines: 2,
                                keyboardType: TextInputType.multiline,
                                validator: _model
                                    .aiPromptTextControllerValidator
                                    .asValidator(context),
                              ),
                              Container(
                                height: 9.0,
                              ),
                              Row(
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
                                      FFAppState().packReadyAiVoicePhase ==
                                              'opening'
                                          ? 'Opening microphone…'
                                          : (FFAppState()
                                                      .packReadyAiVoicePhase ==
                                                  'recording'
                                              ? 'Recording · up to 3 min'
                                              : (FFAppState()
                                                          .packReadyAiVoicePhase ==
                                                      'transcribing'
                                                  ? 'Transcribing…'
                                                  : ((_model.aiBusy!
                                                          ? !(FFAppState()
                                                                  .packReadyAiProgress ==
                                                              '')
                                                          : false)
                                                      ? FFAppState()
                                                          .packReadyAiProgress
                                                      : 'One request at a time · undo any tile below'))),
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: ((isWeb ? true : isAndroid)
                                                    ? (FFAppState()
                                                            .packReadyAiVoicePhase ==
                                                        'recording')
                                                    : false)
                                                ? FlutterFlowTheme.of(context)
                                                    .error
                                                : FlutterFlowTheme.of(context)
                                                    .subtleText,
                                            fontSize: 11.5,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                            lineHeight: 1.2,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if ((isWeb ? true : isAndroid)
                                      ? (FFAppState().packReadyAiVoicePhase ==
                                          'idle')
                                      : false)
                                    FlutterFlowIconButton(
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        Icons.mic_none,
                                        color: FlutterFlowTheme.of(context)
                                            .packedGreen,
                                        size: 24.0,
                                      ),
                                      onPressed:
                                          (_model.aiLoadStatus == 'loading'
                                                  ? true
                                                  : _model.aiBusy!)
                                              ? null
                                              : () async {
                                                  logFirebaseEvent(
                                                      'PACK_READY_AI_AiRecordPromptButton_ON_TA');
                                                  _model.aiError = '';
                                                  safeSetState(() {});
                                                  // Record the spoken prompt
                                                  _model.aiHeard = await actions
                                                      .packReadyAiVoice(
                                                    context,
                                                    false,
                                                  );
                                                  if (!(_model.aiHeard
                                                          ?.transcript ==
                                                      '')) {
                                                    safeSetState(() {
                                                      _model.aiPromptTextController?.text =
                                                          functions.packReadyAiAppendTranscript(
                                                              _model
                                                                  .aiPromptTextController
                                                                  .text,
                                                              _model.aiHeard
                                                                  ?.transcript)!;
                                                    });
                                                  }
                                                  _model.aiError =
                                                      _model.aiHeard?.error;
                                                  safeSetState(() {});

                                                  safeSetState(() {});
                                                },
                                    ),
                                  if ((isWeb ? true : isAndroid)
                                      ? (FFAppState().packReadyAiVoicePhase ==
                                          'recording')
                                      : false)
                                    FlutterFlowIconButton(
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        Icons.stop_circle,
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        logFirebaseEvent(
                                            'PACK_READY_AI_AiStopRecordingButton_ON_T');
                                        // Stop recording and transcribe the prompt
                                        _model.packReadyAiVoiceResult =
                                            await actions.packReadyAiVoice(
                                          context,
                                          true,
                                        );

                                        safeSetState(() {});
                                      },
                                    ),
                                  if ((isWeb ? true : isAndroid)
                                      ? (FFAppState().packReadyAiVoicePhase ==
                                              'opening'
                                          ? true
                                          : (FFAppState()
                                                  .packReadyAiVoicePhase ==
                                              'transcribing'))
                                      : false)
                                    Container(
                                      width: 40.0,
                                      height: 40.0,
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: CircularPercentIndicator(
                                        percent: 0.0,
                                        radius: 9.0,
                                        lineWidth: 2.0,
                                        animation: false,
                                        animateFromLastPercent: true,
                                      ),
                                    ),
                                  FFButtonWidget(
                                    onPressed: (_model.aiLoadStatus == 'loading'
                                            ? true
                                            : (_model.aiBusy!
                                                ? true
                                                : !(FFAppState()
                                                        .packReadyAiVoicePhase ==
                                                    'idle')))
                                        ? null
                                        : () async {
                                            logFirebaseEvent(
                                                'PACK_READY_AI_PAGE_AiRunButton_ON_TAP');
                                            _model.aiBusy = true;
                                            _model.aiError = '';
                                            safeSetState(() {});
                                            // Prepare AI plan, await confirmation, and save the result
                                            _model.aiRan = await actions
                                                .packReadyAiWorkspaceAction(
                                              context,
                                              'run',
                                              _model
                                                  .aiPromptTextController.text,
                                            );
                                            if (_model.aiRan!.clearPrompt
                                                ? (_model.aiRan?.ownerUid ==
                                                    currentUserUid)
                                                : false) {
                                              _model.aiOwner =
                                                  _model.aiRan?.ownerUid;
                                              safeSetState(() {});
                                              _model.aiLoadStatus = 'ready';
                                              safeSetState(() {});
                                              _model.insertAtIndexInAiHistory(
                                                  0, _model.aiRan!.latestTurn);
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.aiPromptTextController
                                                    ?.clear();
                                              });
                                            }
                                            _model.aiError =
                                                _model.aiRan?.error;
                                            _model.aiBusy = false;
                                            safeSetState(() {});

                                            safeSetState(() {});
                                          },
                                    text: 'Run',
                                    options: FFButtonOptions(
                                      width: 74.0,
                                      height: 36.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: GoogleFonts.roboto(
                                        color: FlutterFlowTheme.of(context)
                                            .onPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0,
                                      ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    showLoadingIndicator: false,
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                              if (_model.aiBusy!
                                  ? !(FFAppState().packReadyAiProgress == '')
                                  : false)
                                LinearPercentIndicator(
                                  percent: 0.0,
                                  lineHeight: 2.5,
                                  animation: false,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).packedGreen,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  barRadius: Radius.circular(1.25),
                                  padding: EdgeInsets.zero,
                                ),
                              if (!(_model.aiError == '')
                                  ? (loggedIn
                                      ? !(_model.aiLoadStatus == 'error')
                                      : false)
                                  : false)
                                Text(
                                  _model.aiError!,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .pendingYellow,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.2,
                                      ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                              (FFMainAxisAlignment.start).flutterValue,
                          crossAxisAlignment:
                              (FFCrossAxisAlignment.center).flutterValue,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            if (loggedIn
                                ? (_model.aiLoadStatus == 'loading')
                                : false)
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: CircularPercentIndicator(
                                      percent: 0.0,
                                      radius: 12.0,
                                      lineWidth: 2.0,
                                      animation: false,
                                      animateFromLastPercent: true,
                                      progressColor:
                                          FlutterFlowTheme.of(context)
                                              .packedGreen,
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                    ),
                                  ),
                                ),
                              ),
                            if (!loggedIn)
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.center)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreen,
                                          size: 30.0,
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Sign in to use PackReady AI',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.2,
                                              ),
                                        ),
                                        Container(
                                          height: 4.0,
                                        ),
                                        Text(
                                          'Your past requests appear here after you sign in.',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.5,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (loggedIn
                                ? (_model.aiLoadStatus == 'error')
                                : false)
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.center)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Icon(
                                          Icons.sync_problem_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreen,
                                          size: 30.0,
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Could not load AI history',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.2,
                                              ),
                                        ),
                                        Container(
                                          height: 4.0,
                                        ),
                                        Text(
                                          'Check your connection and try again.',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.5,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            logFirebaseEvent(
                                                'PACK_READY_AI_RetryLoadingAiHistory_ON_T');
                                            _model.aiLoadStatus = 'loading';
                                            _model.aiError = '';
                                            safeSetState(() {});
                                            // Load saved AI requests
                                            _model.aiRetried = await actions
                                                .packReadyAiWorkspaceAction(
                                              context,
                                              'load',
                                              '',
                                            );
                                            _model.aiOwner =
                                                _model.aiRetried?.ownerUid;
                                            _model.aiHistory = _model
                                                .aiRetried!.turns
                                                .toList()
                                                .cast<
                                                    PackReadyAiHistoryCardStruct>();
                                            _model.aiError =
                                                _model.aiRetried?.error;
                                            _model.aiLoadStatus =
                                                _model.aiRetried!.hasHistory
                                                    ? 'ready'
                                                    : 'error';
                                            safeSetState(() {});
                                            if (_model.aiRetried!.hasHistory
                                                ? !_model
                                                    .aiRetried!.tutorialSeen
                                                : false) {
                                              // Load saved AI requests
                                              _model.aiRetriedTutorial =
                                                  await actions
                                                      .packReadyAiWorkspaceAction(
                                                context,
                                                'firstTutorial',
                                                '',
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Retry',
                                          options: FFButtonOptions(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if ((!(_model.aiOwner == '')
                                    ? (_model.aiOwner == currentUserUid)
                                    : false)
                                ? (_model.aiLoadStatus == 'ready'
                                    ? !!(_model.aiHistory.length == 0)
                                    : false)
                                : false)
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.center)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.center)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Icon(
                                          Icons.timeline,
                                          color: FlutterFlowTheme.of(context)
                                              .packedGreen,
                                          size: 30.0,
                                        ),
                                        Container(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'No AI requests yet',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.2,
                                              ),
                                        ),
                                        Container(
                                          height: 4.0,
                                        ),
                                        Text(
                                          'Send a single request above. Each completed request appears here with its own surgical Undo.',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.5,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if ((!(_model.aiOwner == '')
                                    ? (_model.aiOwner == currentUserUid)
                                    : false)
                                ? !(_model.aiHistory.length == 0)
                                : false)
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14.0, 12.0, 14.0, 18.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        (FFMainAxisAlignment.start)
                                            .flutterValue,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.stretch)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'RECENT REQUESTS',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.roboto(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .subtleText,
                                              fontSize: 10.0,
                                              letterSpacing: 1.1,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                              lineHeight: 1.2,
                                            ),
                                      ),
                                      Container(
                                        height: 8.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Builder(
                                          builder: (context) {
                                            final aiHistoryItem =
                                                _model.aiHistory.toList();

                                            return ListView.separated(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              scrollDirection: Axis.vertical,
                                              itemCount: aiHistoryItem.length,
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 10.0),
                                              itemBuilder: (context,
                                                  aiHistoryItemIndex) {
                                                final aiHistoryItemItem =
                                                    aiHistoryItem[
                                                        aiHistoryItemIndex];
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13.0),
                                                    border: Border.all(
                                                      color: aiHistoryItemItem
                                                              .undone
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .selectedSurface
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(13.0),
                                                    child: Column(
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
                                                      textBaseline: TextBaseline
                                                          .alphabetic,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
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
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                aiHistoryItemItem
                                                                    .prompt,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .roboto(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: aiHistoryItemItem.undone
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .secondaryText
                                                                          : FlutterFlowTheme.of(context)
                                                                              .primaryText,
                                                                      fontSize:
                                                                          13.5,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                      lineHeight:
                                                                          1.3,
                                                                    ),
                                                              ),
                                                            ),
                                                            Text(
                                                              aiHistoryItemItem
                                                                  .timeLabel,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .roboto(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtleText,
                                                                    fontSize:
                                                                        10.5,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                    lineHeight:
                                                                        1.2,
                                                                  ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        ),
                                                        Container(
                                                          height: 6.0,
                                                        ),
                                                        Text(
                                                          aiHistoryItemItem
                                                              .summary,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: aiHistoryItemItem
                                                                        .undone
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtleText
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                                lineHeight:
                                                                    1.35,
                                                              ),
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            final resultLine =
                                                                aiHistoryItemItem
                                                                    .lines
                                                                    .toList();

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  (FFMainAxisAlignment
                                                                          .start)
                                                                      .flutterValue,
                                                              crossAxisAlignment:
                                                                  (FFCrossAxisAlignment
                                                                          .stretch)
                                                                      .flutterValue,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: List.generate(
                                                                  resultLine
                                                                      .length,
                                                                  (resultLineIndex) {
                                                                final resultLineItem =
                                                                    resultLine[
                                                                        resultLineIndex];
                                                                return Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        (FFMainAxisAlignment.start)
                                                                            .flutterValue,
                                                                    crossAxisAlignment:
                                                                        (FFCrossAxisAlignment.start)
                                                                            .flutterValue,
                                                                    textBaseline:
                                                                        TextBaseline
                                                                            .alphabetic,
                                                                    children: [
                                                                      if (resultLineItem
                                                                              .kind ==
                                                                          'delete')
                                                                        Icon(
                                                                          Icons
                                                                              .delete_outline,
                                                                          color: aiHistoryItemItem.undone
                                                                              ? FlutterFlowTheme.of(context).subtleText
                                                                              : FlutterFlowTheme.of(context).error,
                                                                          size:
                                                                              14.0,
                                                                        ),
                                                                      if (resultLineItem
                                                                              .kind ==
                                                                          'edit')
                                                                        Icon(
                                                                          Icons
                                                                              .edit_outlined,
                                                                          color: aiHistoryItemItem.undone
                                                                              ? FlutterFlowTheme.of(context).subtleText
                                                                              : FlutterFlowTheme.of(context).packedGreen,
                                                                          size:
                                                                              14.0,
                                                                        ),
                                                                      if (resultLineItem
                                                                              .kind ==
                                                                          'create')
                                                                        Icon(
                                                                          Icons
                                                                              .check_circle_outline,
                                                                          color: aiHistoryItemItem.undone
                                                                              ? FlutterFlowTheme.of(context).subtleText
                                                                              : FlutterFlowTheme.of(context).packedGreen,
                                                                          size:
                                                                              14.0,
                                                                        ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Text(
                                                                          resultLineItem
                                                                              .text,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.roboto(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: aiHistoryItemItem.undone ? FlutterFlowTheme.of(context).subtleText : FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                lineHeight: 1.2,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            6.0)),
                                                                  ),
                                                                );
                                                              }),
                                                            );
                                                          },
                                                        ),
                                                        Container(
                                                          height: 10.0,
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
                                                          textBaseline:
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            FFButtonWidget(
                                                              onPressed: (_model
                                                                              .aiLoadStatus ==
                                                                          'loading'
                                                                      ? true
                                                                      : (_model
                                                                              .aiBusy!
                                                                          ? true
                                                                          : !(FFAppState().packReadyAiVoicePhase ==
                                                                              'idle')))
                                                                  ? null
                                                                  : () async {
                                                                      logFirebaseEvent(
                                                                          'PACK_READY_AI_PAGE_AiReusePrompt_ON_TAP');
                                                                      safeSetState(
                                                                          () {
                                                                        _model
                                                                            .aiPromptTextController
                                                                            ?.text = aiHistoryItemItem.prompt;
                                                                      });
                                                                    },
                                                              text:
                                                                  'Use prompt',
                                                              icon: Icon(
                                                                Icons.replay,
                                                                size: 14.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 24.0,
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            8.0,
                                                                            0.0,
                                                                            8.0,
                                                                            0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            6.0,
                                                                            0.0),
                                                                iconColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                color: Colors
                                                                    .transparent,
                                                                textStyle:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      11.5,
                                                                ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              showLoadingIndicator:
                                                                  false,
                                                            ),
                                                            Spacer(),
                                                            if (aiHistoryItemItem
                                                                .undone)
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          9.0,
                                                                          4.0,
                                                                          9.0,
                                                                          4.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        (FFMainAxisAlignment.start)
                                                                            .flutterValue,
                                                                    crossAxisAlignment:
                                                                        (FFCrossAxisAlignment.center)
                                                                            .flutterValue,
                                                                    textBaseline:
                                                                        TextBaseline
                                                                            .alphabetic,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .history,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .subtleText,
                                                                        size:
                                                                            13.0,
                                                                      ),
                                                                      Text(
                                                                        'Undone',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.roboto(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).subtleText,
                                                                              fontSize: 11.5,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              lineHeight: 1.2,
                                                                            ),
                                                                      ),
                                                                    ].divide(SizedBox(
                                                                        width:
                                                                            4.0)),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (aiHistoryItemItem
                                                                .undoable)
                                                              FFButtonWidget(
                                                                onPressed: (_model.aiLoadStatus ==
                                                                            'loading'
                                                                        ? true
                                                                        : (_model.aiBusy!
                                                                            ? true
                                                                            : !(FFAppState().packReadyAiVoicePhase ==
                                                                                'idle')))
                                                                    ? null
                                                                    : () async {
                                                                        logFirebaseEvent(
                                                                            'PACK_READY_AI_PAGE_AiUndoButton_ON_TAP');
                                                                        _model.aiBusy =
                                                                            true;
                                                                        _model.aiUndoId =
                                                                            aiHistoryItemItem.turnId;
                                                                        _model.aiError =
                                                                            '';
                                                                        safeSetState(
                                                                            () {});
                                                                        // Undo this AI turn after checking for conflicting changes
                                                                        _model.aiUndone =
                                                                            await actions.packReadyAiWorkspaceAction(
                                                                          context,
                                                                          'undo',
                                                                          aiHistoryItemItem
                                                                              .turnId,
                                                                        );
                                                                        if (_model.aiUndone!.hasHistory
                                                                            ? (_model.aiUndone?.ownerUid ==
                                                                                currentUserUid)
                                                                            : false) {
                                                                          _model.aiHistory = _model
                                                                              .aiUndone!
                                                                              .turns
                                                                              .toList()
                                                                              .cast<PackReadyAiHistoryCardStruct>();
                                                                          safeSetState(
                                                                              () {});
                                                                        }
                                                                        _model.aiBusy =
                                                                            false;
                                                                        _model.aiUndoId =
                                                                            '';
                                                                        _model.aiError = _model
                                                                            .aiUndone
                                                                            ?.error;
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                text: _model.aiUndoId ==
                                                                        aiHistoryItemItem
                                                                            .turnId
                                                                    ? 'Undoing…'
                                                                    : 'Undo',
                                                                icon: Icon(
                                                                  Icons.undo,
                                                                  size: 14.0,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 24.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          6.0,
                                                                          0.0),
                                                                  iconColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .pendingYellow,
                                                                  color: Colors
                                                                      .transparent,
                                                                  textStyle:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .pendingYellow,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .pendingYellow,
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              9.0),
                                                                ),
                                                                showLoadingIndicator:
                                                                    false,
                                                              ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
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
                ),
              ),
              if (!widget!.embedInTabShell)
                wrapWithModel(
                  model: _model.packReadyTabBarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PackReadyTabBarWidget(
                    activeTab: 'AI',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
