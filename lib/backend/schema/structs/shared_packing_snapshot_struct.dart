// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Frozen name, category, and checklist items for a shared record.
class SharedPackingSnapshotStruct extends FFFirebaseStruct {
  SharedPackingSnapshotStruct({
    /// SharedPackingSnapshot.name
    String? name,

    /// SharedPackingSnapshot.activity
    String? activity,

    /// SharedPackingSnapshot.items
    List<PackItemStruct>? items,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _activity = activity,
        _items = items,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  set activity(String? val) => _activity = val;

  bool hasActivity() => _activity != null;

  // "items" field.
  List<PackItemStruct>? _items;
  List<PackItemStruct> get items => _items ?? const [];
  set items(List<PackItemStruct>? val) => _items = val;

  void updateItems(Function(List<PackItemStruct>) updateFn) {
    updateFn(_items ??= []);
  }

  bool hasItems() => _items != null;

  static SharedPackingSnapshotStruct fromMap(Map<String, dynamic> data) =>
      SharedPackingSnapshotStruct(
        name: data['name'] as String?,
        activity: data['activity'] as String?,
        items: getStructList(
          data['items'],
          PackItemStruct.fromMap,
        ),
      );

  static SharedPackingSnapshotStruct? maybeFromMap(dynamic data) => data is Map
      ? SharedPackingSnapshotStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'activity': _activity,
        'items': _items?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'activity': serializeParam(
          _activity,
          ParamType.String,
        ),
        'items': serializeParam(
          _items,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static SharedPackingSnapshotStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      SharedPackingSnapshotStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        activity: deserializeParam(
          data['activity'],
          ParamType.String,
          false,
        ),
        items: deserializeStructParam<PackItemStruct>(
          data['items'],
          ParamType.DataStruct,
          true,
          structBuilder: PackItemStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SharedPackingSnapshotStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SharedPackingSnapshotStruct &&
        name == other.name &&
        activity == other.activity &&
        listEquality.equals(items, other.items);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([name, activity, const ListEquality().hash(items)]);
}

SharedPackingSnapshotStruct createSharedPackingSnapshotStruct({
  String? name,
  String? activity,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    SharedPackingSnapshotStruct(
      name: name,
      activity: activity,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

SharedPackingSnapshotStruct? updateSharedPackingSnapshotStruct(
  SharedPackingSnapshotStruct? sharedPackingSnapshot, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    sharedPackingSnapshot
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addSharedPackingSnapshotStructData(
  Map<String, dynamic> firestoreData,
  SharedPackingSnapshotStruct? sharedPackingSnapshot,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (sharedPackingSnapshot == null) {
    return;
  }
  if (sharedPackingSnapshot.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      sharedPackingSnapshot.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final sharedPackingSnapshotData = getSharedPackingSnapshotFirestoreData(
      sharedPackingSnapshot, forFieldValue);
  final nestedData =
      sharedPackingSnapshotData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      sharedPackingSnapshot.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getSharedPackingSnapshotFirestoreData(
  SharedPackingSnapshotStruct? sharedPackingSnapshot, [
  bool forFieldValue = false,
]) {
  if (sharedPackingSnapshot == null) {
    return {};
  }
  final firestoreData = mapToFirestore(sharedPackingSnapshot.toMap());

  // Add any Firestore field values
  mapToFirestore(sharedPackingSnapshot.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getSharedPackingSnapshotListFirestoreData(
  List<SharedPackingSnapshotStruct>? sharedPackingSnapshots,
) =>
    sharedPackingSnapshots
        ?.map((e) => getSharedPackingSnapshotFirestoreData(e, true))
        .toList() ??
    [];
