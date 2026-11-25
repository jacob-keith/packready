// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct NativeAiSchedule
class NativeAiScheduleStruct extends FFFirebaseStruct {
  NativeAiScheduleStruct({
    /// NativeAiSchedule.ready
    bool? ready,

    /// NativeAiSchedule.linked
    bool? linked,

    /// NativeAiSchedule.hasCalendar
    bool? hasCalendar,

    /// NativeAiSchedule.title
    String? title,

    /// NativeAiSchedule.date
    DateTime? date,

    /// NativeAiSchedule.start
    DateTime? start,

    /// NativeAiSchedule.end
    DateTime? end,

    /// NativeAiSchedule.allDay
    bool? allDay,

    /// NativeAiSchedule.editableDay
    bool? editableDay,

    /// NativeAiSchedule.scheduleLabel
    String? scheduleLabel,

    /// NativeAiSchedule.exceptions
    List<String>? exceptions,

    /// NativeAiSchedule.location
    String? location,

    /// NativeAiSchedule.alsoSaveTemplate
    bool? alsoSaveTemplate,

    /// NativeAiSchedule.sample
    bool? sample,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _ready = ready,
        _linked = linked,
        _hasCalendar = hasCalendar,
        _title = title,
        _date = date,
        _start = start,
        _end = end,
        _allDay = allDay,
        _editableDay = editableDay,
        _scheduleLabel = scheduleLabel,
        _exceptions = exceptions,
        _location = location,
        _alsoSaveTemplate = alsoSaveTemplate,
        _sample = sample,
        super(firestoreUtilData);

  // "ready" field.
  bool? _ready;
  bool get ready => _ready ?? false;
  set ready(bool? val) => _ready = val;

  bool hasReady() => _ready != null;

  // "linked" field.
  bool? _linked;
  bool get linked => _linked ?? false;
  set linked(bool? val) => _linked = val;

  bool hasLinked() => _linked != null;

  // "hasCalendar" field.
  bool? _hasCalendar;
  bool get hasCalendar => _hasCalendar ?? false;
  set hasCalendar(bool? val) => _hasCalendar = val;

  bool hasHasCalendar() => _hasCalendar != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "start" field.
  DateTime? _start;
  DateTime? get start => _start;
  set start(DateTime? val) => _start = val;

  bool hasStart() => _start != null;

  // "end" field.
  DateTime? _end;
  DateTime? get end => _end;
  set end(DateTime? val) => _end = val;

  bool hasEnd() => _end != null;

  // "allDay" field.
  bool? _allDay;
  bool get allDay => _allDay ?? false;
  set allDay(bool? val) => _allDay = val;

  bool hasAllDay() => _allDay != null;

  // "editableDay" field.
  bool? _editableDay;
  bool get editableDay => _editableDay ?? false;
  set editableDay(bool? val) => _editableDay = val;

  bool hasEditableDay() => _editableDay != null;

  // "scheduleLabel" field.
  String? _scheduleLabel;
  String get scheduleLabel => _scheduleLabel ?? '';
  set scheduleLabel(String? val) => _scheduleLabel = val;

  bool hasScheduleLabel() => _scheduleLabel != null;

  // "exceptions" field.
  List<String>? _exceptions;
  List<String> get exceptions => _exceptions ?? const [];
  set exceptions(List<String>? val) => _exceptions = val;

  void updateExceptions(Function(List<String>) updateFn) {
    updateFn(_exceptions ??= []);
  }

  bool hasExceptions() => _exceptions != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "alsoSaveTemplate" field.
  bool? _alsoSaveTemplate;
  bool get alsoSaveTemplate => _alsoSaveTemplate ?? false;
  set alsoSaveTemplate(bool? val) => _alsoSaveTemplate = val;

  bool hasAlsoSaveTemplate() => _alsoSaveTemplate != null;

  // "sample" field.
  bool? _sample;
  bool get sample => _sample ?? false;
  set sample(bool? val) => _sample = val;

  bool hasSample() => _sample != null;

  static NativeAiScheduleStruct fromMap(Map<String, dynamic> data) =>
      NativeAiScheduleStruct(
        ready: data['ready'] as bool?,
        linked: data['linked'] as bool?,
        hasCalendar: data['hasCalendar'] as bool?,
        title: data['title'] as String?,
        date: data['date'] as DateTime?,
        start: data['start'] as DateTime?,
        end: data['end'] as DateTime?,
        allDay: data['allDay'] as bool?,
        editableDay: data['editableDay'] as bool?,
        scheduleLabel: data['scheduleLabel'] as String?,
        exceptions: getDataList(data['exceptions']),
        location: data['location'] as String?,
        alsoSaveTemplate: data['alsoSaveTemplate'] as bool?,
        sample: data['sample'] as bool?,
      );

  static NativeAiScheduleStruct? maybeFromMap(dynamic data) => data is Map
      ? NativeAiScheduleStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ready': _ready,
        'linked': _linked,
        'hasCalendar': _hasCalendar,
        'title': _title,
        'date': _date,
        'start': _start,
        'end': _end,
        'allDay': _allDay,
        'editableDay': _editableDay,
        'scheduleLabel': _scheduleLabel,
        'exceptions': _exceptions,
        'location': _location,
        'alsoSaveTemplate': _alsoSaveTemplate,
        'sample': _sample,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ready': serializeParam(
          _ready,
          ParamType.bool,
        ),
        'linked': serializeParam(
          _linked,
          ParamType.bool,
        ),
        'hasCalendar': serializeParam(
          _hasCalendar,
          ParamType.bool,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'start': serializeParam(
          _start,
          ParamType.DateTime,
        ),
        'end': serializeParam(
          _end,
          ParamType.DateTime,
        ),
        'allDay': serializeParam(
          _allDay,
          ParamType.bool,
        ),
        'editableDay': serializeParam(
          _editableDay,
          ParamType.bool,
        ),
        'scheduleLabel': serializeParam(
          _scheduleLabel,
          ParamType.String,
        ),
        'exceptions': serializeParam(
          _exceptions,
          ParamType.String,
          isList: true,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'alsoSaveTemplate': serializeParam(
          _alsoSaveTemplate,
          ParamType.bool,
        ),
        'sample': serializeParam(
          _sample,
          ParamType.bool,
        ),
      }.withoutNulls;

  static NativeAiScheduleStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NativeAiScheduleStruct(
        ready: deserializeParam(
          data['ready'],
          ParamType.bool,
          false,
        ),
        linked: deserializeParam(
          data['linked'],
          ParamType.bool,
          false,
        ),
        hasCalendar: deserializeParam(
          data['hasCalendar'],
          ParamType.bool,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        start: deserializeParam(
          data['start'],
          ParamType.DateTime,
          false,
        ),
        end: deserializeParam(
          data['end'],
          ParamType.DateTime,
          false,
        ),
        allDay: deserializeParam(
          data['allDay'],
          ParamType.bool,
          false,
        ),
        editableDay: deserializeParam(
          data['editableDay'],
          ParamType.bool,
          false,
        ),
        scheduleLabel: deserializeParam(
          data['scheduleLabel'],
          ParamType.String,
          false,
        ),
        exceptions: deserializeParam<String>(
          data['exceptions'],
          ParamType.String,
          true,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        alsoSaveTemplate: deserializeParam(
          data['alsoSaveTemplate'],
          ParamType.bool,
          false,
        ),
        sample: deserializeParam(
          data['sample'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'NativeAiScheduleStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is NativeAiScheduleStruct &&
        ready == other.ready &&
        linked == other.linked &&
        hasCalendar == other.hasCalendar &&
        title == other.title &&
        date == other.date &&
        start == other.start &&
        end == other.end &&
        allDay == other.allDay &&
        editableDay == other.editableDay &&
        scheduleLabel == other.scheduleLabel &&
        listEquality.equals(exceptions, other.exceptions) &&
        location == other.location &&
        alsoSaveTemplate == other.alsoSaveTemplate &&
        sample == other.sample;
  }

  @override
  int get hashCode => const ListEquality().hash([
        ready,
        linked,
        hasCalendar,
        title,
        date,
        start,
        end,
        allDay,
        editableDay,
        scheduleLabel,
        const ListEquality().hash(exceptions),
        location,
        alsoSaveTemplate,
        sample
      ]);
}

NativeAiScheduleStruct createNativeAiScheduleStruct({
  bool? ready,
  bool? linked,
  bool? hasCalendar,
  String? title,
  DateTime? date,
  DateTime? start,
  DateTime? end,
  bool? allDay,
  bool? editableDay,
  String? scheduleLabel,
  String? location,
  bool? alsoSaveTemplate,
  bool? sample,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    NativeAiScheduleStruct(
      ready: ready,
      linked: linked,
      hasCalendar: hasCalendar,
      title: title,
      date: date,
      start: start,
      end: end,
      allDay: allDay,
      editableDay: editableDay,
      scheduleLabel: scheduleLabel,
      location: location,
      alsoSaveTemplate: alsoSaveTemplate,
      sample: sample,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

NativeAiScheduleStruct? updateNativeAiScheduleStruct(
  NativeAiScheduleStruct? nativeAiSchedule, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    nativeAiSchedule
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addNativeAiScheduleStructData(
  Map<String, dynamic> firestoreData,
  NativeAiScheduleStruct? nativeAiSchedule,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (nativeAiSchedule == null) {
    return;
  }
  if (nativeAiSchedule.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && nativeAiSchedule.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final nativeAiScheduleData =
      getNativeAiScheduleFirestoreData(nativeAiSchedule, forFieldValue);
  final nestedData =
      nativeAiScheduleData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = nativeAiSchedule.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getNativeAiScheduleFirestoreData(
  NativeAiScheduleStruct? nativeAiSchedule, [
  bool forFieldValue = false,
]) {
  if (nativeAiSchedule == null) {
    return {};
  }
  final firestoreData = mapToFirestore(nativeAiSchedule.toMap());

  // Add any Firestore field values
  mapToFirestore(nativeAiSchedule.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getNativeAiScheduleListFirestoreData(
  List<NativeAiScheduleStruct>? nativeAiSchedules,
) =>
    nativeAiSchedules
        ?.map((e) => getNativeAiScheduleFirestoreData(e, true))
        .toList() ??
    [];
