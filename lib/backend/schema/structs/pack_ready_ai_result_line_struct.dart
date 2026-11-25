// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyAiResultLine
class PackReadyAiResultLineStruct extends FFFirebaseStruct {
  PackReadyAiResultLineStruct({
    /// PackReadyAiResultLine.kind
    String? kind,

    /// PackReadyAiResultLine.text
    String? text,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _kind = kind,
        _text = text,
        super(firestoreUtilData);

  // "kind" field.
  String? _kind;
  String get kind => _kind ?? '';
  set kind(String? val) => _kind = val;

  bool hasKind() => _kind != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  static PackReadyAiResultLineStruct fromMap(Map<String, dynamic> data) =>
      PackReadyAiResultLineStruct(
        kind: data['kind'] as String?,
        text: data['text'] as String?,
      );

  static PackReadyAiResultLineStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyAiResultLineStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'kind': _kind,
        'text': _text,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'kind': serializeParam(
          _kind,
          ParamType.String,
        ),
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
      }.withoutNulls;

  static PackReadyAiResultLineStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyAiResultLineStruct(
        kind: deserializeParam(
          data['kind'],
          ParamType.String,
          false,
        ),
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PackReadyAiResultLineStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackReadyAiResultLineStruct &&
        kind == other.kind &&
        text == other.text;
  }

  @override
  int get hashCode => const ListEquality().hash([kind, text]);
}

PackReadyAiResultLineStruct createPackReadyAiResultLineStruct({
  String? kind,
  String? text,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyAiResultLineStruct(
      kind: kind,
      text: text,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyAiResultLineStruct? updatePackReadyAiResultLineStruct(
  PackReadyAiResultLineStruct? packReadyAiResultLine, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyAiResultLine
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyAiResultLineStructData(
  Map<String, dynamic> firestoreData,
  PackReadyAiResultLineStruct? packReadyAiResultLine,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyAiResultLine == null) {
    return;
  }
  if (packReadyAiResultLine.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyAiResultLine.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyAiResultLineData = getPackReadyAiResultLineFirestoreData(
      packReadyAiResultLine, forFieldValue);
  final nestedData =
      packReadyAiResultLineData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyAiResultLine.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyAiResultLineFirestoreData(
  PackReadyAiResultLineStruct? packReadyAiResultLine, [
  bool forFieldValue = false,
]) {
  if (packReadyAiResultLine == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyAiResultLine.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyAiResultLine.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyAiResultLineListFirestoreData(
  List<PackReadyAiResultLineStruct>? packReadyAiResultLines,
) =>
    packReadyAiResultLines
        ?.map((e) => getPackReadyAiResultLineFirestoreData(e, true))
        .toList() ??
    [];
