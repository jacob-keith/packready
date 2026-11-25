// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioCard
class CalendarStudioCardStruct extends FFFirebaseStruct {
  CalendarStudioCardStruct({
    /// CalendarStudioCard.title
    String? title,

    /// CalendarStudioCard.eventKey
    String? eventKey,

    /// CalendarStudioCard.standalone
    bool? standalone,

    /// CalendarStudioCard.path
    String? path,

    /// CalendarStudioCard.status
    String? status,

    /// CalendarStudioCard.needsPacking
    bool? needsPacking,

    /// CalendarStudioCard.showProgress
    bool? showProgress,

    /// CalendarStudioCard.progress
    String? progress,

    /// CalendarStudioCard.allDay
    bool? allDay,

    /// CalendarStudioCard.height
    double? height,

    /// CalendarStudioCard.gap
    double? gap,

    /// CalendarStudioCard.subtitle
    String? subtitle,

    /// CalendarStudioCard.source
    String? source,

    /// CalendarStudioCard.dateLabel
    String? dateLabel,

    /// CalendarStudioCard.location
    String? location,

    /// CalendarStudioCard.notes
    String? notes,

    /// CalendarStudioCard.repeats
    bool? repeats,

    /// CalendarStudioCard.repeatLabel
    String? repeatLabel,

    /// CalendarStudioCard.lists
    List<CalendarStudioListStruct>? lists,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _eventKey = eventKey,
        _standalone = standalone,
        _path = path,
        _status = status,
        _needsPacking = needsPacking,
        _showProgress = showProgress,
        _progress = progress,
        _allDay = allDay,
        _height = height,
        _gap = gap,
        _subtitle = subtitle,
        _source = source,
        _dateLabel = dateLabel,
        _location = location,
        _notes = notes,
        _repeats = repeats,
        _repeatLabel = repeatLabel,
        _lists = lists,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "eventKey" field.
  String? _eventKey;
  String get eventKey => _eventKey ?? '';
  set eventKey(String? val) => _eventKey = val;

  bool hasEventKey() => _eventKey != null;

  // "standalone" field.
  bool? _standalone;
  bool get standalone => _standalone ?? false;
  set standalone(bool? val) => _standalone = val;

  bool hasStandalone() => _standalone != null;

  // "path" field.
  String? _path;
  String get path => _path ?? '';
  set path(String? val) => _path = val;

  bool hasPath() => _path != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "needsPacking" field.
  bool? _needsPacking;
  bool get needsPacking => _needsPacking ?? false;
  set needsPacking(bool? val) => _needsPacking = val;

  bool hasNeedsPacking() => _needsPacking != null;

  // "showProgress" field.
  bool? _showProgress;
  bool get showProgress => _showProgress ?? false;
  set showProgress(bool? val) => _showProgress = val;

  bool hasShowProgress() => _showProgress != null;

  // "progress" field.
  String? _progress;
  String get progress => _progress ?? '';
  set progress(String? val) => _progress = val;

  bool hasProgress() => _progress != null;

  // "allDay" field.
  bool? _allDay;
  bool get allDay => _allDay ?? false;
  set allDay(bool? val) => _allDay = val;

  bool hasAllDay() => _allDay != null;

  // "height" field.
  double? _height;
  double get height => _height ?? 0.0;
  set height(double? val) => _height = val;

  void incrementHeight(double amount) => height = height + amount;

  bool hasHeight() => _height != null;

  // "gap" field.
  double? _gap;
  double get gap => _gap ?? 0.0;
  set gap(double? val) => _gap = val;

  void incrementGap(double amount) => gap = gap + amount;

  bool hasGap() => _gap != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  set subtitle(String? val) => _subtitle = val;

  bool hasSubtitle() => _subtitle != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;

  // "dateLabel" field.
  String? _dateLabel;
  String get dateLabel => _dateLabel ?? '';
  set dateLabel(String? val) => _dateLabel = val;

  bool hasDateLabel() => _dateLabel != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  // "repeats" field.
  bool? _repeats;
  bool get repeats => _repeats ?? false;
  set repeats(bool? val) => _repeats = val;

  bool hasRepeats() => _repeats != null;

  // "repeatLabel" field.
  String? _repeatLabel;
  String get repeatLabel => _repeatLabel ?? '';
  set repeatLabel(String? val) => _repeatLabel = val;

  bool hasRepeatLabel() => _repeatLabel != null;

  // "lists" field.
  List<CalendarStudioListStruct>? _lists;
  List<CalendarStudioListStruct> get lists => _lists ?? const [];
  set lists(List<CalendarStudioListStruct>? val) => _lists = val;

  void updateLists(Function(List<CalendarStudioListStruct>) updateFn) {
    updateFn(_lists ??= []);
  }

  bool hasLists() => _lists != null;

  static CalendarStudioCardStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioCardStruct(
        title: data['title'] as String?,
        eventKey: data['eventKey'] as String?,
        standalone: data['standalone'] as bool?,
        path: data['path'] as String?,
        status: data['status'] as String?,
        needsPacking: data['needsPacking'] as bool?,
        showProgress: data['showProgress'] as bool?,
        progress: data['progress'] as String?,
        allDay: data['allDay'] as bool?,
        height: castToType<double>(data['height']),
        gap: castToType<double>(data['gap']),
        subtitle: data['subtitle'] as String?,
        source: data['source'] as String?,
        dateLabel: data['dateLabel'] as String?,
        location: data['location'] as String?,
        notes: data['notes'] as String?,
        repeats: data['repeats'] as bool?,
        repeatLabel: data['repeatLabel'] as String?,
        lists: getStructList(
          data['lists'],
          CalendarStudioListStruct.fromMap,
        ),
      );

  static CalendarStudioCardStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioCardStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'eventKey': _eventKey,
        'standalone': _standalone,
        'path': _path,
        'status': _status,
        'needsPacking': _needsPacking,
        'showProgress': _showProgress,
        'progress': _progress,
        'allDay': _allDay,
        'height': _height,
        'gap': _gap,
        'subtitle': _subtitle,
        'source': _source,
        'dateLabel': _dateLabel,
        'location': _location,
        'notes': _notes,
        'repeats': _repeats,
        'repeatLabel': _repeatLabel,
        'lists': _lists?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'eventKey': serializeParam(
          _eventKey,
          ParamType.String,
        ),
        'standalone': serializeParam(
          _standalone,
          ParamType.bool,
        ),
        'path': serializeParam(
          _path,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'needsPacking': serializeParam(
          _needsPacking,
          ParamType.bool,
        ),
        'showProgress': serializeParam(
          _showProgress,
          ParamType.bool,
        ),
        'progress': serializeParam(
          _progress,
          ParamType.String,
        ),
        'allDay': serializeParam(
          _allDay,
          ParamType.bool,
        ),
        'height': serializeParam(
          _height,
          ParamType.double,
        ),
        'gap': serializeParam(
          _gap,
          ParamType.double,
        ),
        'subtitle': serializeParam(
          _subtitle,
          ParamType.String,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'dateLabel': serializeParam(
          _dateLabel,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'notes': serializeParam(
          _notes,
          ParamType.String,
        ),
        'repeats': serializeParam(
          _repeats,
          ParamType.bool,
        ),
        'repeatLabel': serializeParam(
          _repeatLabel,
          ParamType.String,
        ),
        'lists': serializeParam(
          _lists,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static CalendarStudioCardStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioCardStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        eventKey: deserializeParam(
          data['eventKey'],
          ParamType.String,
          false,
        ),
        standalone: deserializeParam(
          data['standalone'],
          ParamType.bool,
          false,
        ),
        path: deserializeParam(
          data['path'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        needsPacking: deserializeParam(
          data['needsPacking'],
          ParamType.bool,
          false,
        ),
        showProgress: deserializeParam(
          data['showProgress'],
          ParamType.bool,
          false,
        ),
        progress: deserializeParam(
          data['progress'],
          ParamType.String,
          false,
        ),
        allDay: deserializeParam(
          data['allDay'],
          ParamType.bool,
          false,
        ),
        height: deserializeParam(
          data['height'],
          ParamType.double,
          false,
        ),
        gap: deserializeParam(
          data['gap'],
          ParamType.double,
          false,
        ),
        subtitle: deserializeParam(
          data['subtitle'],
          ParamType.String,
          false,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        dateLabel: deserializeParam(
          data['dateLabel'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        notes: deserializeParam(
          data['notes'],
          ParamType.String,
          false,
        ),
        repeats: deserializeParam(
          data['repeats'],
          ParamType.bool,
          false,
        ),
        repeatLabel: deserializeParam(
          data['repeatLabel'],
          ParamType.String,
          false,
        ),
        lists: deserializeStructParam<CalendarStudioListStruct>(
          data['lists'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioListStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CalendarStudioCardStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CalendarStudioCardStruct &&
        title == other.title &&
        eventKey == other.eventKey &&
        standalone == other.standalone &&
        path == other.path &&
        status == other.status &&
        needsPacking == other.needsPacking &&
        showProgress == other.showProgress &&
        progress == other.progress &&
        allDay == other.allDay &&
        height == other.height &&
        gap == other.gap &&
        subtitle == other.subtitle &&
        source == other.source &&
        dateLabel == other.dateLabel &&
        location == other.location &&
        notes == other.notes &&
        repeats == other.repeats &&
        repeatLabel == other.repeatLabel &&
        listEquality.equals(lists, other.lists);
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        eventKey,
        standalone,
        path,
        status,
        needsPacking,
        showProgress,
        progress,
        allDay,
        height,
        gap,
        subtitle,
        source,
        dateLabel,
        location,
        notes,
        repeats,
        repeatLabel,
        const ListEquality().hash(lists)
      ]);
}

CalendarStudioCardStruct createCalendarStudioCardStruct({
  String? title,
  String? eventKey,
  bool? standalone,
  String? path,
  String? status,
  bool? needsPacking,
  bool? showProgress,
  String? progress,
  bool? allDay,
  double? height,
  double? gap,
  String? subtitle,
  String? source,
  String? dateLabel,
  String? location,
  String? notes,
  bool? repeats,
  String? repeatLabel,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioCardStruct(
      title: title,
      eventKey: eventKey,
      standalone: standalone,
      path: path,
      status: status,
      needsPacking: needsPacking,
      showProgress: showProgress,
      progress: progress,
      allDay: allDay,
      height: height,
      gap: gap,
      subtitle: subtitle,
      source: source,
      dateLabel: dateLabel,
      location: location,
      notes: notes,
      repeats: repeats,
      repeatLabel: repeatLabel,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioCardStruct? updateCalendarStudioCardStruct(
  CalendarStudioCardStruct? calendarStudioCard, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioCard
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioCardStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioCardStruct? calendarStudioCard,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioCard == null) {
    return;
  }
  if (calendarStudioCard.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioCard.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioCardData =
      getCalendarStudioCardFirestoreData(calendarStudioCard, forFieldValue);
  final nestedData =
      calendarStudioCardData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioCard.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioCardFirestoreData(
  CalendarStudioCardStruct? calendarStudioCard, [
  bool forFieldValue = false,
]) {
  if (calendarStudioCard == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioCard.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioCard.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioCardListFirestoreData(
  List<CalendarStudioCardStruct>? calendarStudioCards,
) =>
    calendarStudioCards
        ?.map((e) => getCalendarStudioCardFirestoreData(e, true))
        .toList() ??
    [];
