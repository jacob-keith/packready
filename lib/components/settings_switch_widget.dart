import '/components/switch_component4_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'settings_switch_model.dart';
export 'settings_switch_model.dart';

class SettingsSwitchWidget extends StatefulWidget {
  const SettingsSwitchWidget({
    super.key,
    bool? active,
    this.icon,
    String? label,
    bool? isLast,
    required this.onReminderToggle,
  })  : this.active = active ?? true,
        this.label = label ?? 'Daily Reminders',
        this.isLast = isLast ?? false;

  final bool active;
  final Widget? icon;
  final String label;
  final bool isLast;
  final Future Function()? onReminderToggle;

  @override
  State<SettingsSwitchWidget> createState() => _SettingsSwitchWidgetState();
}

class _SettingsSwitchWidgetState extends State<SettingsSwitchWidget> {
  late SettingsSwitchModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsSwitchModel());

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
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).alternate,
                  borderRadius: BorderRadius.circular(8.0),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0.0, 0.0),
                child: widget!.icon!,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  valueOrDefault<String>(
                    widget!.label,
                    'Daily Reminders',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        lineHeight: 1.6,
                      ),
                ),
              ),
              wrapWithModel(
                model: _model.switchModel,
                updateCallback: () => safeSetState(() {}),
                child: SwitchComponent4Widget(
                  label: '',
                  labelPresent: false,
                  variant: 'iOS',
                  active: valueOrDefault<bool>(
                    widget!.active,
                    true,
                  ),
                  onToggle: () async {
                    logFirebaseEvent('SETTINGS_SWITCH_COMP_Switch_CALLBACK');
                    await widget.onReminderToggle?.call();
                  },
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
        if (valueOrDefault<bool>(
          valueOrDefault<bool>(
            widget!.isLast,
            false,
          )
              ? false
              : true,
          true,
        ))
          Divider(
            height: 16.0,
            thickness: 1.0,
            indent: 52.0,
            endIndent: 0.0,
            color: FlutterFlowTheme.of(context).alternate,
          ),
      ],
    );
  }
}
