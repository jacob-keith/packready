import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// A user's packing list for one trip, created from an activity template
/// (US4).
class PackingListsRecord extends FirestoreRecord {
  PackingListsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "tripName" field.
  String? _tripName;
  String get tripName => _tripName ?? '';
  bool hasTripName() => _tripName != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  bool hasActivity() => _activity != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "leaveDate" field.
  DateTime? _leaveDate;
  DateTime? get leaveDate => _leaveDate;
  bool hasLeaveDate() => _leaveDate != null;

  // "completed" field.
  bool? _completed;
  bool get completed => _completed ?? false;
  bool hasCompleted() => _completed != null;

  // "items" field.
  List<PackItemStruct>? _items;
  List<PackItemStruct> get items => _items ?? const [];
  bool hasItems() => _items != null;

  // "recurring" field.
  bool? _recurring;
  bool get recurring => _recurring ?? false;
  bool hasRecurring() => _recurring != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _tripName = snapshotData['tripName'] as String?;
    _activity = snapshotData['activity'] as String?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _leaveDate = snapshotData['leaveDate'] as DateTime?;
    _completed = snapshotData['completed'] as bool?;
    _items = getStructList(
      snapshotData['items'],
      PackItemStruct.fromMap,
    );
    _recurring = snapshotData['recurring'] as bool?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('packingLists')
          : FirebaseFirestore.instance.collectionGroup('packingLists');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('packingLists').doc(id);

  static Stream<PackingListsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PackingListsRecord.fromSnapshot(s));

  static Future<PackingListsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PackingListsRecord.fromSnapshot(s));

  static PackingListsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PackingListsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PackingListsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PackingListsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PackingListsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PackingListsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createPackingListsRecordData({
  String? tripName,
  String? activity,
  DateTime? createdTime,
  DateTime? leaveDate,
  bool? completed,
  bool? recurring,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'tripName': tripName,
      'activity': activity,
      'createdTime': createdTime,
      'leaveDate': leaveDate,
      'completed': completed,
      'recurring': recurring,
    }.withoutNulls,
  );

  return firestoreData;
}

class PackingListsRecordDocumentEquality
    implements Equality<PackingListsRecord> {
  const PackingListsRecordDocumentEquality();

  @override
  bool equals(PackingListsRecord? e1, PackingListsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.tripName == e2?.tripName &&
        e1?.activity == e2?.activity &&
        e1?.createdTime == e2?.createdTime &&
        e1?.leaveDate == e2?.leaveDate &&
        e1?.completed == e2?.completed &&
        listEquality.equals(e1?.items, e2?.items) &&
        e1?.recurring == e2?.recurring;
  }

  @override
  int hash(PackingListsRecord? e) => const ListEquality().hash([
        e?.tripName,
        e?.activity,
        e?.createdTime,
        e?.leaveDate,
        e?.completed,
        const ListEquality().hash(e?.items),
        e?.recurring
      ]);

  @override
  bool isValidKey(Object? o) => o is PackingListsRecord;
}
