// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct NativeActivityRow
class NativeActivityRowStruct extends FFFirebaseStruct {
  NativeActivityRowStruct({
    /// NativeActivityRow.listRef
    DocumentReference? listRef,

    /// NativeActivityRow.templateRef
    DocumentReference? templateRef,

    /// NativeActivityRow.title
    String? title,

    /// NativeActivityRow.shareName
    String? shareName,

    /// NativeActivityRow.subtitle
    String? subtitle,

    /// NativeActivityRow.activity
    String? activity,

    /// NativeActivityRow.starter
    String? starter,

    /// NativeActivityRow.dateLabel
    String? dateLabel,

    /// NativeActivityRow.trailing
    String? trailing,

    /// NativeActivityRow.heading
    String? heading,

    /// NativeActivityRow.editable
    bool? editable,

    /// NativeActivityRow.items
    List<PackItemStruct>? items,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _listRef = listRef,
        _templateRef = templateRef,
        _title = title,
        _shareName = shareName,
        _subtitle = subtitle,
        _activity = activity,
        _starter = starter,
        _dateLabel = dateLabel,
        _trailing = trailing,
        _heading = heading,
        _editable = editable,
        _items = items,
        super(firestoreUtilData);

  // "listRef" field.
  DocumentReference? _listRef;
  DocumentReference? get listRef => _listRef;
  set listRef(DocumentReference? val) => _listRef = val;

  bool hasListRef() => _listRef != null;

  // "templateRef" field.
  DocumentReference? _templateRef;
  DocumentReference? get templateRef => _templateRef;
  set templateRef(DocumentReference? val) => _templateRef = val;

  bool hasTemplateRef() => _templateRef != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "shareName" field.
  String? _shareName;
  String get shareName => _shareName ?? '';
  set shareName(String? val) => _shareName = val;

  bool hasShareName() => _shareName != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  set subtitle(String? val) => _subtitle = val;

  bool hasSubtitle() => _subtitle != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  set activity(String? val) => _activity = val;

  bool hasActivity() => _activity != null;

  // "starter" field.
  String? _starter;
  String get starter => _starter ?? '';
  set starter(String? val) => _starter = val;

  bool hasStarter() => _starter != null;

  // "dateLabel" field.
  String? _dateLabel;
  String get dateLabel => _dateLabel ?? '';
  set dateLabel(String? val) => _dateLabel = val;

  bool hasDateLabel() => _dateLabel != null;

  // "trailing" field.
  String? _trailing;
  String get trailing => _trailing ?? '';
  set trailing(String? val) => _trailing = val;

  bool hasTrailing() => _trailing != null;

  // "heading" field.
  String? _heading;
  String get heading => _heading ?? '';
  set heading(String? val) => _heading = val;

  bool hasHeading() => _heading != null;

  // "editable" field.
  bool? _editable;
  bool get editable => _editable ?? false;
  set editable(bool? val) => _editable = val;

  bool hasEditable() => _editable != null;

  // "items" field.
  List<PackItemStruct>? _items;
  List<PackItemStruct> get items => _items ?? const [];
  set items(List<PackItemStruct>? val) => _items = val;

  void updateItems(Function(List<PackItemStruct>) updateFn) {
    updateFn(_items ??= []);
  }

  bool hasItems() => _items != null;

  static NativeActivityRowStruct fromMap(Map<String, dynamic> data) =>
      NativeActivityRowStruct(
        listRef: data['listRef'] as DocumentReference?,
        templateRef: data['templateRef'] as DocumentReference?,
        title: data['title'] as String?,
        shareName: data['shareName'] as String?,
        subtitle: data['subtitle'] as String?,
        activity: data['activity'] as String?,
        starter: data['starter'] as String?,
        dateLabel: data['dateLabel'] as String?,
        trailing: data['trailing'] as String?,
        heading: data['heading'] as String?,
        editable: data['editable'] as bool?,
        items: getStructList(
          data['items'],
          PackItemStruct.fromMap,
        ),
      );

  static NativeActivityRowStruct? maybeFromMap(dynamic data) => data is Map
      ? NativeActivityRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'listRef': _listRef,
        'templateRef': _templateRef,
        'title': _title,
        'shareName': _shareName,
        'subtitle': _subtitle,
        'activity': _activity,
        'starter': _starter,
        'dateLabel': _dateLabel,
        'trailing': _trailing,
        'heading': _heading,
        'editable': _editable,
        'items': _items?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'listRef': serializeParam(
          _listRef,
          ParamType.DocumentReference,
        ),
        'templateRef': serializeParam(
          _templateRef,
          ParamType.DocumentReference,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'shareName': serializeParam(
          _shareName,
          ParamType.String,
        ),
        'subtitle': serializeParam(
          _subtitle,
          ParamType.String,
        ),
        'activity': serializeParam(
          _activity,
          ParamType.String,
        ),
        'starter': serializeParam(
          _starter,
          ParamType.String,
        ),
        'dateLabel': serializeParam(
          _dateLabel,
          ParamType.String,
        ),
        'trailing': serializeParam(
          _trailing,
          ParamType.String,
        ),
        'heading': serializeParam(
          _heading,
          ParamType.String,
        ),
        'editable': serializeParam(
          _editable,
          ParamType.bool,
        ),
        'items': serializeParam(
          _items,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static NativeActivityRowStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NativeActivityRowStruct(
        listRef: deserializeParam(
          data['listRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users', 'packingLists'],
        ),
        templateRef: deserializeParam(
          data['templateRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users', 'checklistTemplates'],
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        shareName: deserializeParam(
          data['shareName'],
          ParamType.String,
          false,
        ),
        subtitle: deserializeParam(
          data['subtitle'],
          ParamType.String,
          false,
        ),
        activity: deserializeParam(
          data['activity'],
          ParamType.String,
          false,
        ),
        starter: deserializeParam(
          data['starter'],
          ParamType.String,
          false,
        ),
        dateLabel: deserializeParam(
          data['dateLabel'],
          ParamType.String,
          false,
        ),
        trailing: deserializeParam(
          data['trailing'],
          ParamType.String,
          false,
        ),
        heading: deserializeParam(
          data['heading'],
          ParamType.String,
          false,
        ),
        editable: deserializeParam(
          data['editable'],
          ParamType.bool,
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
  String toString() => 'NativeActivityRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NativeActivityRowStruct &&
        listRef == other.listRef &&
        templateRef == other.templateRef &&
        title == other.title &&
        shareName == other.shareName &&
        subtitle == other.subtitle &&
        activity == other.activity &&
        starter == other.starter &&
        dateLabel == other.dateLabel &&
        trailing == other.trailing &&
        heading == other.heading &&
        editable == other.editable &&
        listEquality.equals(items, other.items);
  }

  @override
  int get hashCode => const ListEquality().hash([
        listRef,
        templateRef,
        title,
        shareName,
        subtitle,
        activity,
        starter,
        dateLabel,
        trailing,
        heading,
        editable,
        const ListEquality().hash(items)
      ]);
}

NativeActivityRowStruct createNativeActivityRowStruct({
  DocumentReference? listRef,
  DocumentReference? templateRef,
  String? title,
  String? shareName,
  String? subtitle,
  String? activity,
  String? starter,
  String? dateLabel,
  String? trailing,
  String? heading,
  bool? editable,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NativeActivityRowStruct(
      listRef: listRef,
      templateRef: templateRef,
      title: title,
      shareName: shareName,
      subtitle: subtitle,
      activity: activity,
      starter: starter,
      dateLabel: dateLabel,
      trailing: trailing,
      heading: heading,
      editable: editable,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NativeActivityRowStruct? updateNativeActivityRowStruct(
  NativeActivityRowStruct? nativeActivityRow, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nativeActivityRow
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNativeActivityRowStructData(
  Map<String, dynamic> firestoreData,
  NativeActivityRowStruct? nativeActivityRow,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nativeActivityRow == null) {
    return;
  }
  if (nativeActivityRow.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nativeActivityRow.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nativeActivityRowData =
      getNativeActivityRowFirestoreData(nativeActivityRow, forFieldValue);
  final nestedData =
      nativeActivityRowData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nativeActivityRow.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNativeActivityRowFirestoreData(
  NativeActivityRowStruct? nativeActivityRow, [
  bool forFieldValue = false,
]) {
  if (nativeActivityRow == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nativeActivityRow.toMap());

  // Add any Firestore field values
  mapToFirestore(nativeActivityRow.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNativeActivityRowListFirestoreData(
  List<NativeActivityRowStruct>? nativeActivityRows,
) =>
    nativeActivityRows
        ?.map((e) => getNativeActivityRowFirestoreData(e, true))
        .toList() ??
    [];
