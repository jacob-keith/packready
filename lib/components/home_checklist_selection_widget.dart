import '/components/home_timeline_checklist_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_checklist_selection_model.dart';
export 'home_checklist_selection_model.dart';

class HomeChecklistSelectionWidget extends StatefulWidget {
  const HomeChecklistSelectionWidget({super.key});

  @override
  State<HomeChecklistSelectionWidget> createState() =>
      _HomeChecklistSelectionWidgetState();
}

class _HomeChecklistSelectionWidgetState
    extends State<HomeChecklistSelectionWidget> {
  late HomeChecklistSelectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeChecklistSelectionModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return wrapWithModel(
      model: _model.homeTimelineChecklistModel,
      updateCallback: () => safeSetState(() {}),
      child: HomeTimelineChecklistWidget(
        key: ValueKey(FFAppState().homeCarouselAnchor),
      ),
    );
  }
}
