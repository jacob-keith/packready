// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioDay
class CalendarStudioDayStruct extends FFFirebaseStruct {
  CalendarStudioDayStruct({
    /// CalendarStudioDay.date
    String? date,

    /// CalendarStudioDay.label
    String? label,

    /// CalendarStudioDay.weekday
    String? weekday,

    /// CalendarStudioDay.selected
    bool? selected,

    /// CalendarStudioDay.today
    bool? today,

    /// CalendarStudioDay.outside
    bool? outside,

    /// CalendarStudioDay.standalone
    bool? standalone,

    /// CalendarStudioDay.status
    String? status,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _label = label,
        _weekday = weekday,
        _selected = selected,
        _today = today,
        _outside = outside,
        _standalone = standalone,
        _status = status,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "label" field.
  String? _label;
  String get label => _label ?? '';
  set label(String? val) => _label = val;

  bool hasLabel() => _label != null;

  // "weekday" field.
  String? _weekday;
  String get weekday => _weekday ?? '';
  set weekday(String? val) => _weekday = val;

  bool hasWeekday() => _weekday != null;

  // "selected" field.
  bool? _selected;
  bool get selected => _selected ?? false;
  set selected(bool? val) => _selected = val;

  bool hasSelected() => _selected != null;

  // "today" field.
  bool? _today;
  bool get today => _today ?? false;
  set today(bool? val) => _today = val;

  bool hasToday() => _today != null;

  // "outside" field.
  bool? _outside;
  bool get outside => _outside ?? false;
  set outside(bool? val) => _outside = val;

  bool hasOutside() => _outside != null;

  // "standalone" field.
  bool? _standalone;
  bool get standalone => _standalone ?? false;
  set standalone(bool? val) => _standalone = val;

  bool hasStandalone() => _standalone != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static CalendarStudioDayStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioDayStruct(
        date: data['date'] as String?,
        label: data['label'] as String?,
        weekday: data['weekday'] as String?,
        selected: data['selected'] as bool?,
        today: data['today'] as bool?,
        outside: data['outside'] as bool?,
        standalone: data['standalone'] as bool?,
        status: data['status'] as String?,
      );

  static CalendarStudioDayStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioDayStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'label': _label,
        'weekday': _weekday,
        'selected': _selected,
        'today': _today,
        'outside': _outside,
        'standalone': _standalone,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'label': serializeParam(
          _label,
          ParamType.String,
        ),
        'weekday': serializeParam(
          _weekday,
          ParamType.String,
        ),
        'selected': serializeParam(
          _selected,
          ParamType.bool,
        ),
        'today': serializeParam(
          _today,
          ParamType.bool,
        ),
        'outside': serializeParam(
          _outside,
          ParamType.bool,
        ),
        'standalone': serializeParam(
          _standalone,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static CalendarStudioDayStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioDayStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        label: deserializeParam(
          data['label'],
          ParamType.String,
          false,
        ),
        weekday: deserializeParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
        selected: deserializeParam(
          data['selected'],
          ParamType.bool,
          false,
        ),
        today: deserializeParam(
          data['today'],
          ParamType.bool,
          false,
        ),
        outside: deserializeParam(
          data['outside'],
          ParamType.bool,
          false,
        ),
        standalone: deserializeParam(
          data['standalone'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CalendarStudioDayStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalendarStudioDayStruct &&
        date == other.date &&
        label == other.label &&
        weekday == other.weekday &&
        selected == other.selected &&
        today == other.today &&
        outside == other.outside &&
        standalone == other.standalone &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [date, label, weekday, selected, today, outside, standalone, status]);
}

CalendarStudioDayStruct createCalendarStudioDayStruct({
  String? date,
  String? label,
  String? weekday,
  bool? selected,
  bool? today,
  bool? outside,
  bool? standalone,
  String? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioDayStruct(
      date: date,
      label: label,
      weekday: weekday,
      selected: selected,
      today: today,
      outside: outside,
      standalone: standalone,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioDayStruct? updateCalendarStudioDayStruct(
  CalendarStudioDayStruct? calendarStudioDay, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioDay
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioDayStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioDayStruct? calendarStudioDay,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioDay == null) {
    return;
  }
  if (calendarStudioDay.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioDay.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioDayData =
      getCalendarStudioDayFirestoreData(calendarStudioDay, forFieldValue);
  final nestedData =
      calendarStudioDayData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = calendarStudioDay.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioDayFirestoreData(
  CalendarStudioDayStruct? calendarStudioDay, [
  bool forFieldValue = false,
]) {
  if (calendarStudioDay == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioDay.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioDay.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioDayListFirestoreData(
  List<CalendarStudioDayStruct>? calendarStudioDays,
) =>
    calendarStudioDays
        ?.map((e) => getCalendarStudioDayFirestoreData(e, true))
        .toList() ??
    [];
