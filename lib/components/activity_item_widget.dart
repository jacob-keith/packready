import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'activity_item_model.dart';
export 'activity_item_model.dart';

class ActivityItemWidget extends StatefulWidget {
  const ActivityItemWidget({
    super.key,
    this.icon,
    String? subtitle,
    String? title,
    bool? last,
  })  : this.subtitle = subtitle ?? 'Packed 18 items • 2 days ago',
        this.title = title ?? 'Summit Trail',
        this.last = last ?? false;

  final Widget? icon;
  final String subtitle;
  final String title;
  final bool last;

  @override
  State<ActivityItemWidget> createState() => _ActivityItemWidgetState();
}

class _ActivityItemWidgetState extends State<ActivityItemWidget> {
  late ActivityItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ActivityItemModel());

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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: widget.icon!,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.title,
                        'Summit Trail',
                      ),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .fontStyle,
                            lineHeight: 1.6,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.subtitle,
                        'Packed 18 items • 2 days ago',
                      ),
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                            lineHeight: 1.5,
                          ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: FlutterFlowTheme.of(context).accent3,
                size: 20.0,
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
        if (valueOrDefault<bool>(
          valueOrDefault<bool>(
            widget.last,
            false,
          )
              ? false
              : true,
          true,
        ))
          Divider(
            height: 16.0,
            thickness: 1.0,
            indent: 56.0,
            endIndent: 0.0,
            color: FlutterFlowTheme.of(context).alternate,
          ),
      ],
    );
  }
}
