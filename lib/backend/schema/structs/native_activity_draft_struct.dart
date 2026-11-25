// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct NativeActivityDraft
class NativeActivityDraftStruct extends FFFirebaseStruct {
  NativeActivityDraftStruct({
    /// NativeActivityDraft.ok
    bool? ok,

    /// NativeActivityDraft.name
    String? name,

    /// NativeActivityDraft.location
    String? location,

    /// NativeActivityDraft.activity
    String? activity,

    /// NativeActivityDraft.linked
    bool? linked,

    /// NativeActivityDraft.date
    DateTime? date,

    /// NativeActivityDraft.hasDate
    bool? hasDate,

    /// NativeActivityDraft.recurring
    bool? recurring,

    /// NativeActivityDraft.items
    List<PackItemStruct>? items,

    /// NativeActivityDraft.calendarTitle
    String? calendarTitle,

    /// NativeActivityDraft.calendarStart
    String? calendarStart,

    /// NativeActivityDraft.calendarEnd
    String? calendarEnd,

    /// NativeActivityDraft.calendarRepeat
    String? calendarRepeat,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ok = ok,
        _name = name,
        _location = location,
        _activity = activity,
        _linked = linked,
        _date = date,
        _hasDate = hasDate,
        _recurring = recurring,
        _items = items,
        _calendarTitle = calendarTitle,
        _calendarStart = calendarStart,
        _calendarEnd = calendarEnd,
        _calendarRepeat = calendarRepeat,
        super(firestoreUtilData);

  // "ok" field.
  bool? _ok;
  bool get ok => _ok ?? false;
  set ok(bool? val) => _ok = val;

  bool hasOk() => _ok != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "activity" field.
  String? _activity;
  String get activity => _activity ?? '';
  set activity(String? val) => _activity = val;

  bool hasActivity() => _activity != null;

  // "linked" field.
  bool? _linked;
  bool get linked => _linked ?? false;
  set linked(bool? val) => _linked = val;

  bool hasLinked() => _linked != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDateField() => _date != null;

  // "hasDate" field.
  bool? _hasDate;
  bool get hasDate => _hasDate ?? false;
  set hasDate(bool? val) => _hasDate = val;

  bool hasHasDate() => _hasDate != null;

  // "recurring" field.
  bool? _recurring;
  bool get recurring => _recurring ?? false;
  set recurring(bool? val) => _recurring = val;

  bool hasRecurring() => _recurring != null;

  // "items" field.
  List<PackItemStruct>? _items;
  List<PackItemStruct> get items => _items ?? const [];
  set items(List<PackItemStruct>? val) => _items = val;

  void updateItems(Function(List<PackItemStruct>) updateFn) {
    updateFn(_items ??= []);
  }

  bool hasItems() => _items != null;

  // "calendarTitle" field.
  String? _calendarTitle;
  String get calendarTitle => _calendarTitle ?? '';
  set calendarTitle(String? val) => _calendarTitle = val;

  bool hasCalendarTitle() => _calendarTitle != null;

  // "calendarStart" field.
  String? _calendarStart;
  String get calendarStart => _calendarStart ?? '';
  set calendarStart(String? val) => _calendarStart = val;

  bool hasCalendarStart() => _calendarStart != null;

  // "calendarEnd" field.
  String? _calendarEnd;
  String get calendarEnd => _calendarEnd ?? '';
  set calendarEnd(String? val) => _calendarEnd = val;

  bool hasCalendarEnd() => _calendarEnd != null;

  // "calendarRepeat" field.
  String? _calendarRepeat;
  String get calendarRepeat => _calendarRepeat ?? '';
  set calendarRepeat(String? val) => _calendarRepeat = val;

  bool hasCalendarRepeat() => _calendarRepeat != null;

  static NativeActivityDraftStruct fromMap(Map<String, dynamic> data) =>
      NativeActivityDraftStruct(
        ok: data['ok'] as bool?,
        name: data['name'] as String?,
        location: data['location'] as String?,
        activity: data['activity'] as String?,
        linked: data['linked'] as bool?,
        date: data['date'] as DateTime?,
        hasDate: data['hasDate'] as bool?,
        recurring: data['recurring'] as bool?,
        items: getStructList(
          data['items'],
          PackItemStruct.fromMap,
        ),
        calendarTitle: data['calendarTitle'] as String?,
        calendarStart: data['calendarStart'] as String?,
        calendarEnd: data['calendarEnd'] as String?,
        calendarRepeat: data['calendarRepeat'] as String?,
      );

  static NativeActivityDraftStruct? maybeFromMap(dynamic data) => data is Map
      ? NativeActivityDraftStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ok': _ok,
        'name': _name,
        'location': _location,
        'activity': _activity,
        'linked': _linked,
        'date': _date,
        'hasDate': _hasDate,
        'recurring': _recurring,
        'items': _items?.map((e) => e.toMap()).toList(),
        'calendarTitle': _calendarTitle,
        'calendarStart': _calendarStart,
        'calendarEnd': _calendarEnd,
        'calendarRepeat': _calendarRepeat,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ok': serializeParam(
          _ok,
          ParamType.bool,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'activity': serializeParam(
          _activity,
          ParamType.String,
        ),
        'linked': serializeParam(
          _linked,
          ParamType.bool,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'hasDate': serializeParam(
          _hasDate,
          ParamType.bool,
        ),
        'recurring': serializeParam(
          _recurring,
          ParamType.bool,
        ),
        'items': serializeParam(
          _items,
          ParamType.DataStruct,
          isList: true,
        ),
        'calendarTitle': serializeParam(
          _calendarTitle,
          ParamType.String,
        ),
        'calendarStart': serializeParam(
          _calendarStart,
          ParamType.String,
        ),
        'calendarEnd': serializeParam(
          _calendarEnd,
          ParamType.String,
        ),
        'calendarRepeat': serializeParam(
          _calendarRepeat,
          ParamType.String,
        ),
      }.withoutNulls;

  static NativeActivityDraftStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NativeActivityDraftStruct(
        ok: deserializeParam(
          data['ok'],
          ParamType.bool,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        activity: deserializeParam(
          data['activity'],
          ParamType.String,
          false,
        ),
        linked: deserializeParam(
          data['linked'],
          ParamType.bool,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        hasDate: deserializeParam(
          data['hasDate'],
          ParamType.bool,
          false,
        ),
        recurring: deserializeParam(
          data['recurring'],
          ParamType.bool,
          false,
        ),
        items: deserializeStructParam<PackItemStruct>(
          data['items'],
          ParamType.DataStruct,
          true,
          structBuilder: PackItemStruct.fromSerializableMap,
        ),
        calendarTitle: deserializeParam(
          data['calendarTitle'],
          ParamType.String,
          false,
        ),
        calendarStart: deserializeParam(
          data['calendarStart'],
          ParamType.String,
          false,
        ),
        calendarEnd: deserializeParam(
          data['calendarEnd'],
          ParamType.String,
          false,
        ),
        calendarRepeat: deserializeParam(
          data['calendarRepeat'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NativeActivityDraftStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NativeActivityDraftStruct &&
        ok == other.ok &&
        name == other.name &&
        location == other.location &&
        activity == other.activity &&
        linked == other.linked &&
        date == other.date &&
        hasDate == other.hasDate &&
        recurring == other.recurring &&
        listEquality.equals(items, other.items) &&
        calendarTitle == other.calendarTitle &&
        calendarStart == other.calendarStart &&
        calendarEnd == other.calendarEnd &&
        calendarRepeat == other.calendarRepeat;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ok,
        name,
        location,
        activity,
        linked,
        date,
        hasDate,
        recurring,
        const ListEquality().hash(items),
        calendarTitle,
        calendarStart,
        calendarEnd,
        calendarRepeat
      ]);
}

NativeActivityDraftStruct createNativeActivityDraftStruct({
  bool? ok,
  String? name,
  String? location,
  String? activity,
  bool? linked,
  DateTime? date,
  bool? hasDate,
  bool? recurring,
  String? calendarTitle,
  String? calendarStart,
  String? calendarEnd,
  String? calendarRepeat,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NativeActivityDraftStruct(
      ok: ok,
      name: name,
      location: location,
      activity: activity,
      linked: linked,
      date: date,
      hasDate: hasDate,
      recurring: recurring,
      calendarTitle: calendarTitle,
      calendarStart: calendarStart,
      calendarEnd: calendarEnd,
      calendarRepeat: calendarRepeat,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NativeActivityDraftStruct? updateNativeActivityDraftStruct(
  NativeActivityDraftStruct? nativeActivityDraft, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nativeActivityDraft
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNativeActivityDraftStructData(
  Map<String, dynamic> firestoreData,
  NativeActivityDraftStruct? nativeActivityDraft,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nativeActivityDraft == null) {
    return;
  }
  if (nativeActivityDraft.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nativeActivityDraft.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nativeActivityDraftData =
      getNativeActivityDraftFirestoreData(nativeActivityDraft, forFieldValue);
  final nestedData =
      nativeActivityDraftData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      nativeActivityDraft.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNativeActivityDraftFirestoreData(
  NativeActivityDraftStruct? nativeActivityDraft, [
  bool forFieldValue = false,
]) {
  if (nativeActivityDraft == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nativeActivityDraft.toMap());

  // Add any Firestore field values
  mapToFirestore(nativeActivityDraft.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNativeActivityDraftListFirestoreData(
  List<NativeActivityDraftStruct>? nativeActivityDrafts,
) =>
    nativeActivityDrafts
        ?.map((e) => getNativeActivityDraftFirestoreData(e, true))
        .toList() ??
    [];
