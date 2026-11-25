// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct NativePackingRow
class NativePackingRowStruct extends FFFirebaseStruct {
  NativePackingRowStruct({
    /// NativePackingRow.name
    String? name,

    /// NativePackingRow.detail
    String? detail,

    /// NativePackingRow.packed
    bool? packed,

    /// NativePackingRow.originalIndex
    int? originalIndex,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _detail = detail,
        _packed = packed,
        _originalIndex = originalIndex,
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

  // "originalIndex" field.
  int? _originalIndex;
  int get originalIndex => _originalIndex ?? 0;
  set originalIndex(int? val) => _originalIndex = val;

  void incrementOriginalIndex(int amount) =>
      originalIndex = originalIndex + amount;

  bool hasOriginalIndex() => _originalIndex != null;

  static NativePackingRowStruct fromMap(Map<String, dynamic> data) =>
      NativePackingRowStruct(
        name: data['name'] as String?,
        detail: data['detail'] as String?,
        packed: data['packed'] as bool?,
        originalIndex: castToType<int>(data['originalIndex']),
      );

  static NativePackingRowStruct? maybeFromMap(dynamic data) => data is Map
      ? NativePackingRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'detail': _detail,
        'packed': _packed,
        'originalIndex': _originalIndex,
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
        'originalIndex': serializeParam(
          _originalIndex,
          ParamType.int,
        ),
      }.withoutNulls;

  static NativePackingRowStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NativePackingRowStruct(
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
        originalIndex: deserializeParam(
          data['originalIndex'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'NativePackingRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NativePackingRowStruct &&
        name == other.name &&
        detail == other.detail &&
        packed == other.packed &&
        originalIndex == other.originalIndex;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, detail, packed, originalIndex]);
}

NativePackingRowStruct createNativePackingRowStruct({
  String? name,
  String? detail,
  bool? packed,
  int? originalIndex,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NativePackingRowStruct(
      name: name,
      detail: detail,
      packed: packed,
      originalIndex: originalIndex,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NativePackingRowStruct? updateNativePackingRowStruct(
  NativePackingRowStruct? nativePackingRow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nativePackingRow
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNativePackingRowStructData(
  Map<String, dynamic> firestoreData,
  NativePackingRowStruct? nativePackingRow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nativePackingRow == null) {
    return;
  }
  if (nativePackingRow.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nativePackingRow.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nativePackingRowData =
      getNativePackingRowFirestoreData(nativePackingRow, forFieldValue);
  final nestedData =
      nativePackingRowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nativePackingRow.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNativePackingRowFirestoreData(
  NativePackingRowStruct? nativePackingRow, [
  bool forFieldValue = false,
]) {
  if (nativePackingRow == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nativePackingRow.toMap());

  // Add any Firestore field values
  mapToFirestore(nativePackingRow.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNativePackingRowListFirestoreData(
  List<NativePackingRowStruct>? nativePackingRows,
) =>
    nativePackingRows
        ?.map((e) => getNativePackingRowFirestoreData(e, true))
        .toList() ??
    [];
