import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Collection subscriptions
class SubscriptionsRecord extends FirestoreRecord {
  SubscriptionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "billingPlan" field.
  String? _billingPlan;
  String get billingPlan => _billingPlan ?? '';
  bool hasBillingPlan() => _billingPlan != null;

  // "premiumUntil" field.
  DateTime? _premiumUntil;
  DateTime? get premiumUntil => _premiumUntil;
  bool hasPremiumUntil() => _premiumUntil != null;

  // "billingCanceled" field.
  bool? _billingCanceled;
  bool get billingCanceled => _billingCanceled ?? false;
  bool hasBillingCanceled() => _billingCanceled != null;

  // "playProductId" field.
  String? _playProductId;
  String get playProductId => _playProductId ?? '';
  bool hasPlayProductId() => _playProductId != null;

  void _initializeFields() {
    _uid = snapshotData['uid'] as String?;
    _billingPlan = snapshotData['billingPlan'] as String?;
    _premiumUntil = snapshotData['premiumUntil'] as DateTime?;
    _billingCanceled = snapshotData['billingCanceled'] as bool?;
    _playProductId = snapshotData['playProductId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subscriptions');

  static Stream<SubscriptionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubscriptionsRecord.fromSnapshot(s));

  static Future<SubscriptionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubscriptionsRecord.fromSnapshot(s));

  static SubscriptionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubscriptionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubscriptionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubscriptionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubscriptionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubscriptionsRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createSubscriptionsRecordData({
  String? uid,
  String? billingPlan,
  DateTime? premiumUntil,
  bool? billingCanceled,
  String? playProductId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'uid': uid,
      'billingPlan': billingPlan,
      'premiumUntil': premiumUntil,
      'billingCanceled': billingCanceled,
      'playProductId': playProductId,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubscriptionsRecordDocumentEquality
    implements Equality<SubscriptionsRecord> {
  const SubscriptionsRecordDocumentEquality();

  @override
  bool equals(SubscriptionsRecord? e1, SubscriptionsRecord? e2) {
    return e1?.uid == e2?.uid &&
        e1?.billingPlan == e2?.billingPlan &&
        e1?.premiumUntil == e2?.premiumUntil &&
        e1?.billingCanceled == e2?.billingCanceled &&
        e1?.playProductId == e2?.playProductId;
  }

  @override
  int hash(SubscriptionsRecord? e) => const ListEquality().hash([
        e?.uid,
        e?.billingPlan,
        e?.premiumUntil,
        e?.billingCanceled,
        e?.playProductId
      ]);

  @override
  bool isValidKey(Object? o) => o is SubscriptionsRecord;
}
