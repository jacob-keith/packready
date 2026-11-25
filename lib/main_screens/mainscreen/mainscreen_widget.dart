import '/auth/firebase_auth/auth_util.dart';
import '/backend/schema/structs/index.dart';
import '/components/home_checklist_selection_widget.dart';
import '/components/home_week_selection_widget.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/components/trips_&_weather/pack_header/pack_header_widget.dart';
import '/components/trips_&_weather/ratingmetric/ratingmetric_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_styled_border.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/app_events/index.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'mainscreen_model.dart';
export 'mainscreen_model.dart';

class MainscreenWidget extends StatefulWidget {
  const MainscreenWidget({
    super.key,
    double? tabSlideOffset,
    this.tabHandoff,
    bool? embedHome,
  })  : this.tabSlideOffset = tabSlideOffset ?? 0.0,
        this.embedHome = embedHome ?? false;

  final double tabSlideOffset;
  final String? tabHandoff;

  /// Internal flag: true when rendering Home inside the persistent 6-tab shell.
  final bool embedHome;

  static String routeName = 'mainscreen';
  static String routePath = '/mainscreen';

  @override
  State<MainscreenWidget> createState() => _MainscreenWidgetState();
}

class _MainscreenWidgetState extends State<MainscreenWidget> {
  late MainscreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MainscreenModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'mainscreen'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('MAINSCREEN_PAGE_mainscreen_ON_INIT_STATE');
      // Watch trip and packing updates
      await actions.watchHomeTimeline(
        context,
        widget!.embedHome,
      );
      if (!widget!.embedHome) {
        if ((valueOrDefault(currentUserDocument?.logincount, 0) == 5) &&
            (valueOrDefault<bool>(currentUserDocument?.rated, false) ==
                false)) {
          // Show the rating prompt
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: RatingmetricWidget(),
                ),
              );
            },
          ).then((value) => safeSetState(() {}));
        }
      }
    });

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
                child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (!widget!.embedHome)
                          custom_widgets.PackReadyTabBackdrop(
                            handoff: widget!.tabHandoff,
                            offset: widget!.tabSlideOffset,
                            shellMode: true,
                            requestedTab: FFAppState().packReadyShellActiveTab,
                          ),
                        if (widget!.embedHome)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            child: Stack(
                              children: [
                                if (Theme.of(context).brightness ==
                                    Brightness.dark)
                                  Container(
                                    width: double.infinity,
                                    height: 220.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          Color(0xFF161614),
                                          Color(0xFF131513),
                                          Color(0x00121512)
                                        ],
                                        stops: [0.0, 0.12, 0.45, 1.0],
                                        begin: AlignmentDirectional(0.0, -1.0),
                                        end: AlignmentDirectional(0, 1.0),
                                      ),
                                    ),
                                  ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          (FFMainAxisAlignment.start)
                                              .flutterValue,
                                      crossAxisAlignment:
                                          (FFCrossAxisAlignment.stretch)
                                              .flutterValue,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        if (!(Theme.of(context).brightness ==
                                            Brightness.dark))
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  (FFMainAxisAlignment.start)
                                                      .flutterValue,
                                              crossAxisAlignment:
                                                  (FFCrossAxisAlignment.stretch)
                                                      .flutterValue,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          18.0, 5.0, 10.0, 9.0),
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
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'MAINSCREEN_PAGE_HomeProfileButton_ON_TAP');
                                                              // Open Profile

                                                              context.pushNamed(
                                                                ProfileWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'tabHandoff':
                                                                      serializeParam(
                                                                    '',
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                  'tabSlideOffset':
                                                                      serializeParam(
                                                                    0.0,
                                                                    ParamType
                                                                        .double,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            text: 'Profile',
                                                            options:
                                                                FFButtonOptions(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              iconPadding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              textStyle:
                                                                  TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                          ),
                                                          FlutterFlowIconButton(
                                                            buttonSize: 48.0,
                                                            icon: Icon(
                                                              Icons.settings,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 21.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              logFirebaseEvent(
                                                                  'MAINSCREEN_LightMastheadSettings_ON_TAP');
                                                              // Open Settings

                                                              context.pushNamed(
                                                                  SettingsWidget
                                                                      .routeName);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            Text(
                                                          currentUserDisplayName !=
                                                                      null &&
                                                                  currentUserDisplayName !=
                                                                      ''
                                                              ? currentUserDisplayName
                                                              : 'Welcome back',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineSmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .manrope(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 31.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 3.0)),
                                                  ),
                                                ),
                                                Container(
                                                  height: 3.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (Theme.of(context).brightness ==
                                            Brightness.dark)
                                          wrapWithModel(
                                            model: _model
                                                .darkModeProfileHeaderModel,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: PackHeaderWidget(),
                                          ),
                                        Container(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 6.0, 16.0, 6.0),
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
                                                Expanded(
                                                  flex: 1,
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'MAINSCREEN_HomeActivitiesLink_ON_TAP');
                                                      // Open Activities

                                                      context.pushNamed(
                                                          MyActivitiesWidget
                                                              .routeName);
                                                    },
                                                    text: 'Activities',
                                                    options: FFButtonOptions(
                                                      height: 44.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: Colors.transparent,
                                                      textStyle: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .linkGreen,
                                                      ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'MAINSCREEN_PAGE_HomeHistoryLink_ON_TAP');
                                                      // Open History

                                                      context.pushNamed(
                                                          HistoryPageWidget
                                                              .routeName);
                                                    },
                                                    text: 'History',
                                                    options: FFButtonOptions(
                                                      height: 44.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: Colors.transparent,
                                                      textStyle: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .linkGreen,
                                                      ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      logFirebaseEvent(
                                                          'MAINSCREEN_PAGE_HomeTemplatesLink_ON_TAP');
                                                      // Open Templates

                                                      context.pushNamed(
                                                          TemplatesWidget
                                                              .routeName);
                                                    },
                                                    text: 'Templates',
                                                    options: FFButtonOptions(
                                                      height: 44.0,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: Colors.transparent,
                                                      textStyle: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .linkGreen,
                                                      ),
                                                      elevation: 0.0,
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 10.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Container(
                                            width: 100.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  (FFCrossAxisAlignment.start)
                                                      .flutterValue,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                if (!(Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark))
                                                  Text(
                                                    'Trip timeline',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .manrope(
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
                                                          fontSize: 20.0,
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
                                                if (Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark)
                                                  Text(
                                                    'Trip timeline',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                Text(
                                                  'Swipe through trips. Check off items below.',
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
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
                                                if (!(Theme.of(context)
                                                        .brightness ==
                                                    Brightness.dark))
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 7.0),
                                                    child: Container(
                                                      height: 1.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtleDivider,
                                                      ),
                                                    ),
                                                  ),
                                                Column(
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
                                                    if (FFAppState()
                                                            .homeTimelineStatus ==
                                                        'loading')
                                                      Container(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  24.0),
                                                          child:
                                                              CircularPercentIndicator(
                                                            percent: 0.25,
                                                            radius: 12.0,
                                                            lineWidth: 2.0,
                                                            animation: true,
                                                            animateFromLastPercent:
                                                                true,
                                                            progressColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                      ),
                                                    if (FFAppState()
                                                            .homeTimelineStatus ==
                                                        'error')
                                                      Container(
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
                                                              TextBaseline
                                                                  .alphabetic,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                'Couldn’t load activities',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                logFirebaseEvent(
                                                                    'MAINSCREEN_PAGE_HomeTimelineRetry_ON_TAP');
                                                                // Retry loading trips
                                                                await actions
                                                                    .watchHomeTimeline(
                                                                  context,
                                                                  true,
                                                                );
                                                              },
                                                              text: 'Retry',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 40.0,
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: Colors
                                                                    .transparent,
                                                                textStyle:
                                                                    TextStyle(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .linkGreen,
                                                                ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 8.0)),
                                                        ),
                                                      ),
                                                    if (FFAppState()
                                                                .homeTimelineStatus ==
                                                            'ready'
                                                        ? !!(FFAppState()
                                                                .homeTimelineTrips
                                                                .length ==
                                                            0)
                                                        : false)
                                                      InkWell(
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
                                                              'MAINSCREEN_PAGE_HomeTimelineEmpty_ON_TAP');
                                                          // Open Activities to create a packing list

                                                          context.pushNamed(
                                                            ActivitiesWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'tabSlideOffset':
                                                                  serializeParam(
                                                                0.0,
                                                                ParamType
                                                                    .double,
                                                              ),
                                                              'tabHandoff':
                                                                  serializeParam(
                                                                '',
                                                                ParamType
                                                                    .String,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 172.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                (FFMainAxisAlignment
                                                                        .center)
                                                                    .flutterValue,
                                                            crossAxisAlignment:
                                                                (FFCrossAxisAlignment
                                                                        .center)
                                                                    .flutterValue,
                                                            textBaseline:
                                                                TextBaseline
                                                                    .alphabetic,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .add_circle_outline,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .linkGreen,
                                                                size: 30.0,
                                                              ),
                                                              Text(
                                                                'Create your first packing list',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .manrope(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 9.0)),
                                                          ),
                                                        ),
                                                      ),
                                                    if (FFAppState()
                                                                .homeTimelineStatus ==
                                                            'ready'
                                                        ? !(FFAppState()
                                                                .homeTimelineTrips
                                                                .length ==
                                                            0)
                                                        : false)
                                                      Column(
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
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          wrapWithModel(
                                                            model: _model
                                                                .homeWeekSelectionModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                HomeWeekSelectionWidget(
                                                              openTrip:
                                                                  (tripIndex) async {
                                                                logFirebaseEvent(
                                                                    'MAINSCREEN_HomeWeekSelection_CALLBACK');
                                                                await actions
                                                                    .selectHomeTrip(
                                                                  context,
                                                                  tripIndex,
                                                                );
                                                                FFAppEventService
                                                                    .instance
                                                                    .triggerAppEvent(
                                                                  HomeTripSelectedEvent(
                                                                    data:
                                                                        HomeTripSelectionStruct(
                                                                      tripIndex:
                                                                          tripIndex,
                                                                    ),
                                                                    timestamp:
                                                                        DateTime
                                                                            .now(),
                                                                    debugId: '',
                                                                  ),
                                                                );

                                                                await _model
                                                                    .homeTripCarouselController
                                                                    ?.animateToPage(
                                                                  tripIndex,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  curve: Curves
                                                                      .ease,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 10.0,
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: 214.0,
                                                            child: ListView(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              reverse: true,
                                                              primary: false,
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      1.2,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            38.4,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final trip = FFAppState()
                                                                            .homeTimelineTrips
                                                                            .toList();

                                                                        return Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              214.0,
                                                                          child:
                                                                              CarouselSlider.builder(
                                                                            key:
                                                                                ValueKey(FFAppState().homeCarouselAnchor),
                                                                            itemCount:
                                                                                trip.length,
                                                                            itemBuilder: (context,
                                                                                tripIndex,
                                                                                _) {
                                                                              final tripItem = trip[tripIndex];
                                                                              return Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                                                                                textBaseline: TextBaseline.alphabetic,
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(12.0),
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                          borderRadius: BorderRadius.circular(12.0),
                                                                                          border: Border.all(
                                                                                            color: FlutterFlowTheme.of(context).alternate,
                                                                                            width: 1.0,
                                                                                          ),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(12.0, 11.0, 14.0, 12.0),
                                                                                          child: Column(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                            crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                                                                                            textBaseline: TextBaseline.alphabetic,
                                                                                            children: [
                                                                                              if (tripItem.newDay ? tripItem.dayLocalOnly : false)
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 6.0),
                                                                                                  child: Container(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: () {
                                                                                                          if (tripItem.dayStatus == 'packed') {
                                                                                                            return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                                          } else if (tripItem.dayStatus == 'incomplete') {
                                                                                                            return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                          } else if (tripItem.dayStatus == 'unpacked') {
                                                                                                            return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                                          } else if (tripItem.dayStatus == 'event') {
                                                                                                            return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                                          } else {
                                                                                                            return Colors.transparent;
                                                                                                          }
                                                                                                        }(),
                                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                                        border: FlutterFlowStyledBorder(
                                                                                                          side: BorderSide(
                                                                                                            color: () {
                                                                                                              if (tripItem.dayStatus == 'packed') {
                                                                                                                return FlutterFlowTheme.of(context).packedGreen;
                                                                                                              } else if (tripItem.dayStatus == 'incomplete') {
                                                                                                                return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                              } else if (tripItem.dayStatus == 'unpacked') {
                                                                                                                return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                              } else if (tripItem.dayStatus == 'event') {
                                                                                                                return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                              } else {
                                                                                                                return FlutterFlowTheme.of(context).secondary;
                                                                                                              }
                                                                                                            }(),
                                                                                                            width: 1.15,
                                                                                                          ),
                                                                                                          style: FlutterFlowDashStyle.dashed,
                                                                                                          dashLength: 3.2,
                                                                                                          dashGap: 2.2,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(6.0, 2.5, 6.0, 2.5),
                                                                                                        child: Text(
                                                                                                          tripItem.dayLabel,
                                                                                                          maxLines: 1,
                                                                                                          style: GoogleFonts.robotoMono(
                                                                                                            color: () {
                                                                                                              if (tripItem.dayStatus == 'packed') {
                                                                                                                return FlutterFlowTheme.of(context).packedGreen;
                                                                                                              } else if (tripItem.dayStatus == 'incomplete') {
                                                                                                                return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                              } else if (tripItem.dayStatus == 'unpacked') {
                                                                                                                return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                              } else if (tripItem.dayStatus == 'event') {
                                                                                                                return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                              } else {
                                                                                                                return Colors.transparent;
                                                                                                              }
                                                                                                            }(),
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            fontSize: 10.0,
                                                                                                            height: 1.15,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              if (tripItem.newDay ? !tripItem.dayLocalOnly : false)
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 6.0),
                                                                                                  child: Container(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: () {
                                                                                                          if (tripItem.dayStatus == 'packed') {
                                                                                                            return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                                          } else if (tripItem.dayStatus == 'incomplete') {
                                                                                                            return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                                          } else if (tripItem.dayStatus == 'unpacked') {
                                                                                                            return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                                          } else if (tripItem.dayStatus == 'event') {
                                                                                                            return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                                          } else {
                                                                                                            return Colors.transparent;
                                                                                                          }
                                                                                                        }(),
                                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                                        border: Border.all(
                                                                                                          color: () {
                                                                                                            if (tripItem.dayStatus == 'packed') {
                                                                                                              return FlutterFlowTheme.of(context).packedGreen;
                                                                                                            } else if (tripItem.dayStatus == 'incomplete') {
                                                                                                              return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                            } else if (tripItem.dayStatus == 'unpacked') {
                                                                                                              return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                            } else if (tripItem.dayStatus == 'event') {
                                                                                                              return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                            } else {
                                                                                                              return FlutterFlowTheme.of(context).secondary;
                                                                                                            }
                                                                                                          }(),
                                                                                                          width: 1.1,
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Padding(
                                                                                                        padding: EdgeInsetsDirectional.fromSTEB(6.0, 2.5, 6.0, 2.5),
                                                                                                        child: Text(
                                                                                                          tripItem.dayLabel,
                                                                                                          maxLines: 1,
                                                                                                          style: GoogleFonts.robotoMono(
                                                                                                            color: () {
                                                                                                              if (tripItem.dayStatus == 'packed') {
                                                                                                                return FlutterFlowTheme.of(context).packedGreen;
                                                                                                              } else if (tripItem.dayStatus == 'incomplete') {
                                                                                                                return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                              } else if (tripItem.dayStatus == 'unpacked') {
                                                                                                                return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                              } else if (tripItem.dayStatus == 'event') {
                                                                                                                return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                              } else {
                                                                                                                return Colors.transparent;
                                                                                                              }
                                                                                                            }(),
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                            fontSize: 10.0,
                                                                                                            height: 1.15,
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
                                                                                                  logFirebaseEvent('MAINSCREEN_TripTitleandOpenArrow_ON_TAP');
                                                                                                  // Open this trip checklist

                                                                                                  context.pushNamed(
                                                                                                    PackingListWidget.routeName,
                                                                                                    queryParameters: {
                                                                                                      'listRef': serializeParam(
                                                                                                        tripItem.listRef,
                                                                                                        ParamType.DocumentReference,
                                                                                                      ),
                                                                                                    }.withoutNulls,
                                                                                                  );
                                                                                                },
                                                                                                child: Row(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                                  crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
                                                                                                  textBaseline: TextBaseline.alphabetic,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      flex: 1,
                                                                                                      child: Text(
                                                                                                        tripItem.title,
                                                                                                        maxLines: 2,
                                                                                                        style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                              font: GoogleFonts.manrope(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              ),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                              lineHeight: 1.25,
                                                                                                            ),
                                                                                                        overflow: TextOverflow.ellipsis,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Icon(
                                                                                                      Icons.chevron_right,
                                                                                                      color: FlutterFlowTheme.of(context).linkGreen,
                                                                                                      size: 24.0,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              if (!(tripItem.subtitle == ''))
                                                                                                Text(
                                                                                                  tripItem.subtitle,
                                                                                                  maxLines: 1,
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.inter(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                ),
                                                                                              Container(
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    tripItem.dateLabel,
                                                                                                    maxLines: 1,
                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                          font: GoogleFonts.inter(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                        ),
                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Container(
                                                                                                  width: double.infinity,
                                                                                                  child: Visibility(
                                                                                                    visible: !(tripItem.forecast.temperature == ''),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                                      crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                                                                                                      textBaseline: TextBaseline.alphabetic,
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          flex: 3,
                                                                                                          child: Container(
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 8.0, 0.0),
                                                                                                              child: Column(
                                                                                                                mainAxisSize: MainAxisSize.min,
                                                                                                                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                                                                                                                crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
                                                                                                                textBaseline: TextBaseline.alphabetic,
                                                                                                                children: [
                                                                                                                  Text(
                                                                                                                    tripItem.forecast.temperature,
                                                                                                                    maxLines: 1,
                                                                                                                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                                                                                                                          font: GoogleFonts.manrope(
                                                                                                                            fontWeight: FontWeight.bold,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                                                          ),
                                                                                                                          fontSize: 20.0,
                                                                                                                          letterSpacing: -0.4,
                                                                                                                          fontWeight: FontWeight.bold,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                                                                                                                          lineHeight: 1.05,
                                                                                                                        ),
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    tripItem.forecast.condition,
                                                                                                                    maxLines: 1,
                                                                                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                                          font: GoogleFonts.inter(
                                                                                                                            fontWeight: FontWeight.w600,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                                          fontSize: 11.5,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.w600,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                                          lineHeight: 1.15,
                                                                                                                        ),
                                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                                  ),
                                                                                                                  Text(
                                                                                                                    tripItem.forecast.location,
                                                                                                                    maxLines: 1,
                                                                                                                    style: FlutterFlowTheme.of(context).labelSmall.override(
                                                                                                                          font: GoogleFonts.spaceGrotesk(
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                                          ),
                                                                                                                          color: FlutterFlowTheme.of(context).subtleText,
                                                                                                                          fontSize: 9.5,
                                                                                                                          letterSpacing: 0.0,
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                                                          lineHeight: 1.15,
                                                                                                                        ),
                                                                                                                    overflow: TextOverflow.ellipsis,
                                                                                                                  ),
                                                                                                                ].divide(SizedBox(height: 1.0)),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          height: double.infinity,
                                                                                                          alignment: AlignmentDirectional(0.0, -0.12),
                                                                                                          child: Container(
                                                                                                            width: 64.0,
                                                                                                            height: 64.0,
                                                                                                            child: custom_widgets.PackReadyWeatherAnimation(
                                                                                                              wmoCode: tripItem.forecast.wmoCode,
                                                                                                              windSpeedMph: tripItem.forecast.windMph,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Container(),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                tripItem.progressLabel,
                                                                                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                                      font: GoogleFonts.inter(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                      ),
                                                                                                      color: () {
                                                                                                        if (tripItem.status == 'packed') {
                                                                                                          return FlutterFlowTheme.of(context).packedGreen;
                                                                                                        } else if (tripItem.status == 'incomplete') {
                                                                                                          return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                        } else if (tripItem.status == 'unpacked') {
                                                                                                          return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                        } else if (tripItem.status == 'event') {
                                                                                                          return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).secondary;
                                                                                                        }
                                                                                                      }(),
                                                                                                      fontSize: 13.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                              Container(
                                                                                                height: 6.0,
                                                                                              ),
                                                                                              LinearPercentIndicator(
                                                                                                percent: tripItem.progress,
                                                                                                lineHeight: 6.0,
                                                                                                animation: false,
                                                                                                animateFromLastPercent: true,
                                                                                                progressColor: () {
                                                                                                  if (tripItem.status == 'packed') {
                                                                                                    return FlutterFlowTheme.of(context).packedGreen;
                                                                                                  } else if (tripItem.status == 'incomplete') {
                                                                                                    return FlutterFlowTheme.of(context).pendingYellow;
                                                                                                  } else if (tripItem.status == 'unpacked') {
                                                                                                    return FlutterFlowTheme.of(context).unpackedOrange;
                                                                                                  } else if (tripItem.status == 'event') {
                                                                                                    return FlutterFlowTheme.of(context).calendarEventSlate;
                                                                                                  } else {
                                                                                                    return FlutterFlowTheme.of(context).primary;
                                                                                                  }
                                                                                                }(),
                                                                                                backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                                barRadius: Radius.circular(4.0),
                                                                                                padding: EdgeInsets.zero,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  if (tripItem.divider)
                                                                                    Container(
                                                                                      width: 20.0,
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                                                                                        child: Container(
                                                                                          width: 1.5,
                                                                                          height: double.infinity,
                                                                                          decoration: BoxDecoration(
                                                                                            color: () {
                                                                                              if (tripItem.dividerStatus == 'packed') {
                                                                                                return FlutterFlowTheme.of(context).packedGreenTint;
                                                                                              } else if (tripItem.dividerStatus == 'incomplete') {
                                                                                                return FlutterFlowTheme.of(context).pendingYellowTint;
                                                                                              } else if (tripItem.dividerStatus == 'unpacked') {
                                                                                                return FlutterFlowTheme.of(context).unpackedOrangeTint;
                                                                                              } else if (tripItem.dividerStatus == 'event') {
                                                                                                return FlutterFlowTheme.of(context).calendarEventTint;
                                                                                              } else {
                                                                                                return FlutterFlowTheme.of(context).alternate;
                                                                                              }
                                                                                            }(),
                                                                                            borderRadius: BorderRadius.circular(1.0),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  if (tripItem.hasNext ? !tripItem.divider : false)
                                                                                    Container(
                                                                                      width: 8.0,
                                                                                    ),
                                                                                  if (!tripItem.hasNext)
                                                                                    Container(
                                                                                      width: 10.0,
                                                                                    ),
                                                                                ],
                                                                              );
                                                                            },
                                                                            carouselController: _model.homeTripCarouselController ??=
                                                                                CarouselSliderController(),
                                                                            options:
                                                                                CarouselOptions(
                                                                              initialPage: max(
                                                                                  0,
                                                                                  min(
                                                                                      valueOrDefault<int>(
                                                                                        FFAppState().homeInitialTripIndex,
                                                                                        0,
                                                                                      ),
                                                                                      trip.length - 1)),
                                                                              viewportFraction: 0.6667,
                                                                              disableCenter: true,
                                                                              enlargeCenterPage: false,
                                                                              enlargeFactor: 0.0,
                                                                              enableInfiniteScroll: false,
                                                                              scrollDirection: Axis.horizontal,
                                                                              autoPlay: false,
                                                                              onPageChanged: (index, _) async {
                                                                                _model.homeTripCarouselCurrentIndex = index;
                                                                                logFirebaseEvent('MAINSCREEN_HomeTripCarousel_ON_WIDGET_SW');
                                                                                // Select the swiped trip and load its forecast
                                                                                await actions.selectHomeTrip(
                                                                                  context,
                                                                                  _model.homeTripCarouselCurrentIndex,
                                                                                );
                                                                                FFAppEventService.instance.triggerAppEvent(
                                                                                  HomeTripSelectedEvent(
                                                                                    data: HomeTripSelectionStruct(
                                                                                      tripIndex: _model.homeTripCarouselCurrentIndex,
                                                                                    ),
                                                                                    timestamp: DateTime.now(),
                                                                                    debugId: '',
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 10.0,
                                                          ),
                                                          wrapWithModel(
                                                            model: _model
                                                                .homeChecklistSelectionModel,
                                                            updateCallback: () =>
                                                                safeSetState(
                                                                    () {}),
                                                            child:
                                                                HomeChecklistSelectionWidget(),
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        if (!(Theme.of(context).brightness ==
                                            Brightness.dark))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 24.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'MAINSCREEN_MastheadButton_Button_5jv8ijn');
                                                GoRouter.of(context)
                                                    .prepareAuthEvent();
                                                await authManager.signOut();
                                                GoRouter.of(context)
                                                    .clearRedirectLocation();

                                                context.goNamedAuth(
                                                    LoginWidget.routeName,
                                                    context.mounted);
                                              },
                                              text: 'Logout',
                                              options: FFButtonOptions(
                                                height: 33.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 0.0, 12.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 13.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                        if (Theme.of(context).brightness ==
                                            Brightness.dark)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 24.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                logFirebaseEvent(
                                                    'MAINSCREEN_PAGE_btn_Logout_ON_TAP');
                                                GoRouter.of(context)
                                                    .prepareAuthEvent();
                                                await authManager.signOut();
                                                GoRouter.of(context)
                                                    .clearRedirectLocation();

                                                context.goNamedAuth(
                                                    LoginWidget.routeName,
                                                    context.mounted);
                                              },
                                              text: 'Logout',
                                              options: FFButtonOptions(
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
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
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!widget!.embedHome)
                wrapWithModel(
                  model: _model.packReadyTabBarModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PackReadyTabBarWidget(
                    activeTab: FFAppState().packReadyShellActiveTab,
                    shellNavigation: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
