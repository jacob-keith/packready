// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct AiEditorDraft
class AiEditorDraftStruct extends FFFirebaseStruct {
  AiEditorDraftStruct({
    /// AiEditorDraft.title
    String? title,

    /// AiEditorDraft.items
    List<PackItemStruct>? items,

    /// AiEditorDraft.extras
    List<PackItemStruct>? extras,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _items = items,
        _extras = extras,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "items" field.
  List<PackItemStruct>? _items;
  List<PackItemStruct> get items => _items ?? const [];
  set items(List<PackItemStruct>? val) => _items = val;

  void updateItems(Function(List<PackItemStruct>) updateFn) {
    updateFn(_items ??= []);
  }

  bool hasItems() => _items != null;

  // "extras" field.
  List<PackItemStruct>? _extras;
  List<PackItemStruct> get extras => _extras ?? const [];
  set extras(List<PackItemStruct>? val) => _extras = val;

  void updateExtras(Function(List<PackItemStruct>) updateFn) {
    updateFn(_extras ??= []);
  }

  bool hasExtras() => _extras != null;

  static AiEditorDraftStruct fromMap(Map<String, dynamic> data) =>
      AiEditorDraftStruct(
        title: data['title'] as String?,
        items: getStructList(
          data['items'],
          PackItemStruct.fromMap,
        ),
        extras: getStructList(
          data['extras'],
          PackItemStruct.fromMap,
        ),
      );

  static AiEditorDraftStruct? maybeFromMap(dynamic data) => data is Map
      ? AiEditorDraftStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'items': _items?.map((e) => e.toMap()).toList(),
        'extras': _extras?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'items': serializeParam(
          _items,
          ParamType.DataStruct,
          isList: true,
        ),
        'extras': serializeParam(
          _extras,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static AiEditorDraftStruct fromSerializableMap(Map<String, dynamic> data) =>
      AiEditorDraftStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        items: deserializeStructParam<PackItemStruct>(
          data['items'],
          ParamType.DataStruct,
          true,
          structBuilder: PackItemStruct.fromSerializableMap,
        ),
        extras: deserializeStructParam<PackItemStruct>(
          data['extras'],
          ParamType.DataStruct,
          true,
          structBuilder: PackItemStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'AiEditorDraftStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is AiEditorDraftStruct &&
        title == other.title &&
        listEquality.equals(items, other.items) &&
        listEquality.equals(extras, other.extras);
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        const ListEquality().hash(items),
        const ListEquality().hash(extras)
      ]);
}

AiEditorDraftStruct createAiEditorDraftStruct({
  String? title,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    AiEditorDraftStruct(
      title: title,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

AiEditorDraftStruct? updateAiEditorDraftStruct(
  AiEditorDraftStruct? aiEditorDraft, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    aiEditorDraft
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addAiEditorDraftStructData(
  Map<String, dynamic> firestoreData,
  AiEditorDraftStruct? aiEditorDraft,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (aiEditorDraft == null) {
    return;
  }
  if (aiEditorDraft.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && aiEditorDraft.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final aiEditorDraftData =
      getAiEditorDraftFirestoreData(aiEditorDraft, forFieldValue);
  final nestedData =
      aiEditorDraftData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = aiEditorDraft.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getAiEditorDraftFirestoreData(
  AiEditorDraftStruct? aiEditorDraft, [
  bool forFieldValue = false,
]) {
  if (aiEditorDraft == null) {
    return {};
  }
  final firestoreData = mapToFirestore(aiEditorDraft.toMap());

  // Add any Firestore field values
  mapToFirestore(aiEditorDraft.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getAiEditorDraftListFirestoreData(
  List<AiEditorDraftStruct>? aiEditorDrafts,
) =>
    aiEditorDrafts
        ?.map((e) => getAiEditorDraftFirestoreData(e, true))
        .toList() ??
    [];
