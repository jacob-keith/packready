import '/auth/base_auth_user_provider.dart';
import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/components/pack_ready_reminder_editor_widget.dart';
import '/components/pack_ready_reminder_menu_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'reminders_page_widget.dart' show RemindersPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class RemindersPageModel extends FlutterFlowModel<RemindersPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - writePackReadyReminder] action in AddSuggestionButton widget.
  PackReadyReminderWriteResultStruct? reminderSaveResult;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    packReadyTabBarModel.dispose();
  }
}
