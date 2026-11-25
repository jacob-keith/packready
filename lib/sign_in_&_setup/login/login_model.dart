import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/sign_in_&_setup/google_signin_button/google_signin_button_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for txt_login_email widget.
  FocusNode? txtLoginEmailFocusNode;
  TextEditingController? txtLoginEmailTextController;
  String? Function(BuildContext, String?)? txtLoginEmailTextControllerValidator;
  String? _txtLoginEmailTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter email is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Invalid Email';
    }
    return null;
  }

  // State field(s) for txt_login_password widget.
  late FocusNode txtLoginPasswordPasswordVisibilityFocusNode;
  FocusNode? txtLoginPasswordFocusNode;
  TextEditingController? txtLoginPasswordTextController;
  late bool txtLoginPasswordVisibility;
  String? Function(BuildContext, String?)?
      txtLoginPasswordTextControllerValidator;
  String? _txtLoginPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Enter Password is required';
    }

    return null;
  }

  // Model for google_signin_button component.
  late GoogleSigninButtonModel googleSigninButtonModel;

  @override
  void initState(BuildContext context) {
    txtLoginEmailTextControllerValidator =
        _txtLoginEmailTextControllerValidator;
    txtLoginPasswordPasswordVisibilityFocusNode = FocusNode();
    txtLoginPasswordVisibility = false;
    txtLoginPasswordTextControllerValidator =
        _txtLoginPasswordTextControllerValidator;
    googleSigninButtonModel =
        createModel(context, () => GoogleSigninButtonModel());
  }

  @override
  void dispose() {
    txtLoginEmailFocusNode?.dispose();
    txtLoginEmailTextController?.dispose();

    txtLoginPasswordFocusNode?.dispose();
    txtLoginPasswordTextController?.dispose();
    txtLoginPasswordPasswordVisibilityFocusNode.dispose();
    googleSigninButtonModel.dispose();
  }
}
