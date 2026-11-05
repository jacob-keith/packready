import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'checklist_widget_model.dart';
export 'checklist_widget_model.dart';

class ChecklistWidgetWidget extends StatefulWidget {
  const ChecklistWidgetWidget({
    super.key,
    this.activity,
  });

  final String? activity;

  @override
  State<ChecklistWidgetWidget> createState() => _ChecklistWidgetWidgetState();
}

class _ChecklistWidgetWidgetState extends State<ChecklistWidgetWidget> {
  late ChecklistWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChecklistWidgetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChecklistTemplatesRecord>>(
      stream: queryChecklistTemplatesRecord(
        parent: currentUserReference,
        queryBuilder: (checklistTemplatesRecord) =>
            checklistTemplatesRecord.where(
          'activity',
          isEqualTo: widget.activity,
        ),
        limit: 1,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        List<ChecklistTemplatesRecord> gymGroupChecklistTemplatesRecordList =
            snapshot.data!;

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(gymGroupChecklistTemplatesRecordList.length,
              (gymGroupIndex) {
            final gymGroupChecklistTemplatesRecord =
                gymGroupChecklistTemplatesRecordList[gymGroupIndex];
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: (FFCrossAxisAlignment.start).flutterValue,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 4.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.activity,
                      'activity',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                StreamBuilder<List<ChecklistTemplatesRecord>>(
                  stream: queryChecklistTemplatesRecord(
                    parent: currentUserReference,
                    queryBuilder: (checklistTemplatesRecord) =>
                        checklistTemplatesRecord.where(
                      'activity',
                      isEqualTo: widget.activity,
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<ChecklistTemplatesRecord>
                        checklistListChecklistTemplatesRecordList =
                        snapshot.data!;

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          checklistListChecklistTemplatesRecordList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.0),
                      itemBuilder: (context, checklistListIndex) {
                        final checklistListChecklistTemplatesRecord =
                            checklistListChecklistTemplatesRecordList[
                                checklistListIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            logFirebaseEvent(
                                'CHECKLIST_WIDGET_ChecklistRow_ON_TAP');

                            context.pushNamed(
                              ChecklistRunWidget.routeName,
                              queryParameters: {
                                'templateRef': serializeParam(
                                  checklistListChecklistTemplatesRecord
                                      .reference,
                                  ParamType.DocumentReference,
                                ),
                                'runName': serializeParam(
                                  checklistListChecklistTemplatesRecord.name,
                                  ParamType.String,
                                ),
                                'runActivity': serializeParam(
                                  checklistListChecklistTemplatesRecord
                                      .activity,
                                  ParamType.String,
                                ),
                                'runStarter': serializeParam(
                                  checklistListChecklistTemplatesRecord
                                      .starterName,
                                  ParamType.String,
                                ),
                                'runItems': serializeParam(
                                  checklistListChecklistTemplatesRecord.items,
                                  ParamType.DataStruct,
                                  isList: true,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    (FFMainAxisAlignment.spaceBetween)
                                        .flutterValue,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        (FFCrossAxisAlignment.start)
                                            .flutterValue,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        checklistListChecklistTemplatesRecord
                                            .name,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Text(
                                        '${checklistListChecklistTemplatesRecord.activity} · ${checklistListChecklistTemplatesRecord.items.length.toString()} items',
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 12.0,
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
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Use ›',
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
                                              .primary,
                                          fontSize: 12.0,
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
              ],
            );
          }),
        );
      },
    );
  }
}
