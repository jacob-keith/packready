// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct HomeTimelineDay
class HomeTimelineDayStruct extends FFFirebaseStruct {
  HomeTimelineDayStruct({
    /// HomeTimelineDay.weekday
    String? weekday,

    /// HomeTimelineDay.dateLabel
    String? dateLabel,

    /// HomeTimelineDay.tripIndex
    int? tripIndex,

    /// HomeTimelineDay.localOnly
    bool? localOnly,

    /// HomeTimelineDay.status
    String? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _weekday = weekday,
        _dateLabel = dateLabel,
        _tripIndex = tripIndex,
        _localOnly = localOnly,
        _status = status,
        super(firestoreUtilData);

  // "weekday" field.
  String? _weekday;
  String get weekday => _weekday ?? '';
  set weekday(String? val) => _weekday = val;

  bool hasWeekday() => _weekday != null;

  // "dateLabel" field.
  String? _dateLabel;
  String get dateLabel => _dateLabel ?? '';
  set dateLabel(String? val) => _dateLabel = val;

  bool hasDateLabel() => _dateLabel != null;

  // "tripIndex" field.
  int? _tripIndex;
  int get tripIndex => _tripIndex ?? 0;
  set tripIndex(int? val) => _tripIndex = val;

  void incrementTripIndex(int amount) => tripIndex = tripIndex + amount;

  bool hasTripIndex() => _tripIndex != null;

  // "localOnly" field.
  bool? _localOnly;
  bool get localOnly => _localOnly ?? false;
  set localOnly(bool? val) => _localOnly = val;

  bool hasLocalOnly() => _localOnly != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static HomeTimelineDayStruct fromMap(Map<String, dynamic> data) =>
      HomeTimelineDayStruct(
        weekday: data['weekday'] as String?,
        dateLabel: data['dateLabel'] as String?,
        tripIndex: castToType<int>(data['tripIndex']),
        localOnly: data['localOnly'] as bool?,
        status: data['status'] as String?,
      );

  static HomeTimelineDayStruct? maybeFromMap(dynamic data) => data is Map
      ? HomeTimelineDayStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'weekday': _weekday,
        'dateLabel': _dateLabel,
        'tripIndex': _tripIndex,
        'localOnly': _localOnly,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'weekday': serializeParam(
          _weekday,
          ParamType.String,
        ),
        'dateLabel': serializeParam(
          _dateLabel,
          ParamType.String,
        ),
        'tripIndex': serializeParam(
          _tripIndex,
          ParamType.int,
        ),
        'localOnly': serializeParam(
          _localOnly,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static HomeTimelineDayStruct fromSerializableMap(Map<String, dynamic> data) =>
      HomeTimelineDayStruct(
        weekday: deserializeParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
        dateLabel: deserializeParam(
          data['dateLabel'],
          ParamType.String,
          false,
        ),
        tripIndex: deserializeParam(
          data['tripIndex'],
          ParamType.int,
          false,
        ),
        localOnly: deserializeParam(
          data['localOnly'],
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
  String toString() => 'HomeTimelineDayStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HomeTimelineDayStruct &&
        weekday == other.weekday &&
        dateLabel == other.dateLabel &&
        tripIndex == other.tripIndex &&
        localOnly == other.localOnly &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([weekday, dateLabel, tripIndex, localOnly, status]);
}

HomeTimelineDayStruct createHomeTimelineDayStruct({
  String? weekday,
  String? dateLabel,
  int? tripIndex,
  bool? localOnly,
  String? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HomeTimelineDayStruct(
      weekday: weekday,
      dateLabel: dateLabel,
      tripIndex: tripIndex,
      localOnly: localOnly,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HomeTimelineDayStruct? updateHomeTimelineDayStruct(
  HomeTimelineDayStruct? homeTimelineDay, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    homeTimelineDay
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHomeTimelineDayStructData(
  Map<String, dynamic> firestoreData,
  HomeTimelineDayStruct? homeTimelineDay,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (homeTimelineDay == null) {
    return;
  }
  if (homeTimelineDay.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && homeTimelineDay.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final homeTimelineDayData =
      getHomeTimelineDayFirestoreData(homeTimelineDay, forFieldValue);
  final nestedData =
      homeTimelineDayData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = homeTimelineDay.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHomeTimelineDayFirestoreData(
  HomeTimelineDayStruct? homeTimelineDay, [
  bool forFieldValue = false,
]) {
  if (homeTimelineDay == null) {
    return {};
  }
  final firestoreData = mapToFirestore(homeTimelineDay.toMap());

  // Add any Firestore field values
  mapToFirestore(homeTimelineDay.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHomeTimelineDayListFirestoreData(
  List<HomeTimelineDayStruct>? homeTimelineDays,
) =>
    homeTimelineDays
        ?.map((e) => getHomeTimelineDayFirestoreData(e, true))
        .toList() ??
    [];
