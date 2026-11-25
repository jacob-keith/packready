// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyAiHistoryCard
class PackReadyAiHistoryCardStruct extends FFFirebaseStruct {
  PackReadyAiHistoryCardStruct({
    /// PackReadyAiHistoryCard.turnId
    String? turnId,

    /// PackReadyAiHistoryCard.prompt
    String? prompt,

    /// PackReadyAiHistoryCard.summary
    String? summary,

    /// PackReadyAiHistoryCard.timeLabel
    String? timeLabel,

    /// PackReadyAiHistoryCard.undone
    bool? undone,

    /// PackReadyAiHistoryCard.undoable
    bool? undoable,

    /// PackReadyAiHistoryCard.lines
    List<PackReadyAiResultLineStruct>? lines,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _turnId = turnId,
        _prompt = prompt,
        _summary = summary,
        _timeLabel = timeLabel,
        _undone = undone,
        _undoable = undoable,
        _lines = lines,
        super(firestoreUtilData);

  // "turnId" field.
  String? _turnId;
  String get turnId => _turnId ?? '';
  set turnId(String? val) => _turnId = val;

  bool hasTurnId() => _turnId != null;

  // "prompt" field.
  String? _prompt;
  String get prompt => _prompt ?? '';
  set prompt(String? val) => _prompt = val;

  bool hasPrompt() => _prompt != null;

  // "summary" field.
  String? _summary;
  String get summary => _summary ?? '';
  set summary(String? val) => _summary = val;

  bool hasSummary() => _summary != null;

  // "timeLabel" field.
  String? _timeLabel;
  String get timeLabel => _timeLabel ?? '';
  set timeLabel(String? val) => _timeLabel = val;

  bool hasTimeLabel() => _timeLabel != null;

  // "undone" field.
  bool? _undone;
  bool get undone => _undone ?? false;
  set undone(bool? val) => _undone = val;

  bool hasUndone() => _undone != null;

  // "undoable" field.
  bool? _undoable;
  bool get undoable => _undoable ?? false;
  set undoable(bool? val) => _undoable = val;

  bool hasUndoable() => _undoable != null;

  // "lines" field.
  List<PackReadyAiResultLineStruct>? _lines;
  List<PackReadyAiResultLineStruct> get lines => _lines ?? const [];
  set lines(List<PackReadyAiResultLineStruct>? val) => _lines = val;

  void updateLines(Function(List<PackReadyAiResultLineStruct>) updateFn) {
    updateFn(_lines ??= []);
  }

  bool hasLines() => _lines != null;

  static PackReadyAiHistoryCardStruct fromMap(Map<String, dynamic> data) =>
      PackReadyAiHistoryCardStruct(
        turnId: data['turnId'] as String?,
        prompt: data['prompt'] as String?,
        summary: data['summary'] as String?,
        timeLabel: data['timeLabel'] as String?,
        undone: data['undone'] as bool?,
        undoable: data['undoable'] as bool?,
        lines: getStructList(
          data['lines'],
          PackReadyAiResultLineStruct.fromMap,
        ),
      );

  static PackReadyAiHistoryCardStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyAiHistoryCardStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'turnId': _turnId,
        'prompt': _prompt,
        'summary': _summary,
        'timeLabel': _timeLabel,
        'undone': _undone,
        'undoable': _undoable,
        'lines': _lines?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'turnId': serializeParam(
          _turnId,
          ParamType.String,
        ),
        'prompt': serializeParam(
          _prompt,
          ParamType.String,
        ),
        'summary': serializeParam(
          _summary,
          ParamType.String,
        ),
        'timeLabel': serializeParam(
          _timeLabel,
          ParamType.String,
        ),
        'undone': serializeParam(
          _undone,
          ParamType.bool,
        ),
        'undoable': serializeParam(
          _undoable,
          ParamType.bool,
        ),
        'lines': serializeParam(
          _lines,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static PackReadyAiHistoryCardStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyAiHistoryCardStruct(
        turnId: deserializeParam(
          data['turnId'],
          ParamType.String,
          false,
        ),
        prompt: deserializeParam(
          data['prompt'],
          ParamType.String,
          false,
        ),
        summary: deserializeParam(
          data['summary'],
          ParamType.String,
          false,
        ),
        timeLabel: deserializeParam(
          data['timeLabel'],
          ParamType.String,
          false,
        ),
        undone: deserializeParam(
          data['undone'],
          ParamType.bool,
          false,
        ),
        undoable: deserializeParam(
          data['undoable'],
          ParamType.bool,
          false,
        ),
        lines: deserializeStructParam<PackReadyAiResultLineStruct>(
          data['lines'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyAiResultLineStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PackReadyAiHistoryCardStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PackReadyAiHistoryCardStruct &&
        turnId == other.turnId &&
        prompt == other.prompt &&
        summary == other.summary &&
        timeLabel == other.timeLabel &&
        undone == other.undone &&
        undoable == other.undoable &&
        listEquality.equals(lines, other.lines);
  }

  @override
  int get hashCode => const ListEquality().hash([
        turnId,
        prompt,
        summary,
        timeLabel,
        undone,
        undoable,
        const ListEquality().hash(lines)
      ]);
}

PackReadyAiHistoryCardStruct createPackReadyAiHistoryCardStruct({
  String? turnId,
  String? prompt,
  String? summary,
  String? timeLabel,
  bool? undone,
  bool? undoable,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyAiHistoryCardStruct(
      turnId: turnId,
      prompt: prompt,
      summary: summary,
      timeLabel: timeLabel,
      undone: undone,
      undoable: undoable,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyAiHistoryCardStruct? updatePackReadyAiHistoryCardStruct(
  PackReadyAiHistoryCardStruct? packReadyAiHistoryCard, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyAiHistoryCard
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyAiHistoryCardStructData(
  Map<String, dynamic> firestoreData,
  PackReadyAiHistoryCardStruct? packReadyAiHistoryCard,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyAiHistoryCard == null) {
    return;
  }
  if (packReadyAiHistoryCard.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyAiHistoryCard.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyAiHistoryCardData = getPackReadyAiHistoryCardFirestoreData(
      packReadyAiHistoryCard, forFieldValue);
  final nestedData =
      packReadyAiHistoryCardData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyAiHistoryCard.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyAiHistoryCardFirestoreData(
  PackReadyAiHistoryCardStruct? packReadyAiHistoryCard, [
  bool forFieldValue = false,
]) {
  if (packReadyAiHistoryCard == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyAiHistoryCard.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyAiHistoryCard.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyAiHistoryCardListFirestoreData(
  List<PackReadyAiHistoryCardStruct>? packReadyAiHistoryCards,
) =>
    packReadyAiHistoryCards
        ?.map((e) => getPackReadyAiHistoryCardFirestoreData(e, true))
        .toList() ??
    [];
