// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Struct CityLookupResult
class CityLookupResultStruct extends FFFirebaseStruct {
  CityLookupResultStruct({
    /// CityLookupResult.message
    String? message,

    /// CityLookupResult.retryLabel
    String? retryLabel,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _message = message,
        _retryLabel = retryLabel,
        super(firestoreUtilData);

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "retryLabel" field.
  String? _retryLabel;
  String get retryLabel => _retryLabel ?? '';
  set retryLabel(String? val) => _retryLabel = val;

  bool hasRetryLabel() => _retryLabel != null;

  static CityLookupResultStruct fromMap(Map<String, dynamic> data) =>
      CityLookupResultStruct(
        message: data['message'] as String?,
        retryLabel: data['retryLabel'] as String?,
      );

  static CityLookupResultStruct? maybeFromMap(dynamic data) => data is Map
      ? CityLookupResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'message': _message,
        'retryLabel': _retryLabel,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'retryLabel': serializeParam(
          _retryLabel,
          ParamType.String,
        ),
      }.withoutNulls;

  static CityLookupResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CityLookupResultStruct(
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        retryLabel: deserializeParam(
          data['retryLabel'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CityLookupResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CityLookupResultStruct &&
        message == other.message &&
        retryLabel == other.retryLabel;
  }

  @override
  int get hashCode => const ListEquality().hash([message, retryLabel]);
}

CityLookupResultStruct createCityLookupResultStruct({
  String? message,
  String? retryLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CityLookupResultStruct(
      message: message,
      retryLabel: retryLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CityLookupResultStruct? updateCityLookupResultStruct(
  CityLookupResultStruct? cityLookupResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    cityLookupResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCityLookupResultStructData(
  Map<String, dynamic> firestoreData,
  CityLookupResultStruct? cityLookupResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (cityLookupResult == null) {
    return;
  }
  if (cityLookupResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && cityLookupResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final cityLookupResultData =
      getCityLookupResultFirestoreData(cityLookupResult, forFieldValue);
  final nestedData =
      cityLookupResultData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = cityLookupResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCityLookupResultFirestoreData(
  CityLookupResultStruct? cityLookupResult, [
  bool forFieldValue = false,
]) {
  if (cityLookupResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(cityLookupResult.toMap());

  // Add any Firestore field values
  mapToFirestore(cityLookupResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCityLookupResultListFirestoreData(
  List<CityLookupResultStruct>? cityLookupResults,
) =>
    cityLookupResults
        ?.map((e) => getCityLookupResultFirestoreData(e, true))
        .toList() ??
    [];
