// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyReminderWriteResult
class PackReadyReminderWriteResultStruct extends FFFirebaseStruct {
  PackReadyReminderWriteResultStruct({
    /// PackReadyReminderWriteResult.status
    String? status,

    /// PackReadyReminderWriteResult.date
    DateTime? date,

    /// PackReadyReminderWriteResult.note
    String? note,

    /// PackReadyReminderWriteResult.message
    String? message,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _status = status,
        _date = date,
        _note = note,
        _message = message,
        super(firestoreUtilData);

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  set note(String? val) => _note = val;

  bool hasNote() => _note != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  static PackReadyReminderWriteResultStruct fromMap(
          Map<String, dynamic> data) =>
      PackReadyReminderWriteResultStruct(
        status: data['status'] as String?,
        date: data['date'] as DateTime?,
        note: data['note'] as String?,
        message: data['message'] as String?,
      );

  static PackReadyReminderWriteResultStruct? maybeFromMap(dynamic data) => data
          is Map
      ? PackReadyReminderWriteResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'status': _status,
        'date': _date,
        'note': _note,
        'message': _message,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'note': serializeParam(
          _note,
          ParamType.String,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
      }.withoutNulls;

  static PackReadyReminderWriteResultStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyReminderWriteResultStruct(
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        note: deserializeParam(
          data['note'],
          ParamType.String,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PackReadyReminderWriteResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackReadyReminderWriteResultStruct &&
        status == other.status &&
        date == other.date &&
        note == other.note &&
        message == other.message;
  }

  @override
  int get hashCode => const ListEquality().hash([status, date, note, message]);
}

PackReadyReminderWriteResultStruct createPackReadyReminderWriteResultStruct({
  String? status,
  DateTime? date,
  String? note,
  String? message,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyReminderWriteResultStruct(
      status: status,
      date: date,
      note: note,
      message: message,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyReminderWriteResultStruct? updatePackReadyReminderWriteResultStruct(
  PackReadyReminderWriteResultStruct? packReadyReminderWriteResult, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyReminderWriteResult
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyReminderWriteResultStructData(
  Map<String, dynamic> firestoreData,
  PackReadyReminderWriteResultStruct? packReadyReminderWriteResult,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyReminderWriteResult == null) {
    return;
  }
  if (packReadyReminderWriteResult.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyReminderWriteResult.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyReminderWriteResultData =
      getPackReadyReminderWriteResultFirestoreData(
          packReadyReminderWriteResult, forFieldValue);
  final nestedData = packReadyReminderWriteResultData
      .map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyReminderWriteResult.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyReminderWriteResultFirestoreData(
  PackReadyReminderWriteResultStruct? packReadyReminderWriteResult, [
  bool forFieldValue = false,
]) {
  if (packReadyReminderWriteResult == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyReminderWriteResult.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyReminderWriteResult.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyReminderWriteResultListFirestoreData(
  List<PackReadyReminderWriteResultStruct>? packReadyReminderWriteResults,
) =>
    packReadyReminderWriteResults
        ?.map((e) => getPackReadyReminderWriteResultFirestoreData(e, true))
        .toList() ??
    [];
