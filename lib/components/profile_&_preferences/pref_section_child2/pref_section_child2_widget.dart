import '/components/profile_&_preferences/switch_component3/switch_component3_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pref_section_child2_model.dart';
export 'pref_section_child2_model.dart';

class PrefSectionChild2Widget extends StatefulWidget {
  const PrefSectionChild2Widget({super.key});

  @override
  State<PrefSectionChild2Widget> createState() =>
      _PrefSectionChild2WidgetState();
}

class _PrefSectionChild2WidgetState extends State<PrefSectionChild2Widget> {
  late PrefSectionChild2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrefSectionChild2Model());

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
        wrapWithModel(
          model: _model.switchModel1,
          updateCallback: () => safeSetState(() {}),
          child: SwitchComponent3Widget(
            label: 'Temperature in Celsius (°C)',
            labelPresent: true,
            variant: 'Android',
            active: false,
          ),
        ),
        wrapWithModel(
          model: _model.switchModel2,
          updateCallback: () => safeSetState(() {}),
          child: SwitchComponent3Widget(
            label: 'Enable Smart Reminders',
            labelPresent: true,
            variant: 'Android',
            active: true,
          ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
