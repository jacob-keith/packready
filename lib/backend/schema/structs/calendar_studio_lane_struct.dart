// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioLane
class CalendarStudioLaneStruct extends FFFirebaseStruct {
  CalendarStudioLaneStruct({
    /// CalendarStudioLane.cards
    List<CalendarStudioCardStruct>? cards,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _cards = cards,
        super(firestoreUtilData);

  // "cards" field.
  List<CalendarStudioCardStruct>? _cards;
  List<CalendarStudioCardStruct> get cards => _cards ?? const [];
  set cards(List<CalendarStudioCardStruct>? val) => _cards = val;

  void updateCards(Function(List<CalendarStudioCardStruct>) updateFn) {
    updateFn(_cards ??= []);
  }

  bool hasCards() => _cards != null;

  static CalendarStudioLaneStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioLaneStruct(
        cards: getStructList(
          data['cards'],
          CalendarStudioCardStruct.fromMap,
        ),
      );

  static CalendarStudioLaneStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioLaneStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'cards': _cards?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cards': serializeParam(
          _cards,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static CalendarStudioLaneStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioLaneStruct(
        cards: deserializeStructParam<CalendarStudioCardStruct>(
          data['cards'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioCardStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CalendarStudioLaneStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CalendarStudioLaneStruct &&
        listEquality.equals(cards, other.cards);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([const ListEquality().hash(cards)]);
}

CalendarStudioLaneStruct createCalendarStudioLaneStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioLaneStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioLaneStruct? updateCalendarStudioLaneStruct(
  CalendarStudioLaneStruct? calendarStudioLane, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioLane
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioLaneStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioLaneStruct? calendarStudioLane,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioLane == null) {
    return;
  }
  if (calendarStudioLane.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioLane.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioLaneData =
      getCalendarStudioLaneFirestoreData(calendarStudioLane, forFieldValue);
  final nestedData =
      calendarStudioLaneData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioLane.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioLaneFirestoreData(
  CalendarStudioLaneStruct? calendarStudioLane, [
  bool forFieldValue = false,
]) {
  if (calendarStudioLane == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioLane.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioLane.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioLaneListFirestoreData(
  List<CalendarStudioLaneStruct>? calendarStudioLanes,
) =>
    calendarStudioLanes
        ?.map((e) => getCalendarStudioLaneFirestoreData(e, true))
        .toList() ??
    [];
