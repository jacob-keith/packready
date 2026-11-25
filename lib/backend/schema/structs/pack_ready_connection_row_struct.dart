// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyConnectionRow
class PackReadyConnectionRowStruct extends FFFirebaseStruct {
  PackReadyConnectionRowStruct({
    /// PackReadyConnectionRow.id
    String? id,

    /// PackReadyConnectionRow.label
    String? label,

    /// PackReadyConnectionRow.detail
    String? detail,

    /// PackReadyConnectionRow.peerId
    String? peerId,

    /// PackReadyConnectionRow.demoId
    String? demoId,

    /// PackReadyConnectionRow.count
    int? count,

    /// PackReadyConnectionRow.added
    bool? added,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _label = label,
        _detail = detail,
        _peerId = peerId,
        _demoId = demoId,
        _count = count,
        _added = added,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  set label(String? val) => _label = val;

  bool hasLabel() => _label != null;

  // "detail" field.
  String? _detail;
  String get detail => _detail ?? '';
  set detail(String? val) => _detail = val;

  bool hasDetail() => _detail != null;

  // "peerId" field.
  String? _peerId;
  String get peerId => _peerId ?? '';
  set peerId(String? val) => _peerId = val;

  bool hasPeerId() => _peerId != null;

  // "demoId" field.
  String? _demoId;
  String get demoId => _demoId ?? '';
  set demoId(String? val) => _demoId = val;

  bool hasDemoId() => _demoId != null;

  // "count" field.
  int? _count;
  int get count => _count ?? 0;
  set count(int? val) => _count = val;

  void incrementCount(int amount) => count = count + amount;

  bool hasCount() => _count != null;

  // "added" field.
  bool? _added;
  bool get added => _added ?? false;
  set added(bool? val) => _added = val;

  bool hasAdded() => _added != null;

  static PackReadyConnectionRowStruct fromMap(Map<String, dynamic> data) =>
      PackReadyConnectionRowStruct(
        id: data['id'] as String?,
        label: data['label'] as String?,
        detail: data['detail'] as String?,
        peerId: data['peerId'] as String?,
        demoId: data['demoId'] as String?,
        count: castToType<int>(data['count']),
        added: data['added'] as bool?,
      );

  static PackReadyConnectionRowStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyConnectionRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'label': _label,
        'detail': _detail,
        'peerId': _peerId,
        'demoId': _demoId,
        'count': _count,
        'added': _added,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'label': serializeParam(
          _label,
          ParamType.String,
        ),
        'detail': serializeParam(
          _detail,
          ParamType.String,
        ),
        'peerId': serializeParam(
          _peerId,
          ParamType.String,
        ),
        'demoId': serializeParam(
          _demoId,
          ParamType.String,
        ),
        'count': serializeParam(
          _count,
          ParamType.int,
        ),
        'added': serializeParam(
          _added,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PackReadyConnectionRowStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyConnectionRowStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        label: deserializeParam(
          data['label'],
          ParamType.String,
          false,
        ),
        detail: deserializeParam(
          data['detail'],
          ParamType.String,
          false,
        ),
        peerId: deserializeParam(
          data['peerId'],
          ParamType.String,
          false,
        ),
        demoId: deserializeParam(
          data['demoId'],
          ParamType.String,
          false,
        ),
        count: deserializeParam(
          data['count'],
          ParamType.int,
          false,
        ),
        added: deserializeParam(
          data['added'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PackReadyConnectionRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackReadyConnectionRowStruct &&
        id == other.id &&
        label == other.label &&
        detail == other.detail &&
        peerId == other.peerId &&
        demoId == other.demoId &&
        count == other.count &&
        added == other.added;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, label, detail, peerId, demoId, count, added]);
}

PackReadyConnectionRowStruct createPackReadyConnectionRowStruct({
  String? id,
  String? label,
  String? detail,
  String? peerId,
  String? demoId,
  int? count,
  bool? added,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyConnectionRowStruct(
      id: id,
      label: label,
      detail: detail,
      peerId: peerId,
      demoId: demoId,
      count: count,
      added: added,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyConnectionRowStruct? updatePackReadyConnectionRowStruct(
  PackReadyConnectionRowStruct? packReadyConnectionRow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyConnectionRow
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyConnectionRowStructData(
  Map<String, dynamic> firestoreData,
  PackReadyConnectionRowStruct? packReadyConnectionRow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyConnectionRow == null) {
    return;
  }
  if (packReadyConnectionRow.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyConnectionRow.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyConnectionRowData = getPackReadyConnectionRowFirestoreData(
      packReadyConnectionRow, forFieldValue);
  final nestedData =
      packReadyConnectionRowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyConnectionRow.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyConnectionRowFirestoreData(
  PackReadyConnectionRowStruct? packReadyConnectionRow, [
  bool forFieldValue = false,
]) {
  if (packReadyConnectionRow == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyConnectionRow.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyConnectionRow.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyConnectionRowListFirestoreData(
  List<PackReadyConnectionRowStruct>? packReadyConnectionRows,
) =>
    packReadyConnectionRows
        ?.map((e) => getPackReadyConnectionRowFirestoreData(e, true))
        .toList() ??
    [];
