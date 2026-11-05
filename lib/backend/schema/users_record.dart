import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "gender" field.
  String? _gender;
  String get gender => _gender ?? '';
  bool hasGender() => _gender != null;

  // "home_city" field.
  String? _homeCity;
  String get homeCity => _homeCity ?? '';
  bool hasHomeCity() => _homeCity != null;

  // "date_of_birth" field.
  String? _dateOfBirth;
  String get dateOfBirth => _dateOfBirth ?? '';
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "defaultReminder" field.
  String? _defaultReminder;
  String get defaultReminder => _defaultReminder ?? '';
  bool hasDefaultReminder() => _defaultReminder != null;

  // "profileCompleted" field.
  bool? _profileCompleted;
  bool get profileCompleted => _profileCompleted ?? false;
  bool hasProfileCompleted() => _profileCompleted != null;

  // "activities" field.
  List<String>? _activities;
  List<String> get activities => _activities ?? const [];
  bool hasActivities() => _activities != null;

  // "profileLevel" field.
  String? _profileLevel;
  String get profileLevel => _profileLevel ?? '';
  bool hasProfileLevel() => _profileLevel != null;

  // "profilePercentage" field.
  int? _profilePercentage;
  int get profilePercentage => _profilePercentage ?? 0;
  bool hasProfilePercentage() => _profilePercentage != null;

  // "userProfileTrip" field.
  String? _userProfileTrip;
  String get userProfileTrip => _userProfileTrip ?? '';
  bool hasUserProfileTrip() => _userProfileTrip != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _gender = snapshotData['gender'] as String?;
    _homeCity = snapshotData['home_city'] as String?;
    _dateOfBirth = snapshotData['date_of_birth'] as String?;
    _defaultReminder = snapshotData['defaultReminder'] as String?;
    _profileCompleted = snapshotData['profileCompleted'] as bool?;
    _activities = getDataList(snapshotData['activities']);
    _profileLevel = snapshotData['profileLevel'] as String?;
    _profilePercentage = castToType<int>(snapshotData['profilePercentage']);
    _userProfileTrip = snapshotData['userProfileTrip'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord && reference.path == other.reference.path;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? gender,
  String? homeCity,
  String? dateOfBirth,
  String? defaultReminder,
  bool? profileCompleted,
  String? profileLevel,
  int? profilePercentage,
  String? userProfileTrip,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'gender': gender,
      'home_city': homeCity,
      'date_of_birth': dateOfBirth,
      'defaultReminder': defaultReminder,
      'profileCompleted': profileCompleted,
      'profileLevel': profileLevel,
      'profilePercentage': profilePercentage,
      'userProfileTrip': userProfileTrip,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.gender == e2?.gender &&
        e1?.homeCity == e2?.homeCity &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.defaultReminder == e2?.defaultReminder &&
        e1?.profileCompleted == e2?.profileCompleted &&
        listEquality.equals(e1?.activities, e2?.activities) &&
        e1?.profileLevel == e2?.profileLevel &&
        e1?.profilePercentage == e2?.profilePercentage &&
        e1?.userProfileTrip == e2?.userProfileTrip;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.gender,
        e?.homeCity,
        e?.dateOfBirth,
        e?.defaultReminder,
        e?.profileCompleted,
        const ListEquality().hash(e?.activities),
        e?.profileLevel,
        e?.profilePercentage,
        e?.userProfileTrip
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
