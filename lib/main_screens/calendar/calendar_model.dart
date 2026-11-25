import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_styled_border.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'calendar_widget.dart' show CalendarWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CalendarModel extends FlutterFlowModel<CalendarWidget> {
  ///  Local state fields for this page.

  CalendarStudioViewStruct? calendarView;
  void updateCalendarViewStruct(Function(CalendarStudioViewStruct) updateFn) {
    updateFn(calendarView ??= CalendarStudioViewStruct());
  }

  CalendarStudioCardStruct? calendarSelectedCard;
  void updateCalendarSelectedCardStruct(
      Function(CalendarStudioCardStruct) updateFn) {
    updateFn(calendarSelectedCard ??= CalendarStudioCardStruct());
  }

  bool? calendarBusy = false;

  bool? calendarMonth = false;

  bool? calendarSourcesOpen = false;

  bool? calendarDetailsOpen = false;

  String? calendarAppleUrl = '';

  String? calendarAppleName = '';

  String? calendarAppleColor = '';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - calendarStudio] action in Calendar widget.
  CalendarStudioViewStruct? loadedCalendar;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarPrevious widget.
  CalendarStudioViewStruct? previousCalendarPeriod;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarMonthToggle widget.
  CalendarStudioViewStruct? toggledCalendarView;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarNext widget.
  CalendarStudioViewStruct? nextCalendarPeriod;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarToday widget.
  CalendarStudioViewStruct? calendarForToday;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDayAi widget.
  CalendarStudioViewStruct? calendarAfterAiEditor;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDayCell widget.
  CalendarStudioViewStruct? calendarForSelectedDay;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarExpandControl widget.
  CalendarStudioViewStruct? expandedCalendarView;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarReconnect widget.
  CalendarStudioViewStruct? reconnectedCalendar;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarRetry widget.
  CalendarStudioViewStruct? retriedCalendar;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarEventCardContent widget.
  CalendarStudioViewStruct? calendarAfterPackingList;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarEventAi widget.
  CalendarStudioViewStruct? calendarAfterEventDraft;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarSourceDisable widget.
  CalendarStudioViewStruct? calendarWithSourceDisabled;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarSourceEnable widget.
  CalendarStudioViewStruct? calendarWithSourceEnabled;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDisconnectOne widget.
  CalendarStudioViewStruct? calendarAfterDisconnectingSource;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarConnectGoogle widget.
  CalendarStudioViewStruct? calendarAfterConnectingGoogle;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarRefreshSources widget.
  CalendarStudioViewStruct? refreshedCalendars;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDisconnectAll widget.
  CalendarStudioViewStruct? calendarAfterDisconnectingSources;
  // State field(s) for CalendarAppleUrl widget.
  FocusNode? calendarAppleUrlFocusNode;
  TextEditingController? calendarAppleUrlTextController;
  String? Function(BuildContext, String?)?
      calendarAppleUrlTextControllerValidator;
  // State field(s) for CalendarAppleName widget.
  FocusNode? calendarAppleNameFocusNode;
  TextEditingController? calendarAppleNameTextController;
  String? Function(BuildContext, String?)?
      calendarAppleNameTextControllerValidator;
  // State field(s) for CalendarAppleColor widget.
  FocusNode? calendarAppleColorFocusNode;
  TextEditingController? calendarAppleColorTextController;
  String? Function(BuildContext, String?)?
      calendarAppleColorTextControllerValidator;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarConnectApple widget.
  CalendarStudioViewStruct? calendarAfterConnectingApple;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarOpenList widget.
  CalendarStudioViewStruct? calendarAfterLinkedPackingList;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDetailAi widget.
  CalendarStudioViewStruct? calendarAfterDetailsDraft;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDetailCreate widget.
  CalendarStudioViewStruct? calendarAfterCreatingPackingList;
  // Stores action output result for [Custom Action - calendarStudio] action in CalendarDetailSeries widget.
  CalendarStudioViewStruct? calendarAfterEditingSeries;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    calendarAppleUrlFocusNode?.dispose();
    calendarAppleUrlTextController?.dispose();

    calendarAppleNameFocusNode?.dispose();
    calendarAppleNameTextController?.dispose();

    calendarAppleColorFocusNode?.dispose();
    calendarAppleColorTextController?.dispose();

    packReadyTabBarModel.dispose();
  }
}
