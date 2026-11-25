// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct PackReadyCalendarEvent
class PackReadyCalendarEventStruct extends FFFirebaseStruct {
  PackReadyCalendarEventStruct({
    /// PackReadyCalendarEvent.id
    String? id,

    /// PackReadyCalendarEvent.title
    String? title,

    /// PackReadyCalendarEvent.start
    String? start,

    /// PackReadyCalendarEvent.end
    String? end,

    /// PackReadyCalendarEvent.allDay
    bool? allDay,

    /// PackReadyCalendarEvent.location
    String? location,

    /// PackReadyCalendarEvent.recurrence
    List<String>? recurrence,

    /// PackReadyCalendarEvent.seriesId
    String? seriesId,
    String? provider,
    String? calendarId,
    String? calendarName,
    String? notes,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _title = title,
        _start = start,
        _end = end,
        _allDay = allDay,
        _location = location,
        _recurrence = recurrence,
        _seriesId = seriesId,
        _provider = provider,
        _calendarId = calendarId,
        _calendarName = calendarName,
        _notes = notes,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "start" field.
  String? _start;
  String get start => _start ?? '';
  set start(String? val) => _start = val;

  bool hasStart() => _start != null;

  // "end" field.
  String? _end;
  String get end => _end ?? '';
  set end(String? val) => _end = val;

  bool hasEnd() => _end != null;

  // "allDay" field.
  bool? _allDay;
  bool get allDay => _allDay ?? false;
  set allDay(bool? val) => _allDay = val;

  bool hasAllDay() => _allDay != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "recurrence" field.
  List<String>? _recurrence;
  List<String> get recurrence => _recurrence ?? const [];
  set recurrence(List<String>? val) => _recurrence = val;

  void updateRecurrence(Function(List<String>) updateFn) {
    updateFn(_recurrence ??= []);
  }

  bool hasRecurrence() => _recurrence != null;

  // "seriesId" field.
  String? _seriesId;
  String get seriesId => _seriesId ?? '';
  set seriesId(String? val) => _seriesId = val;

  bool hasSeriesId() => _seriesId != null;

  // "provider" field.
  String? _provider;
  String get provider => _provider ?? '';
  set provider(String? val) => _provider = val;

  bool hasProvider() => _provider != null;

  // "calendarId" field.
  String? _calendarId;
  String get calendarId => _calendarId ?? '';
  set calendarId(String? val) => _calendarId = val;

  bool hasCalendarId() => _calendarId != null;

  // "calendarName" field.
  String? _calendarName;
  String get calendarName => _calendarName ?? '';
  set calendarName(String? val) => _calendarName = val;

  bool hasCalendarName() => _calendarName != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  static PackReadyCalendarEventStruct fromMap(Map<String, dynamic> data) =>
      PackReadyCalendarEventStruct(
        id: data['id'] as String?,
        title: data['title'] as String?,
        start: data['start'] as String?,
        end: data['end'] as String?,
        allDay: data['allDay'] as bool?,
        location: data['location'] as String?,
        recurrence: getDataList(data['recurrence']),
        seriesId: data['seriesId'] as String?,
        provider: data['provider'] as String?,
        calendarId: data['calendarId'] as String?,
        calendarName: data['calendarName'] as String?,
        notes: data['notes'] as String?,
      );

  static PackReadyCalendarEventStruct? maybeFromMap(dynamic data) => data is Map
      ? PackReadyCalendarEventStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'start': _start,
        'end': _end,
        'allDay': _allDay,
        'location': _location,
        'recurrence': _recurrence,
        'seriesId': _seriesId,
        'provider': _provider,
        'calendarId': _calendarId,
        'calendarName': _calendarName,
        'notes': _notes,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'start': serializeParam(
          _start,
          ParamType.String,
        ),
        'end': serializeParam(
          _end,
          ParamType.String,
        ),
        'allDay': serializeParam(
          _allDay,
          ParamType.bool,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'recurrence': serializeParam(
          _recurrence,
          ParamType.String,
          isList: true,
        ),
        'seriesId': serializeParam(
          _seriesId,
          ParamType.String,
        ),
        'provider': serializeParam(
          _provider,
          ParamType.String,
        ),
        'calendarId': serializeParam(
          _calendarId,
          ParamType.String,
        ),
        'calendarName': serializeParam(
          _calendarName,
          ParamType.String,
        ),
        'notes': serializeParam(
          _notes,
          ParamType.String,
        ),
      }.withoutNulls;

  static PackReadyCalendarEventStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PackReadyCalendarEventStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        start: deserializeParam(
          data['start'],
          ParamType.String,
          false,
        ),
        end: deserializeParam(
          data['end'],
          ParamType.String,
          false,
        ),
        allDay: deserializeParam(
          data['allDay'],
          ParamType.bool,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        recurrence: deserializeParam<String>(
          data['recurrence'],
          ParamType.String,
          true,
        ),
        seriesId: deserializeParam(
          data['seriesId'],
          ParamType.String,
          false,
        ),
        provider: deserializeParam(
          data['provider'],
          ParamType.String,
          false,
        ),
        calendarId: deserializeParam(
          data['calendarId'],
          ParamType.String,
          false,
        ),
        calendarName: deserializeParam(
          data['calendarName'],
          ParamType.String,
          false,
        ),
        notes: deserializeParam(
          data['notes'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PackReadyCalendarEventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PackReadyCalendarEventStruct &&
        id == other.id &&
        title == other.title &&
        start == other.start &&
        end == other.end &&
        allDay == other.allDay &&
        location == other.location &&
        listEquality.equals(recurrence, other.recurrence) &&
        seriesId == other.seriesId &&
        provider == other.provider &&
        calendarId == other.calendarId &&
        calendarName == other.calendarName &&
        notes == other.notes;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        title,
        start,
        end,
        allDay,
        location,
        const ListEquality().hash(recurrence),
        seriesId,
        provider,
        calendarId,
        calendarName,
        notes
      ]);
}

PackReadyCalendarEventStruct createPackReadyCalendarEventStruct({
  String? id,
  String? title,
  String? start,
  String? end,
  bool? allDay,
  String? location,
  String? seriesId,
  String? provider,
  String? calendarId,
  String? calendarName,
  String? notes,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PackReadyCalendarEventStruct(
      id: id,
      title: title,
      start: start,
      end: end,
      allDay: allDay,
      location: location,
      seriesId: seriesId,
      provider: provider,
      calendarId: calendarId,
      calendarName: calendarName,
      notes: notes,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PackReadyCalendarEventStruct? updatePackReadyCalendarEventStruct(
  PackReadyCalendarEventStruct? packReadyCalendarEvent, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    packReadyCalendarEvent
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPackReadyCalendarEventStructData(
  Map<String, dynamic> firestoreData,
  PackReadyCalendarEventStruct? packReadyCalendarEvent,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (packReadyCalendarEvent == null) {
    return;
  }
  if (packReadyCalendarEvent.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      packReadyCalendarEvent.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final packReadyCalendarEventData = getPackReadyCalendarEventFirestoreData(
      packReadyCalendarEvent, forFieldValue);
  final nestedData =
      packReadyCalendarEventData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      packReadyCalendarEvent.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPackReadyCalendarEventFirestoreData(
  PackReadyCalendarEventStruct? packReadyCalendarEvent, [
  bool forFieldValue = false,
]) {
  if (packReadyCalendarEvent == null) {
    return {};
  }
  final firestoreData = mapToFirestore(packReadyCalendarEvent.toMap());

  // Add any Firestore field values
  mapToFirestore(packReadyCalendarEvent.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPackReadyCalendarEventListFirestoreData(
  List<PackReadyCalendarEventStruct>? packReadyCalendarEvents,
) =>
    packReadyCalendarEvents
        ?.map((e) => getPackReadyCalendarEventFirestoreData(e, true))
        .toList() ??
    [];
