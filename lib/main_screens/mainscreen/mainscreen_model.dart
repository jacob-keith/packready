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
import 'mainscreen_widget.dart' show MainscreenWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class MainscreenModel extends FlutterFlowModel<MainscreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Dark Mode Profile Header.
  late PackHeaderModel darkModeProfileHeaderModel;
  // Model for HomeWeekSelection.
  late HomeWeekSelectionModel homeWeekSelectionModel;
  // State field(s) for HomeTripCarousel widget.
  CarouselSliderController? homeTripCarouselController;
  int homeTripCarouselCurrentIndex = 0;

  // Model for HomeChecklistSelection.
  late HomeChecklistSelectionModel homeChecklistSelectionModel;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    darkModeProfileHeaderModel = createModel(context, () => PackHeaderModel());
    homeWeekSelectionModel =
        createModel(context, () => HomeWeekSelectionModel());
    homeChecklistSelectionModel =
        createModel(context, () => HomeChecklistSelectionModel());
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    darkModeProfileHeaderModel.dispose();
    homeWeekSelectionModel.dispose();
    homeChecklistSelectionModel.dispose();
    packReadyTabBarModel.dispose();
  }
}
