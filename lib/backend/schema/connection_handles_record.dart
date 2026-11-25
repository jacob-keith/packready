import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Exact username lookup without access to user profiles.
class ConnectionHandlesRecord extends FirestoreRecord {
  ConnectionHandlesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "handle" field.
  String? _handle;
  String get handle => _handle ?? '';
  bool hasHandle() => _handle != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _handle = snapshotData['handle'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('connection_handles');

  static Stream<ConnectionHandlesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ConnectionHandlesRecord.fromSnapshot(s));

  static Future<ConnectionHandlesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ConnectionHandlesRecord.fromSnapshot(s));

  static ConnectionHandlesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ConnectionHandlesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ConnectionHandlesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ConnectionHandlesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ConnectionHandlesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ConnectionHandlesRecord &&
      reference.path == other.reference.path;
}

Map<String, dynamic> createConnectionHandlesRecordData({
  String? uid,
  String? handle,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'handle': handle,
    }.withoutNulls,
  );

  return firestoreData;
}

class ConnectionHandlesRecordDocumentEquality
    implements Equality<ConnectionHandlesRecord> {
  const ConnectionHandlesRecordDocumentEquality();

  @override
  bool equals(ConnectionHandlesRecord? e1, ConnectionHandlesRecord? e2) {
    return e1?.uid == e2?.uid && e1?.handle == e2?.handle;
  }

  @override
  int hash(ConnectionHandlesRecord? e) =>
      const ListEquality().hash([e?.uid, e?.handle]);

  @override
  bool isValidKey(Object? o) => o is ConnectionHandlesRecord;
}
