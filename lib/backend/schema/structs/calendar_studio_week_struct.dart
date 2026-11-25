// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioWeek
class CalendarStudioWeekStruct extends FFFirebaseStruct {
  CalendarStudioWeekStruct({
    /// CalendarStudioWeek.days
    List<CalendarStudioDayStruct>? days,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _days = days,
        super(firestoreUtilData);

  // "days" field.
  List<CalendarStudioDayStruct>? _days;
  List<CalendarStudioDayStruct> get days => _days ?? const [];
  set days(List<CalendarStudioDayStruct>? val) => _days = val;

  void updateDays(Function(List<CalendarStudioDayStruct>) updateFn) {
    updateFn(_days ??= []);
  }

  bool hasDays() => _days != null;

  static CalendarStudioWeekStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioWeekStruct(
        days: getStructList(
          data['days'],
          CalendarStudioDayStruct.fromMap,
        ),
      );

  static CalendarStudioWeekStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioWeekStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'days': _days?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'days': serializeParam(
          _days,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static CalendarStudioWeekStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioWeekStruct(
        days: deserializeStructParam<CalendarStudioDayStruct>(
          data['days'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioDayStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CalendarStudioWeekStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CalendarStudioWeekStruct &&
        listEquality.equals(days, other.days);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([const ListEquality().hash(days)]);
}

CalendarStudioWeekStruct createCalendarStudioWeekStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioWeekStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioWeekStruct? updateCalendarStudioWeekStruct(
  CalendarStudioWeekStruct? calendarStudioWeek, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioWeek
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioWeekStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioWeekStruct? calendarStudioWeek,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioWeek == null) {
    return;
  }
  if (calendarStudioWeek.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioWeek.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioWeekData =
      getCalendarStudioWeekFirestoreData(calendarStudioWeek, forFieldValue);
  final nestedData =
      calendarStudioWeekData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioWeek.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioWeekFirestoreData(
  CalendarStudioWeekStruct? calendarStudioWeek, [
  bool forFieldValue = false,
]) {
  if (calendarStudioWeek == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioWeek.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioWeek.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioWeekListFirestoreData(
  List<CalendarStudioWeekStruct>? calendarStudioWeeks,
) =>
    calendarStudioWeeks
        ?.map((e) => getCalendarStudioWeekFirestoreData(e, true))
        .toList() ??
    [];
