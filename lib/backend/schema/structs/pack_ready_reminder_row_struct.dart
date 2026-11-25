// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyReminderRow
class PackReadyReminderRowStruct extends FFFirebaseStruct {
  PackReadyReminderRowStruct({
    /// PackReadyReminderRow.listRef
    DocumentReference? listRef,

    /// PackReadyReminderRow.listPath
    String? listPath,

    /// PackReadyReminderRow.title
    String? title,

    /// PackReadyReminderRow.detail
    String? detail,

    /// PackReadyReminderRow.note
    String? note,

    /// PackReadyReminderRow.date
    DateTime? date,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _listRef = listRef,
        _listPath = listPath,
        _title = title,
        _detail = detail,
        _note = note,
        _date = date,
        super(firestoreUtilData);

  // "listRef" field.
  DocumentReference? _listRef;
  DocumentReference? get listRef => _listRef;
  set listRef(DocumentReference? val) => _listRef = val;

  bool hasListRef() => _listRef != null;

  // "listPath" field.
  String? _listPath;
  String get listPath => _listPath ?? '';
  set listPath(String? val) => _listPath = val;

  bool hasListPath() => _listPath != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  set detail(String? val) => _detail = val;

  bool hasDetail() => _detail != null;

  // "note" field.
  String? _note;
  String get note => _note ?? '';
  set note(String? val) => _note = val;

  bool hasNote() => _note != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  static PackReadyReminderRowStruct fromMap(Map<String, dynamic> data) =>
      PackReadyReminderRowStruct(
        listRef: data['listRef'] as DocumentReference?,
        listPath: data['listPath'] as String?,
        title: data['title'] as String?,
        detail: data['detail'] as String?,
        note: data['note'] as String?,
        date: data['date'] as DateTime?,
      );

  static PackReadyReminderRowStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyReminderRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'listRef': _listRef,
        'listPath': _listPath,
        'title': _title,
        'detail': _detail,
        'note': _note,
        'date': _date,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'listRef': serializeParam(
          _listRef,
          ParamType.DocumentReference,
        ),
        'listPath': serializeParam(
          _listPath,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'detail': serializeParam(
          _detail,
          ParamType.String,
        ),
        'note': serializeParam(
          _note,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static PackReadyReminderRowStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyReminderRowStruct(
        listRef: deserializeParam(
          data['listRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users', 'packingLists'],
        ),
        listPath: deserializeParam(
          data['listPath'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        detail: deserializeParam(
          data['detail'],
          ParamType.String,
          false,
        ),
        note: deserializeParam(
          data['note'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'PackReadyReminderRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackReadyReminderRowStruct &&
        listRef == other.listRef &&
        listPath == other.listPath &&
        title == other.title &&
        detail == other.detail &&
        note == other.note &&
        date == other.date;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([listRef, listPath, title, detail, note, date]);
}

PackReadyReminderRowStruct createPackReadyReminderRowStruct({
  DocumentReference? listRef,
  String? listPath,
  String? title,
  String? detail,
  String? note,
  DateTime? date,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyReminderRowStruct(
      listRef: listRef,
      listPath: listPath,
      title: title,
      detail: detail,
      note: note,
      date: date,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyReminderRowStruct? updatePackReadyReminderRowStruct(
  PackReadyReminderRowStruct? packReadyReminderRow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyReminderRow
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyReminderRowStructData(
  Map<String, dynamic> firestoreData,
  PackReadyReminderRowStruct? packReadyReminderRow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyReminderRow == null) {
    return;
  }
  if (packReadyReminderRow.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && packReadyReminderRow.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyReminderRowData =
      getPackReadyReminderRowFirestoreData(packReadyReminderRow, forFieldValue);
  final nestedData =
      packReadyReminderRowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyReminderRow.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyReminderRowFirestoreData(
  PackReadyReminderRowStruct? packReadyReminderRow, [
  bool forFieldValue = false,
]) {
  if (packReadyReminderRow == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyReminderRow.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyReminderRow.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyReminderRowListFirestoreData(
  List<PackReadyReminderRowStruct>? packReadyReminderRows,
) =>
    packReadyReminderRows
        ?.map((e) => getPackReadyReminderRowFirestoreData(e, true))
        .toList() ??
    [];
