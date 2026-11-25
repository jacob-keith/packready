// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyAiChange
class PackReadyAiChangeStruct extends FFFirebaseStruct {
  PackReadyAiChangeStruct({
    /// PackReadyAiChange.title
    String? title,

    /// PackReadyAiChange.scope
    String? scope,

    /// PackReadyAiChange.actionLabel
    String? actionLabel,

    /// PackReadyAiChange.tone
    String? tone,

    /// PackReadyAiChange.glyph
    String? glyph,

    /// PackReadyAiChange.targetTitle
    String? targetTitle,

    /// PackReadyAiChange.targetScope
    String? targetScope,

    /// PackReadyAiChange.itemCountLabel
    String? itemCountLabel,

    /// PackReadyAiChange.connector
    String? connector,

    /// PackReadyAiChange.details
    List<String>? details,

    /// PackReadyAiChange.dates
    List<String>? dates,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _scope = scope,
        _actionLabel = actionLabel,
        _tone = tone,
        _glyph = glyph,
        _targetTitle = targetTitle,
        _targetScope = targetScope,
        _itemCountLabel = itemCountLabel,
        _connector = connector,
        _details = details,
        _dates = dates,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "scope" field.
  String? _scope;
  String get scope => _scope ?? '';
  set scope(String? val) => _scope = val;

  bool hasScope() => _scope != null;

  // "actionLabel" field.
  String? _actionLabel;
  String get actionLabel => _actionLabel ?? '';
  set actionLabel(String? val) => _actionLabel = val;

  bool hasActionLabel() => _actionLabel != null;

  // "tone" field.
  String? _tone;
  String get tone => _tone ?? '';
  set tone(String? val) => _tone = val;

  bool hasTone() => _tone != null;

  // "glyph" field.
  String? _glyph;
  String get glyph => _glyph ?? '';
  set glyph(String? val) => _glyph = val;

  bool hasGlyph() => _glyph != null;

  // "targetTitle" field.
  String? _targetTitle;
  String get targetTitle => _targetTitle ?? '';
  set targetTitle(String? val) => _targetTitle = val;

  bool hasTargetTitle() => _targetTitle != null;

  // "targetScope" field.
  String? _targetScope;
  String get targetScope => _targetScope ?? '';
  set targetScope(String? val) => _targetScope = val;

  bool hasTargetScope() => _targetScope != null;

  // "itemCountLabel" field.
  String? _itemCountLabel;
  String get itemCountLabel => _itemCountLabel ?? '';
  set itemCountLabel(String? val) => _itemCountLabel = val;

  bool hasItemCountLabel() => _itemCountLabel != null;

  // "connector" field.
  String? _connector;
  String get connector => _connector ?? '';
  set connector(String? val) => _connector = val;

  bool hasConnector() => _connector != null;

  // "details" field.
  List<String>? _details;
  List<String> get details => _details ?? const [];
  set details(List<String>? val) => _details = val;

  void updateDetails(Function(List<String>) updateFn) {
    updateFn(_details ??= []);
  }

  bool hasDetails() => _details != null;

  // "dates" field.
  List<String>? _dates;
  List<String> get dates => _dates ?? const [];
  set dates(List<String>? val) => _dates = val;

  void updateDates(Function(List<String>) updateFn) {
    updateFn(_dates ??= []);
  }

  bool hasDates() => _dates != null;

  static PackReadyAiChangeStruct fromMap(Map<String, dynamic> data) =>
      PackReadyAiChangeStruct(
        title: data['title'] as String?,
        scope: data['scope'] as String?,
        actionLabel: data['actionLabel'] as String?,
        tone: data['tone'] as String?,
        glyph: data['glyph'] as String?,
        targetTitle: data['targetTitle'] as String?,
        targetScope: data['targetScope'] as String?,
        itemCountLabel: data['itemCountLabel'] as String?,
        connector: data['connector'] as String?,
        details: getDataList(data['details']),
        dates: getDataList(data['dates']),
      );

  static PackReadyAiChangeStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyAiChangeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'scope': _scope,
        'actionLabel': _actionLabel,
        'tone': _tone,
        'glyph': _glyph,
        'targetTitle': _targetTitle,
        'targetScope': _targetScope,
        'itemCountLabel': _itemCountLabel,
        'connector': _connector,
        'details': _details,
        'dates': _dates,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'scope': serializeParam(
          _scope,
          ParamType.String,
        ),
        'actionLabel': serializeParam(
          _actionLabel,
          ParamType.String,
        ),
        'tone': serializeParam(
          _tone,
          ParamType.String,
        ),
        'glyph': serializeParam(
          _glyph,
          ParamType.String,
        ),
        'targetTitle': serializeParam(
          _targetTitle,
          ParamType.String,
        ),
        'targetScope': serializeParam(
          _targetScope,
          ParamType.String,
        ),
        'itemCountLabel': serializeParam(
          _itemCountLabel,
          ParamType.String,
        ),
        'connector': serializeParam(
          _connector,
          ParamType.String,
        ),
        'details': serializeParam(
          _details,
          ParamType.String,
          isList: true,
        ),
        'dates': serializeParam(
          _dates,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static PackReadyAiChangeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyAiChangeStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        scope: deserializeParam(
          data['scope'],
          ParamType.String,
          false,
        ),
        actionLabel: deserializeParam(
          data['actionLabel'],
          ParamType.String,
          false,
        ),
        tone: deserializeParam(
          data['tone'],
          ParamType.String,
          false,
        ),
        glyph: deserializeParam(
          data['glyph'],
          ParamType.String,
          false,
        ),
        targetTitle: deserializeParam(
          data['targetTitle'],
          ParamType.String,
          false,
        ),
        targetScope: deserializeParam(
          data['targetScope'],
          ParamType.String,
          false,
        ),
        itemCountLabel: deserializeParam(
          data['itemCountLabel'],
          ParamType.String,
          false,
        ),
        connector: deserializeParam(
          data['connector'],
          ParamType.String,
          false,
        ),
        details: deserializeParam<String>(
          data['details'],
          ParamType.String,
          true,
        ),
        dates: deserializeParam<String>(
          data['dates'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'PackReadyAiChangeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PackReadyAiChangeStruct &&
        title == other.title &&
        scope == other.scope &&
        actionLabel == other.actionLabel &&
        tone == other.tone &&
        glyph == other.glyph &&
        targetTitle == other.targetTitle &&
        targetScope == other.targetScope &&
        itemCountLabel == other.itemCountLabel &&
        connector == other.connector &&
        listEquality.equals(details, other.details) &&
        listEquality.equals(dates, other.dates);
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        scope,
        actionLabel,
        tone,
        glyph,
        targetTitle,
        targetScope,
        itemCountLabel,
        connector,
        const ListEquality().hash(details),
        const ListEquality().hash(dates)
      ]);
}

PackReadyAiChangeStruct createPackReadyAiChangeStruct({
  String? title,
  String? scope,
  String? actionLabel,
  String? tone,
  String? glyph,
  String? targetTitle,
  String? targetScope,
  String? itemCountLabel,
  String? connector,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyAiChangeStruct(
      title: title,
      scope: scope,
      actionLabel: actionLabel,
      tone: tone,
      glyph: glyph,
      targetTitle: targetTitle,
      targetScope: targetScope,
      itemCountLabel: itemCountLabel,
      connector: connector,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyAiChangeStruct? updatePackReadyAiChangeStruct(
  PackReadyAiChangeStruct? packReadyAiChange, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyAiChange
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyAiChangeStructData(
  Map<String, dynamic> firestoreData,
  PackReadyAiChangeStruct? packReadyAiChange,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyAiChange == null) {
    return;
  }
  if (packReadyAiChange.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && packReadyAiChange.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyAiChangeData =
      getPackReadyAiChangeFirestoreData(packReadyAiChange, forFieldValue);
  final nestedData =
      packReadyAiChangeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = packReadyAiChange.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyAiChangeFirestoreData(
  PackReadyAiChangeStruct? packReadyAiChange, [
  bool forFieldValue = false,
]) {
  if (packReadyAiChange == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyAiChange.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyAiChange.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyAiChangeListFirestoreData(
  List<PackReadyAiChangeStruct>? packReadyAiChanges,
) =>
    packReadyAiChanges
        ?.map((e) => getPackReadyAiChangeFirestoreData(e, true))
        .toList() ??
    [];
