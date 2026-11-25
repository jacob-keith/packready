// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyAiPlan
class PackReadyAiPlanStruct extends FFFirebaseStruct {
  PackReadyAiPlanStruct({
    /// PackReadyAiPlan.title
    String? title,

    /// PackReadyAiPlan.description
    String? description,

    /// PackReadyAiPlan.hasChanges
    bool? hasChanges,

    /// PackReadyAiPlan.addLabel
    String? addLabel,

    /// PackReadyAiPlan.editLabel
    String? editLabel,

    /// PackReadyAiPlan.deleteLabel
    String? deleteLabel,

    /// PackReadyAiPlan.links
    List<PackReadyAiChangeStruct>? links,

    /// PackReadyAiPlan.otherChanges
    List<PackReadyAiChangeStruct>? otherChanges,

    /// PackReadyAiPlan.skipped
    List<PackReadyAiChangeStruct>? skipped,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _description = description,
        _hasChanges = hasChanges,
        _addLabel = addLabel,
        _editLabel = editLabel,
        _deleteLabel = deleteLabel,
        _links = links,
        _otherChanges = otherChanges,
        _skipped = skipped,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "hasChanges" field.
  bool? _hasChanges;
  bool get hasChanges => _hasChanges ?? false;
  set hasChanges(bool? val) => _hasChanges = val;

  bool hasHasChanges() => _hasChanges != null;

  // "addLabel" field.
  String? _addLabel;
  String get addLabel => _addLabel ?? '';
  set addLabel(String? val) => _addLabel = val;

  bool hasAddLabel() => _addLabel != null;

  // "editLabel" field.
  String? _editLabel;
  String get editLabel => _editLabel ?? '';
  set editLabel(String? val) => _editLabel = val;

  bool hasEditLabel() => _editLabel != null;

  // "deleteLabel" field.
  String? _deleteLabel;
  String get deleteLabel => _deleteLabel ?? '';
  set deleteLabel(String? val) => _deleteLabel = val;

  bool hasDeleteLabel() => _deleteLabel != null;

  // "links" field.
  List<PackReadyAiChangeStruct>? _links;
  List<PackReadyAiChangeStruct> get links => _links ?? const [];
  set links(List<PackReadyAiChangeStruct>? val) => _links = val;

  void updateLinks(Function(List<PackReadyAiChangeStruct>) updateFn) {
    updateFn(_links ??= []);
  }

  bool hasLinks() => _links != null;

  // "otherChanges" field.
  List<PackReadyAiChangeStruct>? _otherChanges;
  List<PackReadyAiChangeStruct> get otherChanges => _otherChanges ?? const [];
  set otherChanges(List<PackReadyAiChangeStruct>? val) => _otherChanges = val;

  void updateOtherChanges(Function(List<PackReadyAiChangeStruct>) updateFn) {
    updateFn(_otherChanges ??= []);
  }

  bool hasOtherChanges() => _otherChanges != null;

  // "skipped" field.
  List<PackReadyAiChangeStruct>? _skipped;
  List<PackReadyAiChangeStruct> get skipped => _skipped ?? const [];
  set skipped(List<PackReadyAiChangeStruct>? val) => _skipped = val;

  void updateSkipped(Function(List<PackReadyAiChangeStruct>) updateFn) {
    updateFn(_skipped ??= []);
  }

  bool hasSkipped() => _skipped != null;

  static PackReadyAiPlanStruct fromMap(Map<String, dynamic> data) =>
      PackReadyAiPlanStruct(
        title: data['title'] as String?,
        description: data['description'] as String?,
        hasChanges: data['hasChanges'] as bool?,
        addLabel: data['addLabel'] as String?,
        editLabel: data['editLabel'] as String?,
        deleteLabel: data['deleteLabel'] as String?,
        links: getStructList(
          data['links'],
          PackReadyAiChangeStruct.fromMap,
        ),
        otherChanges: getStructList(
          data['otherChanges'],
          PackReadyAiChangeStruct.fromMap,
        ),
        skipped: getStructList(
          data['skipped'],
          PackReadyAiChangeStruct.fromMap,
        ),
      );

  static PackReadyAiPlanStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyAiPlanStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'description': _description,
        'hasChanges': _hasChanges,
        'addLabel': _addLabel,
        'editLabel': _editLabel,
        'deleteLabel': _deleteLabel,
        'links': _links?.map((e) => e.toMap()).toList(),
        'otherChanges': _otherChanges?.map((e) => e.toMap()).toList(),
        'skipped': _skipped?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'hasChanges': serializeParam(
          _hasChanges,
          ParamType.bool,
        ),
        'addLabel': serializeParam(
          _addLabel,
          ParamType.String,
        ),
        'editLabel': serializeParam(
          _editLabel,
          ParamType.String,
        ),
        'deleteLabel': serializeParam(
          _deleteLabel,
          ParamType.String,
        ),
        'links': serializeParam(
          _links,
          ParamType.DataStruct,
          isList: true,
        ),
        'otherChanges': serializeParam(
          _otherChanges,
          ParamType.DataStruct,
          isList: true,
        ),
        'skipped': serializeParam(
          _skipped,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static PackReadyAiPlanStruct fromSerializableMap(Map<String, dynamic> data) =>
      PackReadyAiPlanStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        hasChanges: deserializeParam(
          data['hasChanges'],
          ParamType.bool,
          false,
        ),
        addLabel: deserializeParam(
          data['addLabel'],
          ParamType.String,
          false,
        ),
        editLabel: deserializeParam(
          data['editLabel'],
          ParamType.String,
          false,
        ),
        deleteLabel: deserializeParam(
          data['deleteLabel'],
          ParamType.String,
          false,
        ),
        links: deserializeStructParam<PackReadyAiChangeStruct>(
          data['links'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyAiChangeStruct.fromSerializableMap,
        ),
        otherChanges: deserializeStructParam<PackReadyAiChangeStruct>(
          data['otherChanges'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyAiChangeStruct.fromSerializableMap,
        ),
        skipped: deserializeStructParam<PackReadyAiChangeStruct>(
          data['skipped'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyAiChangeStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PackReadyAiPlanStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PackReadyAiPlanStruct &&
        title == other.title &&
        description == other.description &&
        hasChanges == other.hasChanges &&
        addLabel == other.addLabel &&
        editLabel == other.editLabel &&
        deleteLabel == other.deleteLabel &&
        listEquality.equals(links, other.links) &&
        listEquality.equals(otherChanges, other.otherChanges) &&
        listEquality.equals(skipped, other.skipped);
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        description,
        hasChanges,
        addLabel,
        editLabel,
        deleteLabel,
        const ListEquality().hash(links),
        const ListEquality().hash(otherChanges),
        const ListEquality().hash(skipped)
      ]);
}

PackReadyAiPlanStruct createPackReadyAiPlanStruct({
  String? title,
  String? description,
  bool? hasChanges,
  String? addLabel,
  String? editLabel,
  String? deleteLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyAiPlanStruct(
      title: title,
      description: description,
      hasChanges: hasChanges,
      addLabel: addLabel,
      editLabel: editLabel,
      deleteLabel: deleteLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyAiPlanStruct? updatePackReadyAiPlanStruct(
  PackReadyAiPlanStruct? packReadyAiPlan, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyAiPlan
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyAiPlanStructData(
  Map<String, dynamic> firestoreData,
  PackReadyAiPlanStruct? packReadyAiPlan,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyAiPlan == null) {
    return;
  }
  if (packReadyAiPlan.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && packReadyAiPlan.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyAiPlanData =
      getPackReadyAiPlanFirestoreData(packReadyAiPlan, forFieldValue);
  final nestedData =
      packReadyAiPlanData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = packReadyAiPlan.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyAiPlanFirestoreData(
  PackReadyAiPlanStruct? packReadyAiPlan, [
  bool forFieldValue = false,
]) {
  if (packReadyAiPlan == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyAiPlan.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyAiPlan.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyAiPlanListFirestoreData(
  List<PackReadyAiPlanStruct>? packReadyAiPlans,
) =>
    packReadyAiPlans
        ?.map((e) => getPackReadyAiPlanFirestoreData(e, true))
        .toList() ??
    [];
