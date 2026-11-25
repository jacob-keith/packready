// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioBand
class CalendarStudioBandStruct extends FFFirebaseStruct {
  CalendarStudioBandStruct({
    /// CalendarStudioBand.gap
    double? gap,

    /// CalendarStudioBand.allDay
    bool? allDay,

    /// CalendarStudioBand.lanes
    List<CalendarStudioLaneStruct>? lanes,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _gap = gap,
        _allDay = allDay,
        _lanes = lanes,
        super(firestoreUtilData);

  // "gap" field.
  double? _gap;
  double get gap => _gap ?? 0.0;
  set gap(double? val) => _gap = val;

  void incrementGap(double amount) => gap = gap + amount;

  bool hasGap() => _gap != null;

  // "allDay" field.
  bool? _allDay;
  bool get allDay => _allDay ?? false;
  set allDay(bool? val) => _allDay = val;

  bool hasAllDay() => _allDay != null;

  // "lanes" field.
  List<CalendarStudioLaneStruct>? _lanes;
  List<CalendarStudioLaneStruct> get lanes => _lanes ?? const [];
  set lanes(List<CalendarStudioLaneStruct>? val) => _lanes = val;

  void updateLanes(Function(List<CalendarStudioLaneStruct>) updateFn) {
    updateFn(_lanes ??= []);
  }

  bool hasLanes() => _lanes != null;

  static CalendarStudioBandStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioBandStruct(
        gap: castToType<double>(data['gap']),
        allDay: data['allDay'] as bool?,
        lanes: getStructList(
          data['lanes'],
          CalendarStudioLaneStruct.fromMap,
        ),
      );

  static CalendarStudioBandStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioBandStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'gap': _gap,
        'allDay': _allDay,
        'lanes': _lanes?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'gap': serializeParam(
          _gap,
          ParamType.double,
        ),
        'allDay': serializeParam(
          _allDay,
          ParamType.bool,
        ),
        'lanes': serializeParam(
          _lanes,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static CalendarStudioBandStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioBandStruct(
        gap: deserializeParam(
          data['gap'],
          ParamType.double,
          false,
        ),
        allDay: deserializeParam(
          data['allDay'],
          ParamType.bool,
          false,
        ),
        lanes: deserializeStructParam<CalendarStudioLaneStruct>(
          data['lanes'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioLaneStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CalendarStudioBandStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CalendarStudioBandStruct &&
        gap == other.gap &&
        allDay == other.allDay &&
        listEquality.equals(lanes, other.lanes);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([gap, allDay, const ListEquality().hash(lanes)]);
}

CalendarStudioBandStruct createCalendarStudioBandStruct({
  double? gap,
  bool? allDay,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioBandStruct(
      gap: gap,
      allDay: allDay,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioBandStruct? updateCalendarStudioBandStruct(
  CalendarStudioBandStruct? calendarStudioBand, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioBand
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioBandStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioBandStruct? calendarStudioBand,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioBand == null) {
    return;
  }
  if (calendarStudioBand.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioBand.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioBandData =
      getCalendarStudioBandFirestoreData(calendarStudioBand, forFieldValue);
  final nestedData =
      calendarStudioBandData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioBand.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioBandFirestoreData(
  CalendarStudioBandStruct? calendarStudioBand, [
  bool forFieldValue = false,
]) {
  if (calendarStudioBand == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioBand.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioBand.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioBandListFirestoreData(
  List<CalendarStudioBandStruct>? calendarStudioBands,
) =>
    calendarStudioBands
        ?.map((e) => getCalendarStudioBandFirestoreData(e, true))
        .toList() ??
    [];
