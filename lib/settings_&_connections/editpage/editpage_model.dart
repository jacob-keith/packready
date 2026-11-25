import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/activity_&_packing/activity_chip/activity_chip_widget.dart';
import '/components/sign_in_&_setup/step_header/step_header_widget.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/index.dart';
import 'editpage_widget.dart' show EditpageWidget;
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditpageModel extends FlutterFlowModel<EditpageWidget> {
  ///  Local state fields for this page.

  List<String> selectedActivities = [];
  void addToSelectedActivities(String item) => selectedActivities.add(item);
  void removeFromSelectedActivities(String item) =>
      selectedActivities.remove(item);
  void removeAtIndexFromSelectedActivities(int index) =>
      selectedActivities.removeAt(index);
  void insertAtIndexInSelectedActivities(int index, String item) =>
      selectedActivities.insert(index, item);
  void updateSelectedActivitiesAtIndex(int index, Function(String) updateFn) =>
      selectedActivities[index] = updateFn(selectedActivities[index]);

  String? uploadedPhoto;

  ///  State fields for stateful widgets in this page.

  // Model for StepHeader.
  late StepHeaderModel stepHeaderModel;
  bool isDataUploading_uploadDataLaz = false;
  FFUploadedFile uploadedLocalFile_uploadDataLaz =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String uploadedFileUrl_uploadDataLaz = '';

  // State field(s) for txt_DisplayName widget.
  FocusNode? txtDisplayNameFocusNode;
  TextEditingController? txtDisplayNameTextController;
  String? Function(BuildContext, String?)?
      txtDisplayNameTextControllerValidator;
  // State field(s) for txt_date_of_birth widget.
  FocusNode? txtDateOfBirthFocusNode;
  TextEditingController? txtDateOfBirthTextController;
  String? Function(BuildContext, String?)?
      txtDateOfBirthTextControllerValidator;
  // State field(s) for drp_Gender widget.
  String? drpGenderValue;
  FormFieldController<String>? drpGenderValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // Model for ActivityChip.
  late ActivityChipModel activityChipModel1;
  // Model for ActivityChip.
  late ActivityChipModel activityChipModel2;
  // Model for ActivityChip.
  late ActivityChipModel activityChipModel3;
  // Model for ActivityChip.
  late ActivityChipModel activityChipModel4;
  // Model for ActivityChip.
  late ActivityChipModel activityChipModel5;
  // Model for ActivityChip.
  late ActivityChipModel activityChipModel6;
  // State field(s) for Dropdown widget.
  String? dropdownValue;
  FormFieldController<String>? dropdownValueController;

  @override
  void initState(BuildContext context) {
    stepHeaderModel = createModel(context, () => StepHeaderModel());
    activityChipModel1 = createModel(context, () => ActivityChipModel());
    activityChipModel2 = createModel(context, () => ActivityChipModel());
    activityChipModel3 = createModel(context, () => ActivityChipModel());
    activityChipModel4 = createModel(context, () => ActivityChipModel());
    activityChipModel5 = createModel(context, () => ActivityChipModel());
    activityChipModel6 = createModel(context, () => ActivityChipModel());
  }

  @override
  void dispose() {
    stepHeaderModel.dispose();
    txtDisplayNameFocusNode?.dispose();
    txtDisplayNameTextController?.dispose();

    txtDateOfBirthFocusNode?.dispose();
    txtDateOfBirthTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController3?.dispose();

    activityChipModel1.dispose();
    activityChipModel2.dispose();
    activityChipModel3.dispose();
    activityChipModel4.dispose();
    activityChipModel5.dispose();
    activityChipModel6.dispose();
  }
}
