import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'pack_ready_ai_tutorial_widget.dart' show PackReadyAiTutorialWidget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PackReadyAiTutorialModel
    extends FlutterFlowModel<PackReadyAiTutorialWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for AiTutorialSlides widget.
  PageController? aiTutorialSlidesController;

  int get aiTutorialSlidesCurrentIndex => aiTutorialSlidesController != null &&
          aiTutorialSlidesController!.hasClients &&
          aiTutorialSlidesController!.page != null
      ? aiTutorialSlidesController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
