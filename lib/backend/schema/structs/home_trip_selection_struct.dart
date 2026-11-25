// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HomeTripSelectionStruct extends FFFirebaseStruct {
  HomeTripSelectionStruct({
    int? tripIndex,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _tripIndex = tripIndex,
        super(firestoreUtilData);

  // "tripIndex" field.
  int? _tripIndex;
  int get tripIndex => _tripIndex ?? 0;
  set tripIndex(int? val) => _tripIndex = val;

  void incrementTripIndex(int amount) => tripIndex = tripIndex + amount;

  bool hasTripIndex() => _tripIndex != null;

  static HomeTripSelectionStruct fromMap(Map<String, dynamic> data) =>
      HomeTripSelectionStruct(
        tripIndex: castToType<int>(data['tripIndex']),
      );

  static HomeTripSelectionStruct? maybeFromMap(dynamic data) => data is Map
      ? HomeTripSelectionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'tripIndex': _tripIndex,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'tripIndex': serializeParam(
          _tripIndex,
          ParamType.int,
        ),
      }.withoutNulls;

  static HomeTripSelectionStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HomeTripSelectionStruct(
        tripIndex: deserializeParam(
          data['tripIndex'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'HomeTripSelectionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HomeTripSelectionStruct && tripIndex == other.tripIndex;
  }

  @override
  int get hashCode => const ListEquality().hash([tripIndex]);
}

HomeTripSelectionStruct createHomeTripSelectionStruct({
  int? tripIndex,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HomeTripSelectionStruct(
      tripIndex: tripIndex,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HomeTripSelectionStruct? updateHomeTripSelectionStruct(
  HomeTripSelectionStruct? homeTripSelection, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    homeTripSelection
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHomeTripSelectionStructData(
  Map<String, dynamic> firestoreData,
  HomeTripSelectionStruct? homeTripSelection,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (homeTripSelection == null) {
    return;
  }
  if (homeTripSelection.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && homeTripSelection.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final homeTripSelectionData =
      getHomeTripSelectionFirestoreData(homeTripSelection, forFieldValue);
  final nestedData =
      homeTripSelectionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = homeTripSelection.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHomeTripSelectionFirestoreData(
  HomeTripSelectionStruct? homeTripSelection, [
  bool forFieldValue = false,
]) {
  if (homeTripSelection == null) {
    return {};
  }
  final firestoreData = mapToFirestore(homeTripSelection.toMap());

  // Add any Firestore field values
  mapToFirestore(homeTripSelection.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHomeTripSelectionListFirestoreData(
  List<HomeTripSelectionStruct>? homeTripSelections,
) =>
    homeTripSelections
        ?.map((e) => getHomeTripSelectionFirestoreData(e, true))
        .toList() ??
    [];
