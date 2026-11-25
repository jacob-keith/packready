// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Display fields for a saved packing list.
class HistoryTripStruct extends FFFirebaseStruct {
  HistoryTripStruct({
    /// HistoryTrip.listRef
    DocumentReference? listRef,

    /// HistoryTrip.title
    String? title,

    /// HistoryTrip.activity
    String? activity,

    /// HistoryTrip.details
    String? details,

    /// HistoryTrip.itemCount
    int? itemCount,

    /// HistoryTrip.progress
    String? progress,

    /// HistoryTrip.complete
    bool? complete,

    /// HistoryTrip.status
    String? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _listRef = listRef,
        _title = title,
        _activity = activity,
        _details = details,
        _itemCount = itemCount,
        _progress = progress,
        _complete = complete,
        _status = status,
        super(firestoreUtilData);

  // "listRef" field.
  DocumentReference? _listRef;
  DocumentReference? get listRef => _listRef;
  set listRef(DocumentReference? val) => _listRef = val;

  bool hasListRef() => _listRef != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  set activity(String? val) => _activity = val;

  bool hasActivity() => _activity != null;

  // "details" field.
  String? _details;
  String get details => _details ?? '';
  set details(String? val) => _details = val;

  bool hasDetails() => _details != null;

  // "itemCount" field.
  int? _itemCount;
  int get itemCount => _itemCount ?? 0;
  set itemCount(int? val) => _itemCount = val;

  void incrementItemCount(int amount) => itemCount = itemCount + amount;

  bool hasItemCount() => _itemCount != null;

  // "progress" field.
  String? _progress;
  String get progress => _progress ?? '';
  set progress(String? val) => _progress = val;

  bool hasProgress() => _progress != null;

  // "complete" field.
  bool? _complete;
  bool get complete => _complete ?? false;
  set complete(bool? val) => _complete = val;

  bool hasComplete() => _complete != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static HistoryTripStruct fromMap(Map<String, dynamic> data) =>
      HistoryTripStruct(
        listRef: data['listRef'] as DocumentReference?,
        title: data['title'] as String?,
        activity: data['activity'] as String?,
        details: data['details'] as String?,
        itemCount: castToType<int>(data['itemCount']),
        progress: data['progress'] as String?,
        complete: data['complete'] as bool?,
        status: data['status'] as String?,
      );

  static HistoryTripStruct? maybeFromMap(dynamic data) => data is Map
      ? HistoryTripStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'listRef': _listRef,
        'title': _title,
        'activity': _activity,
        'details': _details,
        'itemCount': _itemCount,
        'progress': _progress,
        'complete': _complete,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'listRef': serializeParam(
          _listRef,
          ParamType.DocumentReference,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'activity': serializeParam(
          _activity,
          ParamType.String,
        ),
        'details': serializeParam(
          _details,
          ParamType.String,
        ),
        'itemCount': serializeParam(
          _itemCount,
          ParamType.int,
        ),
        'progress': serializeParam(
          _progress,
          ParamType.String,
        ),
        'complete': serializeParam(
          _complete,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static HistoryTripStruct fromSerializableMap(Map<String, dynamic> data) =>
      HistoryTripStruct(
        listRef: deserializeParam(
          data['listRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users', 'packingLists'],
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        activity: deserializeParam(
          data['activity'],
          ParamType.String,
          false,
        ),
        details: deserializeParam(
          data['details'],
          ParamType.String,
          false,
        ),
        itemCount: deserializeParam(
          data['itemCount'],
          ParamType.int,
          false,
        ),
        progress: deserializeParam(
          data['progress'],
          ParamType.String,
          false,
        ),
        complete: deserializeParam(
          data['complete'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'HistoryTripStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HistoryTripStruct &&
        listRef == other.listRef &&
        title == other.title &&
        activity == other.activity &&
        details == other.details &&
        itemCount == other.itemCount &&
        progress == other.progress &&
        complete == other.complete &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash([
        listRef,
        title,
        activity,
        details,
        itemCount,
        progress,
        complete,
        status
      ]);
}

HistoryTripStruct createHistoryTripStruct({
  DocumentReference? listRef,
  String? title,
  String? activity,
  String? details,
  int? itemCount,
  String? progress,
  bool? complete,
  String? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HistoryTripStruct(
      listRef: listRef,
      title: title,
      activity: activity,
      details: details,
      itemCount: itemCount,
      progress: progress,
      complete: complete,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HistoryTripStruct? updateHistoryTripStruct(
  HistoryTripStruct? historyTrip, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    historyTrip
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHistoryTripStructData(
  Map<String, dynamic> firestoreData,
  HistoryTripStruct? historyTrip,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (historyTrip == null) {
    return;
  }
  if (historyTrip.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && historyTrip.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final historyTripData =
      getHistoryTripFirestoreData(historyTrip, forFieldValue);
  final nestedData =
      historyTripData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = historyTrip.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHistoryTripFirestoreData(
  HistoryTripStruct? historyTrip, [
  bool forFieldValue = false,
]) {
  if (historyTrip == null) {
    return {};
  }
  final firestoreData = mapToFirestore(historyTrip.toMap());

  // Add any Firestore field values
  mapToFirestore(historyTrip.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHistoryTripListFirestoreData(
  List<HistoryTripStruct>? historyTrips,
) =>
    historyTrips?.map((e) => getHistoryTripFirestoreData(e, true)).toList() ??
    [];
