// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PackItemStruct extends FFFirebaseStruct {
  PackItemStruct({
    String? name,
    String? detail,
    bool? packed,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _detail = detail,
        _packed = packed,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  set detail(String? val) => _detail = val;

  bool hasDetail() => _detail != null;

  // "packed" field.
  bool? _packed;
  bool get packed => _packed ?? false;
  set packed(bool? val) => _packed = val;

  bool hasPacked() => _packed != null;

  static PackItemStruct fromMap(Map<String, dynamic> data) => PackItemStruct(
        name: data['name'] as String?,
        detail: data['detail'] as String?,
        packed: data['packed'] as bool?,
      );

  static PackItemStruct? maybeFromMap(dynamic data) =>
      data is Map ? PackItemStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'detail': _detail,
        'packed': _packed,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'detail': serializeParam(
          _detail,
          ParamType.String,
        ),
        'packed': serializeParam(
          _packed,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PackItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      PackItemStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        detail: deserializeParam(
          data['detail'],
          ParamType.String,
          false,
        ),
        packed: deserializeParam(
          data['packed'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PackItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackItemStruct &&
        name == other.name &&
        detail == other.detail &&
        packed == other.packed;
  }

  @override
  int get hashCode => const ListEquality().hash([name, detail, packed]);
}

PackItemStruct createPackItemStruct({
  String? name,
  String? detail,
  bool? packed,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackItemStruct(
      name: name,
      detail: detail,
      packed: packed,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackItemStruct? updatePackItemStruct(
  PackItemStruct? packItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackItemStructData(
  Map<String, dynamic> firestoreData,
  PackItemStruct? packItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packItem == null) {
    return;
  }
  if (packItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && packItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packItemData = getPackItemFirestoreData(packItem, forFieldValue);
  final nestedData = packItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = packItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackItemFirestoreData(
  PackItemStruct? packItem, [
  bool forFieldValue = false,
]) {
  if (packItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packItem.toMap());

  // Add any Firestore field values
  mapToFirestore(packItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackItemListFirestoreData(
  List<PackItemStruct>? packItems,
) =>
    packItems?.map((e) => getPackItemFirestoreData(e, true)).toList() ?? [];
