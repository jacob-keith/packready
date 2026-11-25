// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyAiReply
class PackReadyAiReplyStruct extends FFFirebaseStruct {
  PackReadyAiReplyStruct({
    /// PackReadyAiReply.ownerUid
    String? ownerUid,

    /// PackReadyAiReply.error
    String? error,

    /// PackReadyAiReply.hasHistory
    bool? hasHistory,

    /// PackReadyAiReply.tutorialSeen
    bool? tutorialSeen,

    /// PackReadyAiReply.clearPrompt
    bool? clearPrompt,

    /// PackReadyAiReply.turns
    List<PackReadyAiHistoryCardStruct>? turns,

    /// PackReadyAiReply.latestTurn
    PackReadyAiHistoryCardStruct? latestTurn,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ownerUid = ownerUid,
        _error = error,
        _hasHistory = hasHistory,
        _tutorialSeen = tutorialSeen,
        _clearPrompt = clearPrompt,
        _turns = turns,
        _latestTurn = latestTurn,
        super(firestoreUtilData);

  // "ownerUid" field.
  String? _ownerUid;
  String get ownerUid => _ownerUid ?? '';
  set ownerUid(String? val) => _ownerUid = val;

  bool hasOwnerUid() => _ownerUid != null;

  // "error" field.
  String? _error;
  String get error => _error ?? '';
  set error(String? val) => _error = val;

  bool hasError() => _error != null;

  // "hasHistory" field.
  bool? _hasHistory;
  bool get hasHistory => _hasHistory ?? false;
  set hasHistory(bool? val) => _hasHistory = val;

  bool hasHasHistory() => _hasHistory != null;

  // "tutorialSeen" field.
  bool? _tutorialSeen;
  bool get tutorialSeen => _tutorialSeen ?? false;
  set tutorialSeen(bool? val) => _tutorialSeen = val;

  bool hasTutorialSeen() => _tutorialSeen != null;

  // "clearPrompt" field.
  bool? _clearPrompt;
  bool get clearPrompt => _clearPrompt ?? false;
  set clearPrompt(bool? val) => _clearPrompt = val;

  bool hasClearPrompt() => _clearPrompt != null;

  // "turns" field.
  List<PackReadyAiHistoryCardStruct>? _turns;
  List<PackReadyAiHistoryCardStruct> get turns => _turns ?? const [];
  set turns(List<PackReadyAiHistoryCardStruct>? val) => _turns = val;

  void updateTurns(Function(List<PackReadyAiHistoryCardStruct>) updateFn) {
    updateFn(_turns ??= []);
  }

  bool hasTurns() => _turns != null;

  // "latestTurn" field.
  PackReadyAiHistoryCardStruct? _latestTurn;
  PackReadyAiHistoryCardStruct get latestTurn =>
      _latestTurn ?? PackReadyAiHistoryCardStruct();
  set latestTurn(PackReadyAiHistoryCardStruct? val) => _latestTurn = val;

  void updateLatestTurn(Function(PackReadyAiHistoryCardStruct) updateFn) {
    updateFn(_latestTurn ??= PackReadyAiHistoryCardStruct());
  }

  bool hasLatestTurn() => _latestTurn != null;

  static PackReadyAiReplyStruct fromMap(Map<String, dynamic> data) =>
      PackReadyAiReplyStruct(
        ownerUid: data['ownerUid'] as String?,
        error: data['error'] as String?,
        hasHistory: data['hasHistory'] as bool?,
        tutorialSeen: data['tutorialSeen'] as bool?,
        clearPrompt: data['clearPrompt'] as bool?,
        turns: getStructList(
          data['turns'],
          PackReadyAiHistoryCardStruct.fromMap,
        ),
        latestTurn: data['latestTurn'] is PackReadyAiHistoryCardStruct
            ? data['latestTurn']
            : PackReadyAiHistoryCardStruct.maybeFromMap(data['latestTurn']),
      );

  static PackReadyAiReplyStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyAiReplyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ownerUid': _ownerUid,
        'error': _error,
        'hasHistory': _hasHistory,
        'tutorialSeen': _tutorialSeen,
        'clearPrompt': _clearPrompt,
        'turns': _turns?.map((e) => e.toMap()).toList(),
        'latestTurn': _latestTurn?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ownerUid': serializeParam(
          _ownerUid,
          ParamType.String,
        ),
        'error': serializeParam(
          _error,
          ParamType.String,
        ),
        'hasHistory': serializeParam(
          _hasHistory,
          ParamType.bool,
        ),
        'tutorialSeen': serializeParam(
          _tutorialSeen,
          ParamType.bool,
        ),
        'clearPrompt': serializeParam(
          _clearPrompt,
          ParamType.bool,
        ),
        'turns': serializeParam(
          _turns,
          ParamType.DataStruct,
          isList: true,
        ),
        'latestTurn': serializeParam(
          _latestTurn,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static PackReadyAiReplyStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyAiReplyStruct(
        ownerUid: deserializeParam(
          data['ownerUid'],
          ParamType.String,
          false,
        ),
        error: deserializeParam(
          data['error'],
          ParamType.String,
          false,
        ),
        hasHistory: deserializeParam(
          data['hasHistory'],
          ParamType.bool,
          false,
        ),
        tutorialSeen: deserializeParam(
          data['tutorialSeen'],
          ParamType.bool,
          false,
        ),
        clearPrompt: deserializeParam(
          data['clearPrompt'],
          ParamType.bool,
          false,
        ),
        turns: deserializeStructParam<PackReadyAiHistoryCardStruct>(
          data['turns'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyAiHistoryCardStruct.fromSerializableMap,
        ),
        latestTurn: deserializeStructParam(
          data['latestTurn'],
          ParamType.DataStruct,
          false,
          structBuilder: PackReadyAiHistoryCardStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PackReadyAiReplyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PackReadyAiReplyStruct &&
        ownerUid == other.ownerUid &&
        error == other.error &&
        hasHistory == other.hasHistory &&
        tutorialSeen == other.tutorialSeen &&
        clearPrompt == other.clearPrompt &&
        listEquality.equals(turns, other.turns) &&
        latestTurn == other.latestTurn;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ownerUid,
        error,
        hasHistory,
        tutorialSeen,
        clearPrompt,
        const ListEquality().hash(turns),
        latestTurn
      ]);
}

PackReadyAiReplyStruct createPackReadyAiReplyStruct({
  String? ownerUid,
  String? error,
  bool? hasHistory,
  bool? tutorialSeen,
  bool? clearPrompt,
  PackReadyAiHistoryCardStruct? latestTurn,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyAiReplyStruct(
      ownerUid: ownerUid,
      error: error,
      hasHistory: hasHistory,
      tutorialSeen: tutorialSeen,
      clearPrompt: clearPrompt,
      latestTurn: latestTurn ??
          (clearUnsetFields ? PackReadyAiHistoryCardStruct() : null),
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyAiReplyStruct? updatePackReadyAiReplyStruct(
  PackReadyAiReplyStruct? packReadyAiReply, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyAiReply
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyAiReplyStructData(
  Map<String, dynamic> firestoreData,
  PackReadyAiReplyStruct? packReadyAiReply,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyAiReply == null) {
    return;
  }
  if (packReadyAiReply.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && packReadyAiReply.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyAiReplyData =
      getPackReadyAiReplyFirestoreData(packReadyAiReply, forFieldValue);
  final nestedData =
      packReadyAiReplyData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = packReadyAiReply.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyAiReplyFirestoreData(
  PackReadyAiReplyStruct? packReadyAiReply, [
  bool forFieldValue = false,
]) {
  if (packReadyAiReply == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyAiReply.toMap());

  // Handle nested data for "latestTurn" field.
  addPackReadyAiHistoryCardStructData(
    firestoreData,
    packReadyAiReply.hasLatestTurn() ? packReadyAiReply.latestTurn : null,
    'latestTurn',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(packReadyAiReply.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyAiReplyListFirestoreData(
  List<PackReadyAiReplyStruct>? packReadyAiReplys,
) =>
    packReadyAiReplys
        ?.map((e) => getPackReadyAiReplyFirestoreData(e, true))
        .toList() ??
    [];
