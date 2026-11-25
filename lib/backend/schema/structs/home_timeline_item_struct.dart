// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct HomeTimelineItem
class HomeTimelineItemStruct extends FFFirebaseStruct {
  HomeTimelineItemStruct({
    /// HomeTimelineItem.listRef
    DocumentReference? listRef,

    /// HomeTimelineItem.itemIndex
    int? itemIndex,

    /// HomeTimelineItem.name
    String? name,

    /// HomeTimelineItem.detail
    String? detail,

    /// HomeTimelineItem.packed
    bool? packed,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _listRef = listRef,
        _itemIndex = itemIndex,
        _name = name,
        _detail = detail,
        _packed = packed,
        super(firestoreUtilData);

  // "listRef" field.
  DocumentReference? _listRef;
  DocumentReference? get listRef => _listRef;
  set listRef(DocumentReference? val) => _listRef = val;

  bool hasListRef() => _listRef != null;

  // "itemIndex" field.
  int? _itemIndex;
  int get itemIndex => _itemIndex ?? 0;
  set itemIndex(int? val) => _itemIndex = val;

  void incrementItemIndex(int amount) => itemIndex = itemIndex + amount;

  bool hasItemIndex() => _itemIndex != null;

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

  static HomeTimelineItemStruct fromMap(Map<String, dynamic> data) =>
      HomeTimelineItemStruct(
        listRef: data['listRef'] as DocumentReference?,
        itemIndex: castToType<int>(data['itemIndex']),
        name: data['name'] as String?,
        detail: data['detail'] as String?,
        packed: data['packed'] as bool?,
      );

  static HomeTimelineItemStruct? maybeFromMap(dynamic data) => data is Map
      ? HomeTimelineItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'listRef': _listRef,
        'itemIndex': _itemIndex,
        'name': _name,
        'detail': _detail,
        'packed': _packed,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'listRef': serializeParam(
          _listRef,
          ParamType.DocumentReference,
        ),
        'itemIndex': serializeParam(
          _itemIndex,
          ParamType.int,
        ),
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

  static HomeTimelineItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HomeTimelineItemStruct(
        listRef: deserializeParam(
          data['listRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users', 'packingLists'],
        ),
        itemIndex: deserializeParam(
          data['itemIndex'],
          ParamType.int,
          false,
        ),
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
  String toString() => 'HomeTimelineItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HomeTimelineItemStruct &&
        listRef == other.listRef &&
        itemIndex == other.itemIndex &&
        name == other.name &&
        detail == other.detail &&
        packed == other.packed;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([listRef, itemIndex, name, detail, packed]);
}

HomeTimelineItemStruct createHomeTimelineItemStruct({
  DocumentReference? listRef,
  int? itemIndex,
  String? name,
  String? detail,
  bool? packed,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HomeTimelineItemStruct(
      listRef: listRef,
      itemIndex: itemIndex,
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

HomeTimelineItemStruct? updateHomeTimelineItemStruct(
  HomeTimelineItemStruct? homeTimelineItem, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    homeTimelineItem
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHomeTimelineItemStructData(
  Map<String, dynamic> firestoreData,
  HomeTimelineItemStruct? homeTimelineItem,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (homeTimelineItem == null) {
    return;
  }
  if (homeTimelineItem.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && homeTimelineItem.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final homeTimelineItemData =
      getHomeTimelineItemFirestoreData(homeTimelineItem, forFieldValue);
  final nestedData =
      homeTimelineItemData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = homeTimelineItem.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHomeTimelineItemFirestoreData(
  HomeTimelineItemStruct? homeTimelineItem, [
  bool forFieldValue = false,
]) {
  if (homeTimelineItem == null) {
    return {};
  }
  final firestoreData = mapToFirestore(homeTimelineItem.toMap());

  // Add any Firestore field values
  mapToFirestore(homeTimelineItem.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHomeTimelineItemListFirestoreData(
  List<HomeTimelineItemStruct>? homeTimelineItems,
) =>
    homeTimelineItems
        ?.map((e) => getHomeTimelineItemFirestoreData(e, true))
        .toList() ??
    [];
