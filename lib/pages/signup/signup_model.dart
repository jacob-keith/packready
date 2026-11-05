import '/components/google_signin_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'signup_widget.dart' show SignupWidget;
import 'package:flutter/material.dart';

class SignupModel extends FlutterFlowModel<SignupWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for txt_Email widget.
  FocusNode? txtEmailFocusNode;
  TextEditingController? txtEmailTextController;
  String? Function(BuildContext, String?)? txtEmailTextControllerValidator;
  // State field(s) for txt_password widget.
  FocusNode? txtPasswordFocusNode;
  TextEditingController? txtPasswordTextController;
  String? Function(BuildContext, String?)? txtPasswordTextControllerValidator;
  String? _txtPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }

    if (val.length < 7) {
      return 'Password must be at least 7 character long.';
    }

    if (!RegExp('^(?=.*\\d)(?=.*[\\W_]).{8,}\$').hasMatch(val)) {
      return 'please enter a password that requires at least 8 characters, at least one number, and at least one special character';
    }
    return null;
  }

  // State field(s) for txt_confirmpassword widget.
  FocusNode? txtConfirmpasswordFocusNode;
  TextEditingController? txtConfirmpasswordTextController;
  String? Function(BuildContext, String?)?
      txtConfirmpasswordTextControllerValidator;
  String? _txtConfirmpasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please Confirm Password';
    }

    if (!RegExp('^(?=.*\\d)(?=.*[\\W_]).{8,}\$').hasMatch(val)) {
      return 'please enter a password that requires at least 8 characters, at least one number, and at least one special character';
    }
    return null;
  }

  // Model for google_signin_button component.
  late GoogleSigninButtonModel googleSigninButtonModel;

  @override
  void initState(BuildContext context) {
    txtPasswordTextControllerValidator = _txtPasswordTextControllerValidator;
    txtConfirmpasswordTextControllerValidator =
        _txtConfirmpasswordTextControllerValidator;
    googleSigninButtonModel =
        createModel(context, () => GoogleSigninButtonModel());
  }

  @override
  void dispose() {
    txtEmailFocusNode?.dispose();
    txtEmailTextController?.dispose();

    txtPasswordFocusNode?.dispose();
    txtPasswordTextController?.dispose();

    txtConfirmpasswordFocusNode?.dispose();
    txtConfirmpasswordTextController?.dispose();

    googleSigninButtonModel.dispose();
  }
}
