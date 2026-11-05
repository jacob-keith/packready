import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChecklistTemplatesRecord extends FirestoreRecord {
  ChecklistTemplatesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  bool hasActivity() => _activity != null;

  // "starterName" field.
  String? _starterName;
  String get starterName => _starterName ?? '';
  bool hasStarterName() => _starterName != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "updatedTime" field.
  DateTime? _updatedTime;
  DateTime? get updatedTime => _updatedTime;
  bool hasUpdatedTime() => _updatedTime != null;

  // "items" field.
  List<PackItemStruct>? _items;
  List<PackItemStruct> get items => _items ?? const [];
  bool hasItems() => _items != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _activity = snapshotData['activity'] as String?;
    _starterName = snapshotData['starterName'] as String?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _updatedTime = snapshotData['updatedTime'] as DateTime?;
    _items = getStructList(
      snapshotData['items'],
      PackItemStruct.fromMap,
    );
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('checklistTemplates')
          : FirebaseFirestore.instance.collectionGroup('checklistTemplates');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('checklistTemplates').doc(id);

  static Stream<ChecklistTemplatesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ChecklistTemplatesRecord.fromSnapshot(s));

  static Future<ChecklistTemplatesRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => ChecklistTemplatesRecord.fromSnapshot(s));

  static ChecklistTemplatesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ChecklistTemplatesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ChecklistTemplatesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ChecklistTemplatesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ChecklistTemplatesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ChecklistTemplatesRecord &&
      reference.path == other.reference.path;
}

Map<String, dynamic> createChecklistTemplatesRecordData({
  String? name,
  String? activity,
  String? starterName,
  DateTime? createdTime,
  DateTime? updatedTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'activity': activity,
      'starterName': starterName,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class ChecklistTemplatesRecordDocumentEquality
    implements Equality<ChecklistTemplatesRecord> {
  const ChecklistTemplatesRecordDocumentEquality();

  @override
  bool equals(ChecklistTemplatesRecord? e1, ChecklistTemplatesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.activity == e2?.activity &&
        e1?.starterName == e2?.starterName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.updatedTime == e2?.updatedTime &&
        listEquality.equals(e1?.items, e2?.items);
  }

  @override
  int hash(ChecklistTemplatesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.activity,
        e?.starterName,
        e?.createdTime,
        e?.updatedTime,
        const ListEquality().hash(e?.items)
      ]);

  @override
  bool isValidKey(Object? o) => o is ChecklistTemplatesRecord;
}
