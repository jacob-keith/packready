import '/backend/schema/structs/index.dart';
import '/components/navigation/pack_ready_tab_bar/pack_ready_tab_bar_widget.dart';
import '/components/pack_ready_shared_with_you_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'connections_widget.dart' show ConnectionsWidget;
import 'package:aligned_tooltip/aligned_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ConnectionsModel extends FlutterFlowModel<ConnectionsWidget> {
  ///  Local state fields for this page.

  bool? connectionBusy = false;

  String? connectionMessage = '';

  int? connectionSection = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in RetryTag widget.
  String? connectionOperationError;
  // State field(s) for ConnectionSections widget.
  PageController? connectionSectionsController;

  int get connectionSectionsCurrentIndex =>
      connectionSectionsController != null &&
              connectionSectionsController!.hasClients &&
              connectionSectionsController!.page != null
          ? connectionSectionsController!.page!.round()
          : 0;
  // State field(s) for ConnectionTagInput widget.
  FocusNode? connectionTagInputFocusNode;
  TextEditingController? connectionTagInputTextController;
  String? Function(BuildContext, String?)?
      connectionTagInputTextControllerValidator;
  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in ConnectionTagInput widget.
  String? connectionOperationError5;
  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in SendConnectionRequest widget.
  String? connectionOperationError6;
  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in DeclineConnectionRequest widget.
  String? connectionOperationError2;
  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in AcceptConnectionRequest widget.
  String? connectionOperationError3;
  // Stores action output result for [Custom Action - mutatePackReadyConnection] action in CancelConnectionRequest widget.
  String? connectionOperationError4;
  // Model for PackReadyTabBar.
  late PackReadyTabBarModel packReadyTabBarModel;

  @override
  void initState(BuildContext context) {
    packReadyTabBarModel = createModel(context, () => PackReadyTabBarModel());
  }

  @override
  void dispose() {
    connectionTagInputFocusNode?.dispose();
    connectionTagInputTextController?.dispose();

    packReadyTabBarModel.dispose();
  }
}
