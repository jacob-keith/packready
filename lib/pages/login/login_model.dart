import '/components/google_signin_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';

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
