import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// A private frozen share with recipient copy tracking.
class SharedItemsRecord extends FirestoreRecord {
  SharedItemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "senderId" field.
  String? _senderId;
  String get senderId => _senderId ?? '';
  bool hasSenderId() => _senderId != null;

  // "recipientId" field.
  String? _recipientId;
  String get recipientId => _recipientId ?? '';
  bool hasRecipientId() => _recipientId != null;

  // "connectionId" field.
  String? _connectionId;
  String get connectionId => _connectionId ?? '';
  bool hasConnectionId() => _connectionId != null;

  // "kind" field.
  String? _kind;
  String get kind => _kind ?? '';
  bool hasKind() => _kind != null;

  // "snapshot" field.
  SharedPackingSnapshotStruct? _snapshot;
  SharedPackingSnapshotStruct get snapshot =>
      _snapshot ?? SharedPackingSnapshotStruct();
  bool hasSnapshot() => _snapshot != null;

  // "added" field.
  bool? _added;
  bool get added => _added ?? false;
  bool hasAdded() => _added != null;

  // "createdAt" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "addedAt" field.
  DateTime? _addedAt;
  DateTime? get addedAt => _addedAt;
  bool hasAddedAt() => _addedAt != null;

  void _initializeFields() {
    _senderId = snapshotData['senderId'] as String?;
    _recipientId = snapshotData['recipientId'] as String?;
    _connectionId = snapshotData['connectionId'] as String?;
    _kind = snapshotData['kind'] as String?;
    _snapshot = snapshotData['snapshot'] is SharedPackingSnapshotStruct
        ? snapshotData['snapshot']
        : SharedPackingSnapshotStruct.maybeFromMap(snapshotData['snapshot']);
    _added = snapshotData['added'] as bool?;
    _createdAt = snapshotData['createdAt'] as DateTime?;
    _addedAt = snapshotData['addedAt'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('shared_items');

  static Stream<SharedItemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SharedItemsRecord.fromSnapshot(s));

  static Future<SharedItemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SharedItemsRecord.fromSnapshot(s));

  static SharedItemsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SharedItemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SharedItemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SharedItemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SharedItemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SharedItemsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createSharedItemsRecordData({
  String? senderId,
  String? recipientId,
  String? connectionId,
  String? kind,
  SharedPackingSnapshotStruct? snapshot,
  bool? added,
  DateTime? createdAt,
  DateTime? addedAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'senderId': senderId,
      'recipientId': recipientId,
      'connectionId': connectionId,
      'kind': kind,
      'snapshot': SharedPackingSnapshotStruct().toMap(),
      'added': added,
      'createdAt': createdAt,
      'addedAt': addedAt,
    }.withoutNulls,
  );

  // Handle nested data for "snapshot" field.
  addSharedPackingSnapshotStructData(firestoreData, snapshot, 'snapshot');

  return firestoreData;
}

class SharedItemsRecordDocumentEquality implements Equality<SharedItemsRecord> {
  const SharedItemsRecordDocumentEquality();

  @override
  bool equals(SharedItemsRecord? e1, SharedItemsRecord? e2) {
    return e1?.senderId == e2?.senderId &&
        e1?.recipientId == e2?.recipientId &&
        e1?.connectionId == e2?.connectionId &&
        e1?.kind == e2?.kind &&
        e1?.snapshot == e2?.snapshot &&
        e1?.added == e2?.added &&
        e1?.createdAt == e2?.createdAt &&
        e1?.addedAt == e2?.addedAt;
  }

  @override
  int hash(SharedItemsRecord? e) => const ListEquality().hash([
        e?.senderId,
        e?.recipientId,
        e?.connectionId,
        e?.kind,
        e?.snapshot,
        e?.added,
        e?.createdAt,
        e?.addedAt
      ]);

  @override
  bool isValidKey(Object? o) => o is SharedItemsRecord;
}
