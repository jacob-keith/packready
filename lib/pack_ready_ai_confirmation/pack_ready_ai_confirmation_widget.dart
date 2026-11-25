import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pack_ready_ai_confirmation_model.dart';
export 'pack_ready_ai_confirmation_model.dart';

/// Review AI changes and recurring links before applying.
class PackReadyAiConfirmationWidget extends StatefulWidget {
  const PackReadyAiConfirmationWidget({
    super.key,
    this.plan,
  });

  final PackReadyAiPlanStruct? plan;

  static String routeName = 'PackReadyAiConfirmation';
  static String routePath = '/ai-confirmation';

  @override
  State<PackReadyAiConfirmationWidget> createState() =>
      _PackReadyAiConfirmationWidgetState();
}

class _PackReadyAiConfirmationWidgetState
    extends State<PackReadyAiConfirmationWidget> {
  late PackReadyAiConfirmationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackReadyAiConfirmationModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'PackReadyAiConfirmation'});
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
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
              crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Container(
                  height: 57.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6.0,
                        color: FlutterFlowTheme.of(context).softShadow,
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                      )
                    ],
                    border: Border(
                      bottom: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                    crossAxisAlignment:
                        (FFCrossAxisAlignment.center).flutterValue,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      FlutterFlowIconButton(
                        buttonSize: 56.0,
                        icon: Icon(
                          Icons.arrow_back,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          logFirebaseEvent(
                              'PACK_READY_AI_CONFIRMATION_AiReviewBackA');
                          // Return without applying the AI plan
                          await actions.packReadyAiDismiss(
                            context,
                            false,
                          );
                        },
                      ),
                      Text(
                        'Confirm AI plan',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                              ),
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(width: 16.0)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(18.0, 24.0, 18.0, 24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment:
                            (FFMainAxisAlignment.start).flutterValue,
                        crossAxisAlignment:
                            (FFCrossAxisAlignment.center).flutterValue,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            width: double.infinity,
                            constraints: BoxConstraints(
                              maxWidth: 660.0,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment:
                                  (FFMainAxisAlignment.start).flutterValue,
                              crossAxisAlignment:
                                  (FFCrossAxisAlignment.stretch).flutterValue,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  widget!.plan!.title,
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w800,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 28.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                ),
                                Container(
                                  height: 4.0,
                                ),
                                Text(
                                  widget!.plan!.description,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                if (widget!.plan?.hasChanges ?? true)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 14.0, 0.0, 0.0),
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
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .selectedSurface,
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(7.0, 9.0, 7.0, 9.0),
                                              child: Text(
                                                widget!.plan!.addLabel,
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .warmTerracottaTint,
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(7.0, 9.0, 7.0, 9.0),
                                              child: Text(
                                                widget!.plan!.editLabel,
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .warning,
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .unpackedOrangeTint,
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(7.0, 9.0, 7.0, 9.0),
                                              child: Text(
                                                widget!.plan!.deleteLabel,
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .spaceGrotesk(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          fontSize: 13.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(width: 6.0)),
                                    ),
                                  ),
                                if (!(widget!.plan?.links?.length == 0))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 20.0, 0.0, 16.0),
                                    child: Builder(
                                      builder: (context) {
                                        final linkItem =
                                            widget!.plan?.links?.toList() ?? [];

                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.start)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.stretch)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: List.generate(
                                              linkItem.length, (linkItemIndex) {
                                            final linkItemItem =
                                                linkItem[linkItemIndex];
                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(9.0),
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
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  4.0,
                                                                  1.0,
                                                                  4.0,
                                                                  8.0),
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
                                                          Icon(
                                                            Icons.link,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .linkGreen,
                                                            size: 18.0,
                                                          ),
                                                          Text(
                                                            'Activity link',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .manrope(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 2.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .softShadow,
                                                            offset: Offset(
                                                              0.0,
                                                              1.0,
                                                            ),
                                                            spreadRadius: 0.0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    9.0,
                                                                    10.0,
                                                                    9.0),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          color:
                                                              Color(0x00000000),
                                                          child:
                                                              ExpandableNotifier(
                                                            initialExpanded:
                                                                false,
                                                            child:
                                                                ExpandablePanel(
                                                              header: Row(
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
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'add')
                                                                    Container(
                                                                      width:
                                                                          38.0,
                                                                      height:
                                                                          38.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .selectedSurface,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            (FFMainAxisAlignment.center).flutterValue,
                                                                        crossAxisAlignment:
                                                                            (FFCrossAxisAlignment.center).flutterValue,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                        children: [
                                                                          if (linkItemItem.glyph ==
                                                                              'inventory')
                                                                            Icon(
                                                                              Icons.inventory_2_outlined,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'edit')
                                                                            Icon(
                                                                              Icons.edit_outlined,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'delete')
                                                                            Icon(
                                                                              Icons.delete_outline,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'link')
                                                                            Icon(
                                                                              Icons.link,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'unlink')
                                                                            Icon(
                                                                              Icons.link_off,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              size: 20.0,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'edit')
                                                                    Container(
                                                                      width:
                                                                          38.0,
                                                                      height:
                                                                          38.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .warmTerracottaTint,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            (FFMainAxisAlignment.center).flutterValue,
                                                                        crossAxisAlignment:
                                                                            (FFCrossAxisAlignment.center).flutterValue,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                        children: [
                                                                          if (linkItemItem.glyph ==
                                                                              'inventory')
                                                                            Icon(
                                                                              Icons.inventory_2_outlined,
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'edit')
                                                                            Icon(
                                                                              Icons.edit_outlined,
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'delete')
                                                                            Icon(
                                                                              Icons.delete_outline,
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'link')
                                                                            Icon(
                                                                              Icons.link,
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'unlink')
                                                                            Icon(
                                                                              Icons.link_off,
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              size: 20.0,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'delete')
                                                                    Container(
                                                                      width:
                                                                          38.0,
                                                                      height:
                                                                          38.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            (FFMainAxisAlignment.center).flutterValue,
                                                                        crossAxisAlignment:
                                                                            (FFCrossAxisAlignment.center).flutterValue,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                        children: [
                                                                          if (linkItemItem.glyph ==
                                                                              'inventory')
                                                                            Icon(
                                                                              Icons.inventory_2_outlined,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'edit')
                                                                            Icon(
                                                                              Icons.edit_outlined,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'delete')
                                                                            Icon(
                                                                              Icons.delete_outline,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'link')
                                                                            Icon(
                                                                              Icons.link,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'unlink')
                                                                            Icon(
                                                                              Icons.link_off,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'skipped')
                                                                    Container(
                                                                      width:
                                                                          38.0,
                                                                      height:
                                                                          38.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .selectedSurface,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            (FFMainAxisAlignment.center).flutterValue,
                                                                        crossAxisAlignment:
                                                                            (FFCrossAxisAlignment.center).flutterValue,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                        children: [
                                                                          if (linkItemItem.glyph ==
                                                                              'inventory')
                                                                            Icon(
                                                                              Icons.inventory_2_outlined,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'edit')
                                                                            Icon(
                                                                              Icons.edit_outlined,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'delete')
                                                                            Icon(
                                                                              Icons.delete_outline,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'link')
                                                                            Icon(
                                                                              Icons.link,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          if (linkItemItem.glyph ==
                                                                              'unlink')
                                                                            Icon(
                                                                              Icons.link_off,
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
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
                                                                        Text(
                                                                          linkItemItem
                                                                              .title,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                font: GoogleFonts.manrope(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        if (!(linkItemItem.scope ==
                                                                            ''))
                                                                          Text(
                                                                            linkItemItem.scope,
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  font: GoogleFonts.inter(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 12.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'add')
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .selectedSurface,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                        child:
                                                                            Text(
                                                                          linkItemItem
                                                                              .actionLabel,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .override(
                                                                                font: GoogleFonts.spaceGrotesk(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                fontSize: 10.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'edit')
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .warmTerracottaTint,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                        child:
                                                                            Text(
                                                                          linkItemItem
                                                                              .actionLabel,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .override(
                                                                                font: GoogleFonts.spaceGrotesk(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).warning,
                                                                                fontSize: 10.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'delete')
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .unpackedOrangeTint,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                        child:
                                                                            Text(
                                                                          linkItemItem
                                                                              .actionLabel,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .override(
                                                                                font: GoogleFonts.spaceGrotesk(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).error,
                                                                                fontSize: 10.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (linkItemItem
                                                                          .tone ==
                                                                      'skipped')
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .selectedSurface,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                        child:
                                                                            Text(
                                                                          linkItemItem
                                                                              .actionLabel,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .override(
                                                                                font: GoogleFonts.spaceGrotesk(
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 10.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                              ),
                                                              collapsed:
                                                                  Container(
                                                                height: 0.0,
                                                              ),
                                                              expanded: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            6.0,
                                                                            5.0,
                                                                            3.0),
                                                                child: Column(
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
                                                                  children: [
                                                                    Divider(
                                                                      height:
                                                                          14.0,
                                                                      thickness:
                                                                          1.0,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                    ),
                                                                    Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final detailLine = linkItemItem
                                                                            .details
                                                                            .toList();

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              (FFMainAxisAlignment.start).flutterValue,
                                                                          crossAxisAlignment:
                                                                              (FFCrossAxisAlignment.start).flutterValue,
                                                                          textBaseline:
                                                                              TextBaseline.alphabetic,
                                                                          children: List.generate(
                                                                              detailLine.length,
                                                                              (detailLineIndex) {
                                                                            final detailLineItem =
                                                                                detailLine[detailLineIndex];
                                                                            return Text(
                                                                              detailLineItem,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 14.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            );
                                                                          }).divide(
                                                                              SizedBox(height: 4.0)),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              theme:
                                                                  ExpandableThemeData(
                                                                tapHeaderToExpand:
                                                                    true,
                                                                tapBodyToExpand:
                                                                    false,
                                                                tapBodyToCollapse:
                                                                    false,
                                                                headerAlignment:
                                                                    ExpandablePanelHeaderAlignment
                                                                        .center,
                                                                hasIcon: true,
                                                                iconSize: 22.0,
                                                                iconColor: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  14.0,
                                                                  5.0,
                                                                  14.0,
                                                                  5.0),
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
                                                          Icon(
                                                            Icons.south,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .linkGreen,
                                                            size: 17.0,
                                                          ),
                                                          Text(
                                                            linkItemItem
                                                                .connector,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .spaceGrotesk(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .linkGreen,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 8.0)),
                                                      ),
                                                    ),
                                                    if (!(linkItemItem
                                                            .dates.length ==
                                                        0))
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 2.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .softShadow,
                                                              offset: Offset(
                                                                0.0,
                                                                1.0,
                                                              ),
                                                              spreadRadius: 0.0,
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      9.0,
                                                                      10.0,
                                                                      9.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            color: Color(
                                                                0x00000000),
                                                            child:
                                                                ExpandableNotifier(
                                                              initialExpanded:
                                                                  false,
                                                              child:
                                                                  ExpandablePanel(
                                                                header: Row(
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
                                                                      width:
                                                                          38.0,
                                                                      height:
                                                                          38.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .selectedSurface,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .event_available_outlined,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            (FFMainAxisAlignment.start).flutterValue,
                                                                        crossAxisAlignment:
                                                                            (FFCrossAxisAlignment.start).flutterValue,
                                                                        textBaseline:
                                                                            TextBaseline.alphabetic,
                                                                        children: [
                                                                          Text(
                                                                            linkItemItem.targetTitle,
                                                                            style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                  font: GoogleFonts.manrope(
                                                                                    fontWeight: FontWeight.w800,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w800,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                          if (!(linkItemItem.targetScope ==
                                                                              ''))
                                                                            Text(
                                                                              linkItemItem.targetScope,
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    font: GoogleFonts.inter(
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                  ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          10.0)),
                                                                ),
                                                                collapsed:
                                                                    Container(
                                                                  height: 0.0,
                                                                ),
                                                                expanded:
                                                                    Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          6.0,
                                                                          5.0,
                                                                          3.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        (FFMainAxisAlignment.start)
                                                                            .flutterValue,
                                                                    crossAxisAlignment:
                                                                        (FFCrossAxisAlignment.stretch)
                                                                            .flutterValue,
                                                                    textBaseline:
                                                                        TextBaseline
                                                                            .alphabetic,
                                                                    children: [
                                                                      Divider(
                                                                        height:
                                                                            14.0,
                                                                        thickness:
                                                                            1.0,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .alternate,
                                                                      ),
                                                                      if (!(linkItemItem
                                                                              .dates
                                                                              .length ==
                                                                          0))
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              (FFMainAxisAlignment.start).flutterValue,
                                                                          crossAxisAlignment:
                                                                              (FFCrossAxisAlignment.start).flutterValue,
                                                                          textBaseline:
                                                                              TextBaseline.alphabetic,
                                                                          children:
                                                                              [
                                                                            Container(
                                                                              height: 4.0,
                                                                            ),
                                                                            Text(
                                                                              'Occurrence dates',
                                                                              style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                    font: GoogleFonts.spaceGrotesk(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 12.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                            Builder(
                                                                              builder: (context) {
                                                                                final entry = linkItemItem.dates.toList();

                                                                                return Wrap(
                                                                                  spacing: 12.0,
                                                                                  runSpacing: 6.0,
                                                                                  alignment: WrapAlignment.start,
                                                                                  crossAxisAlignment: WrapCrossAlignment.start,
                                                                                  direction: Axis.horizontal,
                                                                                  runAlignment: WrapAlignment.start,
                                                                                  verticalDirection: VerticalDirection.down,
                                                                                  clipBehavior: Clip.none,
                                                                                  children: List.generate(entry.length, (entryIndex) {
                                                                                    final entryItem = entry[entryIndex];
                                                                                    return Text(
                                                                                      entryItem,
                                                                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                            ),
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                          ),
                                                                                    );
                                                                                  }),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ].divide(SizedBox(height: 6.0)),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                theme:
                                                                    ExpandableThemeData(
                                                                  tapHeaderToExpand:
                                                                      true,
                                                                  tapBodyToExpand:
                                                                      false,
                                                                  tapBodyToCollapse:
                                                                      false,
                                                                  headerAlignment:
                                                                      ExpandablePanelHeaderAlignment
                                                                          .center,
                                                                  hasIcon: true,
                                                                  iconSize:
                                                                      22.0,
                                                                  iconColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (!!(linkItemItem
                                                            .dates.length ==
                                                        0))
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 2.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .softShadow,
                                                              offset: Offset(
                                                                0.0,
                                                                1.0,
                                                              ),
                                                              spreadRadius: 0.0,
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
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
                                                                width: 38.0,
                                                                height: 38.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .selectedSurface,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .event_available_outlined,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
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
                                                                    Text(
                                                                      linkItemItem
                                                                          .targetTitle,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.manrope(
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w800,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    if (!(linkItemItem
                                                                            .targetScope ==
                                                                        ''))
                                                                      Text(
                                                                        linkItemItem
                                                                            .targetScope,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              font: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .selectedSurface,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6.0),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                                  child: Text(
                                                                    linkItemItem
                                                                        .itemCountLabel,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.spaceGrotesk(
                                                                            fontWeight:
                                                                                FontWeight.w800,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              10.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                width: 10.0)),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).divide(SizedBox(height: 16.0)),
                                        );
                                      },
                                    ),
                                  ),
                                if (!(widget!.plan?.otherChanges?.length == 0))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 24.0, 0.0, 10.0),
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
                                          Icons.layers_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .linkGreen,
                                          size: 18.0,
                                        ),
                                        Text(
                                          'Other changes',
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                if (!(widget!.plan?.otherChanges?.length == 0))
                                  Builder(
                                    builder: (context) {
                                      final changeItem = widget!
                                              .plan?.otherChanges
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
                                        textBaseline: TextBaseline.alphabetic,
                                        children:
                                            List.generate(changeItem.length,
                                                (changeItemIndex) {
                                          final changeItemItem =
                                              changeItem[changeItemIndex];
                                          return Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .softShadow,
                                                  offset: Offset(
                                                    0.0,
                                                    1.0,
                                                  ),
                                                  spreadRadius: 0.0,
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(14.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 9.0, 10.0, 9.0),
                                              child: Container(
                                                width: double.infinity,
                                                color: Color(0x00000000),
                                                child: ExpandableNotifier(
                                                  initialExpanded: false,
                                                  child: ExpandablePanel(
                                                    header: Row(
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
                                                        if (changeItemItem
                                                                .tone ==
                                                            'add')
                                                          Container(
                                                            width: 38.0,
                                                            height: 38.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .selectedSurface,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'inventory')
                                                                  Icon(
                                                                    Icons
                                                                        .inventory_2_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'edit')
                                                                  Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'delete')
                                                                  Icon(
                                                                    Icons
                                                                        .delete_outline,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'link')
                                                                  Icon(
                                                                    Icons.link,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'unlink')
                                                                  Icon(
                                                                    Icons
                                                                        .link_off,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    size: 20.0,
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'edit')
                                                          Container(
                                                            width: 38.0,
                                                            height: 38.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .warmTerracottaTint,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'inventory')
                                                                  Icon(
                                                                    Icons
                                                                        .inventory_2_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'edit')
                                                                  Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'delete')
                                                                  Icon(
                                                                    Icons
                                                                        .delete_outline,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'link')
                                                                  Icon(
                                                                    Icons.link,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'unlink')
                                                                  Icon(
                                                                    Icons
                                                                        .link_off,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                    size: 20.0,
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'delete')
                                                          Container(
                                                            width: 38.0,
                                                            height: 38.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'inventory')
                                                                  Icon(
                                                                    Icons
                                                                        .inventory_2_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'edit')
                                                                  Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'delete')
                                                                  Icon(
                                                                    Icons
                                                                        .delete_outline,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'link')
                                                                  Icon(
                                                                    Icons.link,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'unlink')
                                                                  Icon(
                                                                    Icons
                                                                        .link_off,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'skipped')
                                                          Container(
                                                            width: 38.0,
                                                            height: 38.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .selectedSurface,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
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
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'inventory')
                                                                  Icon(
                                                                    Icons
                                                                        .inventory_2_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'edit')
                                                                  Icon(
                                                                    Icons
                                                                        .edit_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'delete')
                                                                  Icon(
                                                                    Icons
                                                                        .delete_outline,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'link')
                                                                  Icon(
                                                                    Icons.link,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                                if (changeItemItem
                                                                        .glyph ==
                                                                    'unlink')
                                                                  Icon(
                                                                    Icons
                                                                        .link_off,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 20.0,
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                              Text(
                                                                changeItemItem
                                                                    .title,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .manrope(
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      fontSize:
                                                                          16.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              if (!(changeItemItem
                                                                      .scope ==
                                                                  ''))
                                                                Text(
                                                                  changeItemItem
                                                                      .scope,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'add')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .selectedSurface,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                              child: Text(
                                                                changeItemItem
                                                                    .actionLabel,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .spaceGrotesk(
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'edit')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .warmTerracottaTint,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                              child: Text(
                                                                changeItemItem
                                                                    .actionLabel,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .spaceGrotesk(
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'delete')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .unpackedOrangeTint,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                              child: Text(
                                                                changeItemItem
                                                                    .actionLabel,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .spaceGrotesk(
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        if (changeItemItem
                                                                .tone ==
                                                            'skipped')
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .selectedSurface,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                              child: Text(
                                                                changeItemItem
                                                                    .actionLabel,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelSmall
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .spaceGrotesk(
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelSmall
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                      ].divide(SizedBox(
                                                          width: 10.0)),
                                                    ),
                                                    collapsed: Container(
                                                      height: 0.0,
                                                    ),
                                                    expanded: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  6.0,
                                                                  5.0,
                                                                  3.0),
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
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: [
                                                          Divider(
                                                            height: 14.0,
                                                            thickness: 1.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                          ),
                                                          Builder(
                                                            builder: (context) {
                                                              final detailLine =
                                                                  changeItemItem
                                                                      .details
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
                                                                            .start)
                                                                        .flutterValue,
                                                                textBaseline:
                                                                    TextBaseline
                                                                        .alphabetic,
                                                                children: List.generate(
                                                                    detailLine
                                                                        .length,
                                                                    (detailLineIndex) {
                                                                  final detailLineItem =
                                                                      detailLine[
                                                                          detailLineIndex];
                                                                  return Text(
                                                                    detailLineItem,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  );
                                                                }).divide(
                                                                    SizedBox(
                                                                        height:
                                                                            4.0)),
                                                              );
                                                            },
                                                          ),
                                                          if (!(changeItemItem
                                                                  .dates
                                                                  .length ==
                                                              0))
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
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
                                                                Container(
                                                                  height: 4.0,
                                                                ),
                                                                Text(
                                                                  'Occurrence dates',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .spaceGrotesk(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final entry =
                                                                        changeItemItem
                                                                            .dates
                                                                            .toList();

                                                                    return Wrap(
                                                                      spacing:
                                                                          12.0,
                                                                      runSpacing:
                                                                          6.0,
                                                                      alignment:
                                                                          WrapAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          WrapCrossAlignment
                                                                              .start,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      runAlignment:
                                                                          WrapAlignment
                                                                              .start,
                                                                      verticalDirection:
                                                                          VerticalDirection
                                                                              .down,
                                                                      clipBehavior:
                                                                          Clip.none,
                                                                      children: List.generate(
                                                                          entry
                                                                              .length,
                                                                          (entryIndex) {
                                                                        final entryItem =
                                                                            entry[entryIndex];
                                                                        return Text(
                                                                          entryItem,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                ),
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                        );
                                                                      }),
                                                                    );
                                                                  },
                                                                ),
                                                              ].divide(SizedBox(
                                                                  height: 6.0)),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    theme: ExpandableThemeData(
                                                      tapHeaderToExpand: true,
                                                      tapBodyToExpand: false,
                                                      tapBodyToCollapse: false,
                                                      headerAlignment:
                                                          ExpandablePanelHeaderAlignment
                                                              .center,
                                                      hasIcon: true,
                                                      iconSize: 22.0,
                                                      iconColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).divide(SizedBox(height: 8.0)),
                                      );
                                    },
                                  ),
                                if (!(widget!.plan?.skipped?.length == 0)
                                    ? !widget!.plan!.hasChanges
                                    : false)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 10.0),
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
                                              .linkGreen,
                                          size: 18.0,
                                        ),
                                        Text(
                                          'Already linked',
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 8.0)),
                                    ),
                                  ),
                                if (!(widget!.plan?.skipped?.length == 0))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Builder(
                                      builder: (context) {
                                        final skippedItem =
                                            widget!.plan?.skipped?.toList() ??
                                                [];

                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              (FFMainAxisAlignment.start)
                                                  .flutterValue,
                                          crossAxisAlignment:
                                              (FFCrossAxisAlignment.stretch)
                                                  .flutterValue,
                                          textBaseline: TextBaseline.alphabetic,
                                          children:
                                              List.generate(skippedItem.length,
                                                  (skippedItemIndex) {
                                            final skippedItemItem =
                                                skippedItem[skippedItemIndex];
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
                                              children: [
                                                if (!(skippedItemItem
                                                        .dates.length ==
                                                    0))
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 2.0,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .softShadow,
                                                          offset: Offset(
                                                            0.0,
                                                            1.0,
                                                          ),
                                                          spreadRadius: 0.0,
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  9.0,
                                                                  10.0,
                                                                  9.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        color:
                                                            Color(0x00000000),
                                                        child:
                                                            ExpandableNotifier(
                                                          initialExpanded:
                                                              false,
                                                          child:
                                                              ExpandablePanel(
                                                            header: Row(
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
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'add')
                                                                  Container(
                                                                    width: 38.0,
                                                                    height:
                                                                        38.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .selectedSurface,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
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
                                                                        if (skippedItemItem.glyph ==
                                                                            'inventory')
                                                                          Icon(
                                                                            Icons.inventory_2_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'edit')
                                                                          Icon(
                                                                            Icons.edit_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'delete')
                                                                          Icon(
                                                                            Icons.delete_outline,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'link')
                                                                          Icon(
                                                                            Icons.link,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'unlink')
                                                                          Icon(
                                                                            Icons.link_off,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'edit')
                                                                  Container(
                                                                    width: 38.0,
                                                                    height:
                                                                        38.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warmTerracottaTint,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
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
                                                                        if (skippedItemItem.glyph ==
                                                                            'inventory')
                                                                          Icon(
                                                                            Icons.inventory_2_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).warning,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'edit')
                                                                          Icon(
                                                                            Icons.edit_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).warning,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'delete')
                                                                          Icon(
                                                                            Icons.delete_outline,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).warning,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'link')
                                                                          Icon(
                                                                            Icons.link,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).warning,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'unlink')
                                                                          Icon(
                                                                            Icons.link_off,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).warning,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'delete')
                                                                  Container(
                                                                    width: 38.0,
                                                                    height:
                                                                        38.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
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
                                                                        if (skippedItemItem.glyph ==
                                                                            'inventory')
                                                                          Icon(
                                                                            Icons.inventory_2_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'edit')
                                                                          Icon(
                                                                            Icons.edit_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'delete')
                                                                          Icon(
                                                                            Icons.delete_outline,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'link')
                                                                          Icon(
                                                                            Icons.link,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'unlink')
                                                                          Icon(
                                                                            Icons.link_off,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'skipped')
                                                                  Container(
                                                                    width: 38.0,
                                                                    height:
                                                                        38.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .selectedSurface,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
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
                                                                        if (skippedItemItem.glyph ==
                                                                            'inventory')
                                                                          Icon(
                                                                            Icons.inventory_2_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'edit')
                                                                          Icon(
                                                                            Icons.edit_outlined,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'delete')
                                                                          Icon(
                                                                            Icons.delete_outline,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'link')
                                                                          Icon(
                                                                            Icons.link,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        if (skippedItemItem.glyph ==
                                                                            'unlink')
                                                                          Icon(
                                                                            Icons.link_off,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
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
                                                                      Text(
                                                                        skippedItemItem
                                                                            .title,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              font: GoogleFonts.manrope(
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      if (!(skippedItemItem
                                                                              .scope ==
                                                                          ''))
                                                                        Text(
                                                                          skippedItemItem
                                                                              .scope,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                              ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'add')
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .selectedSurface,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                                      child:
                                                                          Text(
                                                                        skippedItemItem
                                                                            .actionLabel,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.spaceGrotesk(
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'edit')
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warmTerracottaTint,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                                      child:
                                                                          Text(
                                                                        skippedItemItem
                                                                            .actionLabel,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.spaceGrotesk(
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).warning,
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'delete')
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .unpackedOrangeTint,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                                      child:
                                                                          Text(
                                                                        skippedItemItem
                                                                            .actionLabel,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.spaceGrotesk(
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).error,
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                if (skippedItemItem
                                                                        .tone ==
                                                                    'skipped')
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .selectedSurface,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          7.0,
                                                                          3.0,
                                                                          7.0,
                                                                          3.0),
                                                                      child:
                                                                          Text(
                                                                        skippedItemItem
                                                                            .actionLabel,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .override(
                                                                              font: GoogleFonts.spaceGrotesk(
                                                                                fontWeight: FontWeight.w800,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 10.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w800,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                            collapsed:
                                                                Container(
                                                              height: 0.0,
                                                            ),
                                                            expanded: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          5.0,
                                                                          6.0,
                                                                          5.0,
                                                                          3.0),
                                                              child: Column(
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
                                                                children: [
                                                                  Divider(
                                                                    height:
                                                                        14.0,
                                                                    thickness:
                                                                        1.0,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                  ),
                                                                  if (!(skippedItemItem
                                                                          .dates
                                                                          .length ==
                                                                      0))
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      mainAxisAlignment:
                                                                          (FFMainAxisAlignment.start)
                                                                              .flutterValue,
                                                                      crossAxisAlignment:
                                                                          (FFCrossAxisAlignment.start)
                                                                              .flutterValue,
                                                                      textBaseline:
                                                                          TextBaseline
                                                                              .alphabetic,
                                                                      children:
                                                                          [
                                                                        Container(
                                                                          height:
                                                                              4.0,
                                                                        ),
                                                                        Text(
                                                                          'Occurrence dates',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .override(
                                                                                font: GoogleFonts.spaceGrotesk(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 12.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            final entry =
                                                                                skippedItemItem.dates.toList();

                                                                            return Wrap(
                                                                              spacing: 12.0,
                                                                              runSpacing: 6.0,
                                                                              alignment: WrapAlignment.start,
                                                                              crossAxisAlignment: WrapCrossAlignment.start,
                                                                              direction: Axis.horizontal,
                                                                              runAlignment: WrapAlignment.start,
                                                                              verticalDirection: VerticalDirection.down,
                                                                              clipBehavior: Clip.none,
                                                                              children: List.generate(entry.length, (entryIndex) {
                                                                                final entryItem = entry[entryIndex];
                                                                                return Text(
                                                                                  entryItem,
                                                                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                        font: GoogleFonts.inter(
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                        ),
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                                      ),
                                                                                );
                                                                              }),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ].divide(SizedBox(
                                                                              height: 6.0)),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                            theme:
                                                                ExpandableThemeData(
                                                              tapHeaderToExpand:
                                                                  true,
                                                              tapBodyToExpand:
                                                                  false,
                                                              tapBodyToCollapse:
                                                                  false,
                                                              headerAlignment:
                                                                  ExpandablePanelHeaderAlignment
                                                                      .center,
                                                              hasIcon: true,
                                                              iconSize: 22.0,
                                                              iconColor: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                if (!!(skippedItemItem
                                                        .dates.length ==
                                                    0))
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 2.0,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .softShadow,
                                                          offset: Offset(
                                                            0.0,
                                                            1.0,
                                                          ),
                                                          spreadRadius: 0.0,
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
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
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'add')
                                                            Container(
                                                              width: 38.0,
                                                              height: 38.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .selectedSurface,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
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
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'inventory')
                                                                    Icon(
                                                                      Icons
                                                                          .inventory_2_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'edit')
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'delete')
                                                                    Icon(
                                                                      Icons
                                                                          .delete_outline,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'link')
                                                                    Icon(
                                                                      Icons
                                                                          .link,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'unlink')
                                                                    Icon(
                                                                      Icons
                                                                          .link_off,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'edit')
                                                            Container(
                                                              width: 38.0,
                                                              height: 38.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .warmTerracottaTint,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
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
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'inventory')
                                                                    Icon(
                                                                      Icons
                                                                          .inventory_2_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'edit')
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'delete')
                                                                    Icon(
                                                                      Icons
                                                                          .delete_outline,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'link')
                                                                    Icon(
                                                                      Icons
                                                                          .link,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'unlink')
                                                                    Icon(
                                                                      Icons
                                                                          .link_off,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .warning,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'delete')
                                                            Container(
                                                              width: 38.0,
                                                              height: 38.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
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
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'inventory')
                                                                    Icon(
                                                                      Icons
                                                                          .inventory_2_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'edit')
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'delete')
                                                                    Icon(
                                                                      Icons
                                                                          .delete_outline,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'link')
                                                                    Icon(
                                                                      Icons
                                                                          .link,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'unlink')
                                                                    Icon(
                                                                      Icons
                                                                          .link_off,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'skipped')
                                                            Container(
                                                              width: 38.0,
                                                              height: 38.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .selectedSurface,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
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
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'inventory')
                                                                    Icon(
                                                                      Icons
                                                                          .inventory_2_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'edit')
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'delete')
                                                                    Icon(
                                                                      Icons
                                                                          .delete_outline,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'link')
                                                                    Icon(
                                                                      Icons
                                                                          .link,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                  if (skippedItemItem
                                                                          .glyph ==
                                                                      'unlink')
                                                                    Icon(
                                                                      Icons
                                                                          .link_off,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
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
                                                                Text(
                                                                  skippedItemItem
                                                                      .title,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .manrope(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                if (!(skippedItemItem
                                                                        .scope ==
                                                                    ''))
                                                                  Text(
                                                                    skippedItemItem
                                                                        .scope,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'add')
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .selectedSurface,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                child: Text(
                                                                  skippedItemItem
                                                                      .actionLabel,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .spaceGrotesk(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'edit')
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .warmTerracottaTint,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                child: Text(
                                                                  skippedItemItem
                                                                      .actionLabel,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .spaceGrotesk(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .warning,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'delete')
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .unpackedOrangeTint,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                child: Text(
                                                                  skippedItemItem
                                                                      .actionLabel,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .spaceGrotesk(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .error,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          if (skippedItemItem
                                                                  .tone ==
                                                              'skipped')
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .selectedSurface,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.0),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            7.0,
                                                                            3.0,
                                                                            7.0,
                                                                            3.0),
                                                                child: Text(
                                                                  skippedItemItem
                                                                      .actionLabel,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .spaceGrotesk(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        fontSize:
                                                                            10.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelSmall
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                        ].divide(SizedBox(
                                                            width: 10.0)),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            );
                                          }).divide(SizedBox(height: 8.0)),
                                        );
                                      },
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    border: Border(
                      top: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(18.0, 12.0, 18.0, 12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          (FFMainAxisAlignment.start).flutterValue,
                      crossAxisAlignment:
                          (FFCrossAxisAlignment.center).flutterValue,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 660.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                                (FFMainAxisAlignment.start).flutterValue,
                            crossAxisAlignment:
                                (FFCrossAxisAlignment.center).flutterValue,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              if (widget!.plan?.hasChanges ?? true)
                                FFButtonWidget(
                                  onPressed: () async {
                                    logFirebaseEvent(
                                        'PACK_READY_AI_CONFIRMATION_AiPlanBack_ON');
                                    // Return without applying the AI plan
                                    await actions.packReadyAiDismiss(
                                      context,
                                      false,
                                    );
                                  },
                                  text: 'Back',
                                  options: FFButtonOptions(
                                    width: 62.0,
                                    height: 42.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Colors.transparent,
                                    textStyle: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  showLoadingIndicator: false,
                                ),
                              if (widget!.plan?.hasChanges ?? true)
                                Expanded(
                                  flex: 1,
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'PACK_READY_AI_CONFIRMATION_AiPlanApply_O');
                                      // Confirm and return approval to apply the AI plan
                                      await actions.packReadyAiDismiss(
                                        context,
                                        true,
                                      );
                                    },
                                    text: 'Apply Changes',
                                    icon: Icon(
                                      Icons.check,
                                      size: 20.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 42.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 8.0, 0.0),
                                      iconColor: FlutterFlowTheme.of(context)
                                          .onPrimary,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onPrimary,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w800,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    showLoadingIndicator: false,
                                  ),
                                ),
                              if (!widget!.plan!.hasChanges)
                                Expanded(
                                  flex: 1,
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      logFirebaseEvent(
                                          'PACK_READY_AI_CONFIRMATION_AiPlanDone_ON');
                                      // Close the completed AI plan
                                      await actions.packReadyAiDismiss(
                                        context,
                                        true,
                                      );
                                    },
                                    text: 'Done',
                                    icon: Icon(
                                      Icons.check,
                                      size: 20.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 42.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 8.0, 0.0),
                                      iconColor: FlutterFlowTheme.of(context)
                                          .onLimeCta,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight: FontWeight.w800,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .onLimeCta,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w800,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    showLoadingIndicator: false,
                                  ),
                                ),
                            ].divide(SizedBox(width: 10.0)),
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
    );
  }
}
