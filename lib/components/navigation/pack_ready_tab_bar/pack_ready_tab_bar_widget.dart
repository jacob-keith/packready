import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pack_ready_tab_bar_model.dart';
export 'pack_ready_tab_bar_model.dart';

/// DSL component PackReadyTabBar
class PackReadyTabBarWidget extends StatefulWidget {
  const PackReadyTabBarWidget({
    super.key,
    this.activeTab,
    bool? shellNavigation,
  }) : this.shellNavigation = shellNavigation ?? false;

  final String? activeTab;

  /// Use on the outer Home page.
  ///
  /// Other pages navigate into the shell.
  final bool shellNavigation;

  @override
  State<PackReadyTabBarWidget> createState() => _PackReadyTabBarWidgetState();
}

class _PackReadyTabBarWidgetState extends State<PackReadyTabBarWidget> {
  late PackReadyTabBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackReadyTabBarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).tabBarSurface,
        border: Border(
          top: BorderSide(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(3.0, 4.0, 3.0, 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
          crossAxisAlignment: (FFCrossAxisAlignment.center).flutterValue,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('PACK_READY_TAB_BAR_COMP_Home_ON_TAP');
                  if (!(widget!.activeTab == 'Home')) {
                    if (widget!.shellNavigation) {
                      FFAppState().packReadyShellActiveTab = 'Home';
                      FFAppState().update(() {});
                    } else {
                      await actions.openPackReadyTab(
                        context,
                        'mainscreen',
                        0.0,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.activeTab == 'Home'
                          ? FlutterFlowTheme.of(context).tabBarActivePill
                          : FlutterFlowTheme.of(context).tabBarSurface,
                      FlutterFlowTheme.of(context).tabBarSurface,
                    ),
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 5.0, 0.5, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (!(Theme.of(context).brightness == Brightness.dark))
                          Icon(
                            Icons.home_outlined,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Home'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        if (Theme.of(context).brightness == Brightness.dark)
                          Icon(
                            Icons.home,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Home'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        AutoSizeText(
                          'Home',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 7.0,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.activeTab == 'Home'
                                      ? FlutterFlowTheme.of(context)
                                          .tabBarActiveInk
                                      : FlutterFlowTheme.of(context)
                                          .tabBarIdleInk,
                                  FlutterFlowTheme.of(context).tabBarIdleInk,
                                ),
                                fontSize: 10.5,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('PACK_READY_TAB_BAR_COMP_Create_ON_TAP');
                  if (!(widget!.activeTab == 'Create')) {
                    if (widget!.shellNavigation) {
                      FFAppState().packReadyShellActiveTab = 'Create';
                      FFAppState().update(() {});
                    } else {
                      await actions.openPackReadyTab(
                        context,
                        'Activities',
                        0.0,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.activeTab == 'Create'
                          ? FlutterFlowTheme.of(context).tabBarActivePill
                          : FlutterFlowTheme.of(context).tabBarSurface,
                      FlutterFlowTheme.of(context).tabBarSurface,
                    ),
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 5.0, 0.5, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (!(Theme.of(context).brightness == Brightness.dark))
                          Icon(
                            Icons.add_circle_outline,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Create'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        if (Theme.of(context).brightness == Brightness.dark)
                          Icon(
                            Icons.add_circle,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Create'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        AutoSizeText(
                          'Create',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 7.0,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.activeTab == 'Create'
                                      ? FlutterFlowTheme.of(context)
                                          .tabBarActiveInk
                                      : FlutterFlowTheme.of(context)
                                          .tabBarIdleInk,
                                  FlutterFlowTheme.of(context).tabBarIdleInk,
                                ),
                                fontSize: 10.5,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('PACK_READY_TAB_BAR_COMP_Reminders_ON_TAP');
                  if (!(widget!.activeTab == 'Reminders')) {
                    if (widget!.shellNavigation) {
                      FFAppState().packReadyShellActiveTab = 'Reminders';
                      FFAppState().update(() {});
                    } else {
                      await actions.openPackReadyTab(
                        context,
                        'RemindersPage',
                        0.0,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.activeTab == 'Reminders'
                          ? FlutterFlowTheme.of(context).tabBarActivePill
                          : FlutterFlowTheme.of(context).tabBarSurface,
                      FlutterFlowTheme.of(context).tabBarSurface,
                    ),
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 5.0, 0.5, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (!(Theme.of(context).brightness == Brightness.dark))
                          Icon(
                            Icons.notifications_none,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Reminders'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        if (Theme.of(context).brightness == Brightness.dark)
                          Icon(
                            Icons.notifications,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Reminders'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        AutoSizeText(
                          'Reminders',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 7.0,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.activeTab == 'Reminders'
                                      ? FlutterFlowTheme.of(context)
                                          .tabBarActiveInk
                                      : FlutterFlowTheme.of(context)
                                          .tabBarIdleInk,
                                  FlutterFlowTheme.of(context).tabBarIdleInk,
                                ),
                                fontSize: 10.5,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('PACK_READY_TAB_BAR_COMP_Calendar_ON_TAP');
                  if (!(widget!.activeTab == 'Calendar')) {
                    if (widget!.shellNavigation) {
                      FFAppState().packReadyShellActiveTab = 'Calendar';
                      FFAppState().update(() {});
                    } else {
                      await actions.openPackReadyTab(
                        context,
                        'Calendar',
                        0.0,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.activeTab == 'Calendar'
                          ? FlutterFlowTheme.of(context).tabBarActivePill
                          : FlutterFlowTheme.of(context).tabBarSurface,
                      FlutterFlowTheme.of(context).tabBarSurface,
                    ),
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 5.0, 0.5, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (!(Theme.of(context).brightness == Brightness.dark))
                          Icon(
                            Icons.calendar_today_outlined,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Calendar'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        if (Theme.of(context).brightness == Brightness.dark)
                          Icon(
                            Icons.calendar_today,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Calendar'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        AutoSizeText(
                          'Calendar',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 7.0,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.activeTab == 'Calendar'
                                      ? FlutterFlowTheme.of(context)
                                          .tabBarActiveInk
                                      : FlutterFlowTheme.of(context)
                                          .tabBarIdleInk,
                                  FlutterFlowTheme.of(context).tabBarIdleInk,
                                ),
                                fontSize: 10.5,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('PACK_READY_TAB_BAR_COMP_AI_ON_TAP');
                  if (!(widget!.activeTab == 'AI')) {
                    if (widget!.shellNavigation) {
                      FFAppState().packReadyShellActiveTab = 'AI';
                      FFAppState().update(() {});
                    } else {
                      await actions.openPackReadyTab(
                        context,
                        'PackReadyAi',
                        0.0,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.activeTab == 'AI'
                          ? FlutterFlowTheme.of(context).tabBarActivePill
                          : FlutterFlowTheme.of(context).tabBarSurface,
                      FlutterFlowTheme.of(context).tabBarSurface,
                    ),
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 5.0, 0.5, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Icon(
                          FFIcons.kautomationWave,
                          color: valueOrDefault<Color>(
                            widget!.activeTab == 'AI'
                                ? FlutterFlowTheme.of(context).tabBarActiveInk
                                : FlutterFlowTheme.of(context).tabBarIdleInk,
                            FlutterFlowTheme.of(context).tabBarIdleInk,
                          ),
                          size: 20.0,
                        ),
                        AutoSizeText(
                          'AI',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 7.0,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.activeTab == 'AI'
                                      ? FlutterFlowTheme.of(context)
                                          .tabBarActiveInk
                                      : FlutterFlowTheme.of(context)
                                          .tabBarIdleInk,
                                  FlutterFlowTheme.of(context).tabBarIdleInk,
                                ),
                                fontSize: 10.5,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  logFirebaseEvent('PACK_READY_TAB_BAR_Connections_ON_TAP');
                  if (!(widget!.activeTab == 'Connections')) {
                    if (widget!.shellNavigation) {
                      FFAppState().packReadyShellActiveTab = 'Connections';
                      FFAppState().update(() {});
                    } else {
                      await actions.openPackReadyTab(
                        context,
                        'Connections',
                        0.0,
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: valueOrDefault<Color>(
                      widget!.activeTab == 'Connections'
                          ? FlutterFlowTheme.of(context).tabBarActivePill
                          : FlutterFlowTheme.of(context).tabBarSurface,
                      FlutterFlowTheme.of(context).tabBarSurface,
                    ),
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.5, 5.0, 0.5, 5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (!(Theme.of(context).brightness == Brightness.dark))
                          Icon(
                            Icons.people_outline,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Connections'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        if (Theme.of(context).brightness == Brightness.dark)
                          Icon(
                            Icons.people,
                            color: valueOrDefault<Color>(
                              widget!.activeTab == 'Connections'
                                  ? FlutterFlowTheme.of(context).tabBarActiveInk
                                  : FlutterFlowTheme.of(context).tabBarIdleInk,
                              FlutterFlowTheme.of(context).tabBarIdleInk,
                            ),
                            size: 20.0,
                          ),
                        AutoSizeText(
                          'Connections',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          minFontSize: 7.0,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: valueOrDefault<Color>(
                                  widget!.activeTab == 'Connections'
                                      ? FlutterFlowTheme.of(context)
                                          .tabBarActiveInk
                                      : FlutterFlowTheme.of(context)
                                          .tabBarIdleInk,
                                  FlutterFlowTheme.of(context).tabBarIdleInk,
                                ),
                                fontSize: 10.5,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .fontStyle,
                              ),
                        ),
                      ].divide(SizedBox(height: 2.0)),
                    ),
                  ),
                ),
              ),
            ),
          ].divide(SizedBox(width: 1.5)),
        ),
      ),
    );
  }
}
