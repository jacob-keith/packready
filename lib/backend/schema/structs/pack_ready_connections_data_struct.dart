// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyConnectionsData
class PackReadyConnectionsDataStruct extends FFFirebaseStruct {
  PackReadyConnectionsDataStruct({
    /// PackReadyConnectionsData.uid
    String? uid,

    /// PackReadyConnectionsData.status
    String? status,

    /// PackReadyConnectionsData.tag
    String? tag,

    /// PackReadyConnectionsData.tagStatus
    String? tagStatus,

    /// PackReadyConnectionsData.error
    String? error,

    /// PackReadyConnectionsData.sheetKey
    String? sheetKey,

    /// PackReadyConnectionsData.connections
    List<PackReadyConnectionRowStruct>? connections,

    /// PackReadyConnectionsData.incoming
    List<PackReadyConnectionRowStruct>? incoming,

    /// PackReadyConnectionsData.sent
    List<PackReadyConnectionRowStruct>? sent,

    /// PackReadyConnectionsData.templates
    List<PackReadyConnectionRowStruct>? templates,

    /// PackReadyConnectionsData.activities
    List<PackReadyConnectionRowStruct>? activities,

    /// PackReadyConnectionsData.history
    List<String>? history,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _uid = uid,
        _status = status,
        _tag = tag,
        _tagStatus = tagStatus,
        _error = error,
        _sheetKey = sheetKey,
        _connections = connections,
        _incoming = incoming,
        _sent = sent,
        _templates = templates,
        _activities = activities,
        _history = history,
        super(firestoreUtilData);

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  set uid(String? val) => _uid = val;

  bool hasUid() => _uid != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "tag" field.
  String? _tag;
  String get tag => _tag ?? '';
  set tag(String? val) => _tag = val;

  bool hasTag() => _tag != null;

  // "tagStatus" field.
  String? _tagStatus;
  String get tagStatus => _tagStatus ?? '';
  set tagStatus(String? val) => _tagStatus = val;

  bool hasTagStatus() => _tagStatus != null;

  // "error" field.
  String? _error;
  String get error => _error ?? '';
  set error(String? val) => _error = val;

  bool hasError() => _error != null;

  // "sheetKey" field.
  String? _sheetKey;
  String get sheetKey => _sheetKey ?? '';
  set sheetKey(String? val) => _sheetKey = val;

  bool hasSheetKey() => _sheetKey != null;

  // "connections" field.
  List<PackReadyConnectionRowStruct>? _connections;
  List<PackReadyConnectionRowStruct> get connections =>
      _connections ?? const [];
  set connections(List<PackReadyConnectionRowStruct>? val) =>
      _connections = val;

  void updateConnections(
      Function(List<PackReadyConnectionRowStruct>) updateFn) {
    updateFn(_connections ??= []);
  }

  bool hasConnections() => _connections != null;

  // "incoming" field.
  List<PackReadyConnectionRowStruct>? _incoming;
  List<PackReadyConnectionRowStruct> get incoming => _incoming ?? const [];
  set incoming(List<PackReadyConnectionRowStruct>? val) => _incoming = val;

  void updateIncoming(Function(List<PackReadyConnectionRowStruct>) updateFn) {
    updateFn(_incoming ??= []);
  }

  bool hasIncoming() => _incoming != null;

  // "sent" field.
  List<PackReadyConnectionRowStruct>? _sent;
  List<PackReadyConnectionRowStruct> get sent => _sent ?? const [];
  set sent(List<PackReadyConnectionRowStruct>? val) => _sent = val;

  void updateSent(Function(List<PackReadyConnectionRowStruct>) updateFn) {
    updateFn(_sent ??= []);
  }

  bool hasSent() => _sent != null;

  // "templates" field.
  List<PackReadyConnectionRowStruct>? _templates;
  List<PackReadyConnectionRowStruct> get templates => _templates ?? const [];
  set templates(List<PackReadyConnectionRowStruct>? val) => _templates = val;

  void updateTemplates(Function(List<PackReadyConnectionRowStruct>) updateFn) {
    updateFn(_templates ??= []);
  }

  bool hasTemplates() => _templates != null;

  // "activities" field.
  List<PackReadyConnectionRowStruct>? _activities;
  List<PackReadyConnectionRowStruct> get activities => _activities ?? const [];
  set activities(List<PackReadyConnectionRowStruct>? val) => _activities = val;

  void updateActivities(Function(List<PackReadyConnectionRowStruct>) updateFn) {
    updateFn(_activities ??= []);
  }

  bool hasActivities() => _activities != null;

  // "history" field.
  List<String>? _history;
  List<String> get history => _history ?? const [];
  set history(List<String>? val) => _history = val;

  void updateHistory(Function(List<String>) updateFn) {
    updateFn(_history ??= []);
  }

  bool hasHistory() => _history != null;

  static PackReadyConnectionsDataStruct fromMap(Map<String, dynamic> data) =>
      PackReadyConnectionsDataStruct(
        uid: data['uid'] as String?,
        status: data['status'] as String?,
        tag: data['tag'] as String?,
        tagStatus: data['tagStatus'] as String?,
        error: data['error'] as String?,
        sheetKey: data['sheetKey'] as String?,
        connections: getStructList(
          data['connections'],
          PackReadyConnectionRowStruct.fromMap,
        ),
        incoming: getStructList(
          data['incoming'],
          PackReadyConnectionRowStruct.fromMap,
        ),
        sent: getStructList(
          data['sent'],
          PackReadyConnectionRowStruct.fromMap,
        ),
        templates: getStructList(
          data['templates'],
          PackReadyConnectionRowStruct.fromMap,
        ),
        activities: getStructList(
          data['activities'],
          PackReadyConnectionRowStruct.fromMap,
        ),
        history: getDataList(data['history']),
      );

  static PackReadyConnectionsDataStruct? maybeFromMap(dynamic data) =>
      data is Map
          ? PackReadyConnectionsDataStruct.fromMap(data.cast<String, dynamic>())
          : null;

  Map<String, dynamic> toMap() => {
        'uid': _uid,
        'status': _status,
        'tag': _tag,
        'tagStatus': _tagStatus,
        'error': _error,
        'sheetKey': _sheetKey,
        'connections': _connections?.map((e) => e.toMap()).toList(),
        'incoming': _incoming?.map((e) => e.toMap()).toList(),
        'sent': _sent?.map((e) => e.toMap()).toList(),
        'templates': _templates?.map((e) => e.toMap()).toList(),
        'activities': _activities?.map((e) => e.toMap()).toList(),
        'history': _history,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'uid': serializeParam(
          _uid,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'tag': serializeParam(
          _tag,
          ParamType.String,
        ),
        'tagStatus': serializeParam(
          _tagStatus,
          ParamType.String,
        ),
        'error': serializeParam(
          _error,
          ParamType.String,
        ),
        'sheetKey': serializeParam(
          _sheetKey,
          ParamType.String,
        ),
        'connections': serializeParam(
          _connections,
          ParamType.DataStruct,
          isList: true,
        ),
        'incoming': serializeParam(
          _incoming,
          ParamType.DataStruct,
          isList: true,
        ),
        'sent': serializeParam(
          _sent,
          ParamType.DataStruct,
          isList: true,
        ),
        'templates': serializeParam(
          _templates,
          ParamType.DataStruct,
          isList: true,
        ),
        'activities': serializeParam(
          _activities,
          ParamType.DataStruct,
          isList: true,
        ),
        'history': serializeParam(
          _history,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static PackReadyConnectionsDataStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyConnectionsDataStruct(
        uid: deserializeParam(
          data['uid'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        tag: deserializeParam(
          data['tag'],
          ParamType.String,
          false,
        ),
        tagStatus: deserializeParam(
          data['tagStatus'],
          ParamType.String,
          false,
        ),
        error: deserializeParam(
          data['error'],
          ParamType.String,
          false,
        ),
        sheetKey: deserializeParam(
          data['sheetKey'],
          ParamType.String,
          false,
        ),
        connections: deserializeStructParam<PackReadyConnectionRowStruct>(
          data['connections'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyConnectionRowStruct.fromSerializableMap,
        ),
        incoming: deserializeStructParam<PackReadyConnectionRowStruct>(
          data['incoming'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyConnectionRowStruct.fromSerializableMap,
        ),
        sent: deserializeStructParam<PackReadyConnectionRowStruct>(
          data['sent'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyConnectionRowStruct.fromSerializableMap,
        ),
        templates: deserializeStructParam<PackReadyConnectionRowStruct>(
          data['templates'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyConnectionRowStruct.fromSerializableMap,
        ),
        activities: deserializeStructParam<PackReadyConnectionRowStruct>(
          data['activities'],
          ParamType.DataStruct,
          true,
          structBuilder: PackReadyConnectionRowStruct.fromSerializableMap,
        ),
        history: deserializeParam<String>(
          data['history'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'PackReadyConnectionsDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PackReadyConnectionsDataStruct &&
        uid == other.uid &&
        status == other.status &&
        tag == other.tag &&
        tagStatus == other.tagStatus &&
        error == other.error &&
        sheetKey == other.sheetKey &&
        listEquality.equals(connections, other.connections) &&
        listEquality.equals(incoming, other.incoming) &&
        listEquality.equals(sent, other.sent) &&
        listEquality.equals(templates, other.templates) &&
        listEquality.equals(activities, other.activities) &&
        listEquality.equals(history, other.history);
  }

  @override
  int get hashCode => const ListEquality().hash([
        uid,
        status,
        tag,
        tagStatus,
        error,
        sheetKey,
        const ListEquality().hash(connections),
        const ListEquality().hash(incoming),
        const ListEquality().hash(sent),
        const ListEquality().hash(templates),
        const ListEquality().hash(activities),
        const ListEquality().hash(history)
      ]);
}

PackReadyConnectionsDataStruct createPackReadyConnectionsDataStruct({
  String? uid,
  String? status,
  String? tag,
  String? tagStatus,
  String? error,
  String? sheetKey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyConnectionsDataStruct(
      uid: uid,
      status: status,
      tag: tag,
      tagStatus: tagStatus,
      error: error,
      sheetKey: sheetKey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyConnectionsDataStruct? updatePackReadyConnectionsDataStruct(
  PackReadyConnectionsDataStruct? packReadyConnectionsData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyConnectionsData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyConnectionsDataStructData(
  Map<String, dynamic> firestoreData,
  PackReadyConnectionsDataStruct? packReadyConnectionsData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyConnectionsData == null) {
    return;
  }
  if (packReadyConnectionsData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyConnectionsData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyConnectionsDataData = getPackReadyConnectionsDataFirestoreData(
      packReadyConnectionsData, forFieldValue);
  final nestedData =
      packReadyConnectionsDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyConnectionsData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyConnectionsDataFirestoreData(
  PackReadyConnectionsDataStruct? packReadyConnectionsData, [
  bool forFieldValue = false,
]) {
  if (packReadyConnectionsData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyConnectionsData.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyConnectionsData.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyConnectionsDataListFirestoreData(
  List<PackReadyConnectionsDataStruct>? packReadyConnectionsDatas,
) =>
    packReadyConnectionsDatas
        ?.map((e) => getPackReadyConnectionsDataFirestoreData(e, true))
        .toList() ??
    [];
