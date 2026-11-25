// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyAiVoiceResult
class PackReadyAiVoiceResultStruct extends FFFirebaseStruct {
  PackReadyAiVoiceResultStruct({
    /// PackReadyAiVoiceResult.transcript
    String? transcript,

    /// PackReadyAiVoiceResult.error
    String? error,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _transcript = transcript,
        _error = error,
        super(firestoreUtilData);

  // "transcript" field.
  String? _transcript;
  String get transcript => _transcript ?? '';
  set transcript(String? val) => _transcript = val;

  bool hasTranscript() => _transcript != null;

  // "error" field.
  String? _error;
  String get error => _error ?? '';
  set error(String? val) => _error = val;

  bool hasError() => _error != null;

  static PackReadyAiVoiceResultStruct fromMap(Map<String, dynamic> data) =>
      PackReadyAiVoiceResultStruct(
        transcript: data['transcript'] as String?,
        error: data['error'] as String?,
      );

  static PackReadyAiVoiceResultStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyAiVoiceResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'transcript': _transcript,
        'error': _error,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'transcript': serializeParam(
          _transcript,
          ParamType.String,
        ),
        'error': serializeParam(
          _error,
          ParamType.String,
        ),
      }.withoutNulls;

  static PackReadyAiVoiceResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyAiVoiceResultStruct(
        transcript: deserializeParam(
          data['transcript'],
          ParamType.String,
          false,
        ),
        error: deserializeParam(
          data['error'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PackReadyAiVoiceResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackReadyAiVoiceResultStruct &&
        transcript == other.transcript &&
        error == other.error;
  }

  @override
  int get hashCode => const ListEquality().hash([transcript, error]);
}

PackReadyAiVoiceResultStruct createPackReadyAiVoiceResultStruct({
  String? transcript,
  String? error,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyAiVoiceResultStruct(
      transcript: transcript,
      error: error,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyAiVoiceResultStruct? updatePackReadyAiVoiceResultStruct(
  PackReadyAiVoiceResultStruct? packReadyAiVoiceResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyAiVoiceResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyAiVoiceResultStructData(
  Map<String, dynamic> firestoreData,
  PackReadyAiVoiceResultStruct? packReadyAiVoiceResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyAiVoiceResult == null) {
    return;
  }
  if (packReadyAiVoiceResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyAiVoiceResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyAiVoiceResultData = getPackReadyAiVoiceResultFirestoreData(
      packReadyAiVoiceResult, forFieldValue);
  final nestedData =
      packReadyAiVoiceResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyAiVoiceResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyAiVoiceResultFirestoreData(
  PackReadyAiVoiceResultStruct? packReadyAiVoiceResult, [
  bool forFieldValue = false,
]) {
  if (packReadyAiVoiceResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyAiVoiceResult.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyAiVoiceResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyAiVoiceResultListFirestoreData(
  List<PackReadyAiVoiceResultStruct>? packReadyAiVoiceResults,
) =>
    packReadyAiVoiceResults
        ?.map((e) => getPackReadyAiVoiceResultFirestoreData(e, true))
        .toList() ??
    [];
