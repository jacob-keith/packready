import '/components/button3_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'pricing_card_widget.dart' show PricingCardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PricingCardModel extends FlutterFlowModel<PricingCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late Button3Model buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => Button3Model());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
