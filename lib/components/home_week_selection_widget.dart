import '/components/home_timeline_week_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_week_selection_model.dart';
export 'home_week_selection_model.dart';

class HomeWeekSelectionWidget extends StatefulWidget {
  const HomeWeekSelectionWidget({
    super.key,
    this.openTrip,
  });

  final Future Function(int tripIndex)? openTrip;

  @override
  State<HomeWeekSelectionWidget> createState() =>
      _HomeWeekSelectionWidgetState();
}

class _HomeWeekSelectionWidgetState extends State<HomeWeekSelectionWidget> {
  late HomeWeekSelectionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeWeekSelectionModel());

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
      model: _model.homeTimelineWeekModel,
      updateCallback: () => safeSetState(() {}),
      child: HomeTimelineWeekWidget(
        key: ValueKey(FFAppState().homeCarouselAnchor),
        openTrip: (tripIndex) async {
          logFirebaseEvent('HOME_WEEK_SELECTION_HomeTimelineWeek_CAL');
          await widget.openTrip?.call(
            tripIndex,
          );
        },
      ),
    );
  }
}
