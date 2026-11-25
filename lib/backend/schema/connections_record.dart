import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// A pending request or accepted connection between two users.
class ConnectionsRecord extends FirestoreRecord {
  ConnectionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "requesterId" field.
  String? _requesterId;
  String get requesterId => _requesterId ?? '';
  bool hasRequesterId() => _requesterId != null;

  // "recipientId" field.
  String? _recipientId;
  String get recipientId => _recipientId ?? '';
  bool hasRecipientId() => _recipientId != null;

  // "requesterHandle" field.
  String? _requesterHandle;
  String get requesterHandle => _requesterHandle ?? '';
  bool hasRequesterHandle() => _requesterHandle != null;

  // "recipientHandle" field.
  String? _recipientHandle;
  String get recipientHandle => _recipientHandle ?? '';
  bool hasRecipientHandle() => _recipientHandle != null;

  // "members" field.
  List<String>? _members;
  List<String> get members => _members ?? const [];
  bool hasMembers() => _members != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _requesterId = snapshotData['requesterId'] as String?;
    _recipientId = snapshotData['recipientId'] as String?;
    _requesterHandle = snapshotData['requesterHandle'] as String?;
    _recipientHandle = snapshotData['recipientHandle'] as String?;
    _members = getDataList(snapshotData['members']);
    _status = snapshotData['status'] as String?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('connections');

  static Stream<ConnectionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ConnectionsRecord.fromSnapshot(s));

  static Future<ConnectionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ConnectionsRecord.fromSnapshot(s));

  static ConnectionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ConnectionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ConnectionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ConnectionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ConnectionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ConnectionsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createConnectionsRecordData({
  String? requesterId,
  String? recipientId,
  String? requesterHandle,
  String? recipientHandle,
  String? status,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'requesterId': requesterId,
      'recipientId': recipientId,
      'requesterHandle': requesterHandle,
      'recipientHandle': recipientHandle,
      'status': status,
      'createdAt': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class ConnectionsRecordDocumentEquality implements Equality<ConnectionsRecord> {
  const ConnectionsRecordDocumentEquality();

  @override
  bool equals(ConnectionsRecord? e1, ConnectionsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.requesterId == e2?.requesterId &&
        e1?.recipientId == e2?.recipientId &&
        e1?.requesterHandle == e2?.requesterHandle &&
        e1?.recipientHandle == e2?.recipientHandle &&
        listEquality.equals(e1?.members, e2?.members) &&
        e1?.status == e2?.status &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(ConnectionsRecord? e) => const ListEquality().hash([
        e?.requesterId,
        e?.recipientId,
        e?.requesterHandle,
        e?.recipientHandle,
        const ListEquality().hash(e?.members),
        e?.status,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is ConnectionsRecord;
}
