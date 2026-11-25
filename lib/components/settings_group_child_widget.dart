import '/components/settings_item_widget.dart';
import '/components/settings_switch_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'settings_group_child_model.dart';
export 'settings_group_child_model.dart';

class SettingsGroupChildWidget extends StatefulWidget {
  const SettingsGroupChildWidget({
    super.key,
    this.onReminderToggle,
    bool? remindersActive,
  }) : this.remindersActive = remindersActive ?? true;

  final Future Function()? onReminderToggle;
  final bool remindersActive;

  @override
  State<SettingsGroupChildWidget> createState() =>
      _SettingsGroupChildWidgetState();
}

class _SettingsGroupChildWidgetState extends State<SettingsGroupChildWidget> {
  late SettingsGroupChildModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsGroupChildModel());

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
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            logFirebaseEvent('SETTINGS_GROUP_CHILD_SettingsItem_ON_TAP');

            context.pushNamed(SubscriptionPlansWidget.routeName);
          },
          child: wrapWithModel(
            model: _model.settingsItemModel,
            updateCallback: () => safeSetState(() {}),
            child: SettingsItemWidget(
              icon: Icon(
                Icons.card_membership_rounded,
                color: FlutterFlowTheme.of(context).primary,
                size: 18.0,
              ),
              iconColor: FlutterFlowTheme.of(context).alternate,
              label: 'Subscription Plan',
              value: 'empty',
              isLast: false,
            ),
          ),
        ),
        wrapWithModel(
          model: _model.settingsSwitchModel1,
          updateCallback: () => safeSetState(() {}),
          child: SettingsSwitchWidget(
            active: widget!.remindersActive,
            icon: Icon(
              Icons.notifications_active_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 18.0,
            ),
            label: 'Daily Reminders',
            isLast: false,
            onReminderToggle: () async {
              logFirebaseEvent('SETTINGS_GROUP_CHILD_SettingsSwitch_CALL');
              await widget.onReminderToggle?.call();
            },
          ),
        ),
        wrapWithModel(
          model: _model.settingsSwitchModel2,
          updateCallback: () => safeSetState(() {}),
          child: SettingsSwitchWidget(
            active: Theme.of(context).brightness == Brightness.dark,
            icon: Icon(
              Icons.dark_mode_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 18.0,
            ),
            label: 'Dark Mode',
            isLast: true,
            onReminderToggle: () async {
              logFirebaseEvent('SETTINGS_GROUP_CHILD_SettingsSwitch_CALL');
              if (Theme.of(context).brightness == Brightness.dark) {
                setDarkModeSetting(context, ThemeMode.light);
              } else {
                setDarkModeSetting(context, ThemeMode.dark);
              }
            },
          ),
        ),
      ],
    );
  }
}
