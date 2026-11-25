import '/backend/schema/structs/index.dart';
import '/components/pack_ready_reminder_editor_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pack_ready_reminder_menu_model.dart';
export 'pack_ready_reminder_menu_model.dart';

/// Native reminder options dialog.
class PackReadyReminderMenuWidget extends StatefulWidget {
  const PackReadyReminderMenuWidget({
    super.key,
    this.listPath,
    this.title,
    this.note,
    this.date,
  });

  final String? listPath;
  final String? title;
  final String? note;
  final DateTime? date;

  @override
  State<PackReadyReminderMenuWidget> createState() =>
      _PackReadyReminderMenuWidgetState();
}

class _PackReadyReminderMenuWidgetState
    extends State<PackReadyReminderMenuWidget> {
  late PackReadyReminderMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PackReadyReminderMenuModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20.0, 16.0, 20.0, 16.0),
      child: Container(
        child: Container(
          width: 280.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: (FFMainAxisAlignment.start).flutterValue,
                crossAxisAlignment: (FFCrossAxisAlignment.stretch).flutterValue,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Reminder options',
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
                    height: 8.0,
                  ),
                  Builder(
                    builder: (context) => FFButtonWidget(
                      onPressed: _model.removing!
                          ? null
                          : () async {
                              logFirebaseEvent(
                                  'PACK_READY_REMINDER_MENU_EditReminderOpt');
                              await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(0.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: PackReadyReminderEditorWidget(
                                      listPath: widget!.listPath,
                                      title: widget!.title,
                                      editing: true,
                                      initialDate: widget!.date,
                                      initialNote: widget!.note,
                                    ),
                                  );
                                },
                              );

                              Navigator.pop(context);
                            },
                      text: 'Edit',
                      options: FFButtonOptions(
                        height: 44.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: _model.removing!
                        ? null
                        : () async {
                            logFirebaseEvent(
                                'PACK_READY_REMINDER_MENU_RemoveReminderO');
                            _model.removing = true;
                            safeSetState(() {});
                            _model.removedReminder =
                                await actions.writePackReadyReminder(
                              'remove',
                              widget!.listPath,
                              null,
                              '',
                            );
                            if (_model.removedReminder?.status == 'error') {
                              _model.removing = false;
                              safeSetState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _model.removedReminder!.message,
                                    style: TextStyle(),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                            }

                            safeSetState(() {});
                          },
                    text: 'Remove reminder',
                    options: FFButtonOptions(
                      height: 44.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).error,
                      ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: _model.removing!
                        ? null
                        : () async {
                            logFirebaseEvent(
                                'PACK_READY_REMINDER_MENU_CancelReminderM');
                            Navigator.pop(context);
                          },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      height: 44.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: TextStyle(
                        color: FlutterFlowTheme.of(context).primaryText,
                      ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
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
