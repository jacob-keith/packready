// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioList
class CalendarStudioListStruct extends FFFirebaseStruct {
  CalendarStudioListStruct({
    /// CalendarStudioList.title
    String? title,

    /// CalendarStudioList.path
    String? path,

    /// CalendarStudioList.progress
    String? progress,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _path = path,
        _progress = progress,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "progress" field.
  String? _progress;
  String get progress => _progress ?? '';
  set progress(String? val) => _progress = val;

  bool hasProgress() => _progress != null;

  static CalendarStudioListStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioListStruct(
        title: data['title'] as String?,
        path: data['path'] as String?,
        progress: data['progress'] as String?,
      );

  static CalendarStudioListStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'path': _path,
        'progress': _progress,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'progress': serializeParam(
          _progress,
          ParamType.String,
        ),
      }.withoutNulls;

  static CalendarStudioListStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioListStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        progress: deserializeParam(
          data['progress'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CalendarStudioListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalendarStudioListStruct &&
        title == other.title &&
        path == other.path &&
        progress == other.progress;
  }

  @override
  int get hashCode => const ListEquality().hash([title, path, progress]);
}

CalendarStudioListStruct createCalendarStudioListStruct({
  String? title,
  String? path,
  String? progress,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioListStruct(
      title: title,
      path: path,
      progress: progress,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioListStruct? updateCalendarStudioListStruct(
  CalendarStudioListStruct? calendarStudioList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioListStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioListStruct? calendarStudioList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioList == null) {
    return;
  }
  if (calendarStudioList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioListData =
      getCalendarStudioListFirestoreData(calendarStudioList, forFieldValue);
  final nestedData =
      calendarStudioListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioListFirestoreData(
  CalendarStudioListStruct? calendarStudioList, [
  bool forFieldValue = false,
]) {
  if (calendarStudioList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioList.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioList.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioListListFirestoreData(
  List<CalendarStudioListStruct>? calendarStudioLists,
) =>
    calendarStudioLists
        ?.map((e) => getCalendarStudioListFirestoreData(e, true))
        .toList() ??
    [];
