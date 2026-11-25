// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct HomeTimelineTrip
class HomeTimelineTripStruct extends FFFirebaseStruct {
  HomeTimelineTripStruct({
    /// HomeTimelineTrip.id
    String? id,

    /// HomeTimelineTrip.listRef
    DocumentReference? listRef,

    /// HomeTimelineTrip.date
    DateTime? date,

    /// HomeTimelineTrip.allDay
    bool? allDay,

    /// HomeTimelineTrip.destination
    String? destination,

    /// HomeTimelineTrip.title
    String? title,

    /// HomeTimelineTrip.subtitle
    String? subtitle,

    /// HomeTimelineTrip.dateLabel
    String? dateLabel,

    /// HomeTimelineTrip.dayLabel
    String? dayLabel,

    /// HomeTimelineTrip.newDay
    bool? newDay,

    /// HomeTimelineTrip.hasNext
    bool? hasNext,

    /// HomeTimelineTrip.divider
    bool? divider,

    /// HomeTimelineTrip.localOnly
    bool? localOnly,

    /// HomeTimelineTrip.status
    String? status,

    /// HomeTimelineTrip.progressLabel
    String? progressLabel,

    /// HomeTimelineTrip.progress
    double? progress,

    /// HomeTimelineTrip.forecast
    HomeForecastStruct? forecast,

    /// HomeTimelineTrip.items
    List<HomeTimelineItemStruct>? items,
    int? dayIndex,
    String? dayStatus,
    bool? dayLocalOnly,
    String? dividerStatus,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _listRef = listRef,
        _date = date,
        _allDay = allDay,
        _destination = destination,
        _title = title,
        _subtitle = subtitle,
        _dateLabel = dateLabel,
        _dayLabel = dayLabel,
        _newDay = newDay,
        _hasNext = hasNext,
        _divider = divider,
        _localOnly = localOnly,
        _status = status,
        _progressLabel = progressLabel,
        _progress = progress,
        _forecast = forecast,
        _items = items,
        _dayIndex = dayIndex,
        _dayStatus = dayStatus,
        _dayLocalOnly = dayLocalOnly,
        _dividerStatus = dividerStatus,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "listRef" field.
  DocumentReference? _listRef;
  DocumentReference? get listRef => _listRef;
  set listRef(DocumentReference? val) => _listRef = val;

  bool hasListRef() => _listRef != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "allDay" field.
  bool? _allDay;
  bool get allDay => _allDay ?? false;
  set allDay(bool? val) => _allDay = val;

  bool hasAllDay() => _allDay != null;

  // "destination" field.
  String? _destination;
  String get destination => _destination ?? '';
  set destination(String? val) => _destination = val;

  bool hasDestination() => _destination != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  set subtitle(String? val) => _subtitle = val;

  bool hasSubtitle() => _subtitle != null;

  // "dateLabel" field.
  String? _dateLabel;
  String get dateLabel => _dateLabel ?? '';
  set dateLabel(String? val) => _dateLabel = val;

  bool hasDateLabel() => _dateLabel != null;

  // "dayLabel" field.
  String? _dayLabel;
  String get dayLabel => _dayLabel ?? '';
  set dayLabel(String? val) => _dayLabel = val;

  bool hasDayLabel() => _dayLabel != null;

  // "newDay" field.
  bool? _newDay;
  bool get newDay => _newDay ?? false;
  set newDay(bool? val) => _newDay = val;

  bool hasNewDay() => _newDay != null;

  // "hasNext" field.
  bool? _hasNext;
  bool get hasNext => _hasNext ?? false;
  set hasNext(bool? val) => _hasNext = val;

  bool hasHasNext() => _hasNext != null;

  // "divider" field.
  bool? _divider;
  bool get divider => _divider ?? false;
  set divider(bool? val) => _divider = val;

  bool hasDivider() => _divider != null;

  // "localOnly" field.
  bool? _localOnly;
  bool get localOnly => _localOnly ?? false;
  set localOnly(bool? val) => _localOnly = val;

  bool hasLocalOnly() => _localOnly != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "progressLabel" field.
  String? _progressLabel;
  String get progressLabel => _progressLabel ?? '';
  set progressLabel(String? val) => _progressLabel = val;

  bool hasProgressLabel() => _progressLabel != null;

  // "progress" field.
  double? _progress;
  double get progress => _progress ?? 0.0;
  set progress(double? val) => _progress = val;

  void incrementProgress(double amount) => progress = progress + amount;

  bool hasProgress() => _progress != null;

  // "forecast" field.
  HomeForecastStruct? _forecast;
  HomeForecastStruct get forecast => _forecast ?? HomeForecastStruct();
  set forecast(HomeForecastStruct? val) => _forecast = val;

  void updateForecast(Function(HomeForecastStruct) updateFn) {
    updateFn(_forecast ??= HomeForecastStruct());
  }

  bool hasForecast() => _forecast != null;

  // "items" field.
  List<HomeTimelineItemStruct>? _items;
  List<HomeTimelineItemStruct> get items => _items ?? const [];
  set items(List<HomeTimelineItemStruct>? val) => _items = val;

  void updateItems(Function(List<HomeTimelineItemStruct>) updateFn) {
    updateFn(_items ??= []);
  }

  bool hasItems() => _items != null;

  // "dayIndex" field.
  int? _dayIndex;
  int get dayIndex => _dayIndex ?? 0;
  set dayIndex(int? val) => _dayIndex = val;

  void incrementDayIndex(int amount) => dayIndex = dayIndex + amount;

  bool hasDayIndex() => _dayIndex != null;

  // "dayStatus" field.
  String? _dayStatus;
  String get dayStatus => _dayStatus ?? '';
  set dayStatus(String? val) => _dayStatus = val;

  bool hasDayStatus() => _dayStatus != null;

  // "dayLocalOnly" field.
  bool? _dayLocalOnly;
  bool get dayLocalOnly => _dayLocalOnly ?? false;
  set dayLocalOnly(bool? val) => _dayLocalOnly = val;

  bool hasDayLocalOnly() => _dayLocalOnly != null;

  // "dividerStatus" field.
  String? _dividerStatus;
  String get dividerStatus => _dividerStatus ?? '';
  set dividerStatus(String? val) => _dividerStatus = val;

  bool hasDividerStatus() => _dividerStatus != null;

  static HomeTimelineTripStruct fromMap(Map<String, dynamic> data) =>
      HomeTimelineTripStruct(
        id: data['id'] as String?,
        listRef: data['listRef'] as DocumentReference?,
        date: data['date'] as DateTime?,
        allDay: data['allDay'] as bool?,
        destination: data['destination'] as String?,
        title: data['title'] as String?,
        subtitle: data['subtitle'] as String?,
        dateLabel: data['dateLabel'] as String?,
        dayLabel: data['dayLabel'] as String?,
        newDay: data['newDay'] as bool?,
        hasNext: data['hasNext'] as bool?,
        divider: data['divider'] as bool?,
        localOnly: data['localOnly'] as bool?,
        status: data['status'] as String?,
        progressLabel: data['progressLabel'] as String?,
        progress: castToType<double>(data['progress']),
        forecast: data['forecast'] is HomeForecastStruct
            ? data['forecast']
            : HomeForecastStruct.maybeFromMap(data['forecast']),
        items: getStructList(
          data['items'],
          HomeTimelineItemStruct.fromMap,
        ),
        dayIndex: castToType<int>(data['dayIndex']),
        dayStatus: data['dayStatus'] as String?,
        dayLocalOnly: data['dayLocalOnly'] as bool?,
        dividerStatus: data['dividerStatus'] as String?,
      );

  static HomeTimelineTripStruct? maybeFromMap(dynamic data) => data is Map
      ? HomeTimelineTripStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'listRef': _listRef,
        'date': _date,
        'allDay': _allDay,
        'destination': _destination,
        'title': _title,
        'subtitle': _subtitle,
        'dateLabel': _dateLabel,
        'dayLabel': _dayLabel,
        'newDay': _newDay,
        'hasNext': _hasNext,
        'divider': _divider,
        'localOnly': _localOnly,
        'status': _status,
        'progressLabel': _progressLabel,
        'progress': _progress,
        'forecast': _forecast?.toMap(),
        'items': _items?.map((e) => e.toMap()).toList(),
        'dayIndex': _dayIndex,
        'dayStatus': _dayStatus,
        'dayLocalOnly': _dayLocalOnly,
        'dividerStatus': _dividerStatus,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'listRef': serializeParam(
          _listRef,
          ParamType.DocumentReference,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'allDay': serializeParam(
          _allDay,
          ParamType.bool,
        ),
        'destination': serializeParam(
          _destination,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'subtitle': serializeParam(
          _subtitle,
          ParamType.String,
        ),
        'dateLabel': serializeParam(
          _dateLabel,
          ParamType.String,
        ),
        'dayLabel': serializeParam(
          _dayLabel,
          ParamType.String,
        ),
        'newDay': serializeParam(
          _newDay,
          ParamType.bool,
        ),
        'hasNext': serializeParam(
          _hasNext,
          ParamType.bool,
        ),
        'divider': serializeParam(
          _divider,
          ParamType.bool,
        ),
        'localOnly': serializeParam(
          _localOnly,
          ParamType.bool,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'progressLabel': serializeParam(
          _progressLabel,
          ParamType.String,
        ),
        'progress': serializeParam(
          _progress,
          ParamType.double,
        ),
        'forecast': serializeParam(
          _forecast,
          ParamType.DataStruct,
        ),
        'items': serializeParam(
          _items,
          ParamType.DataStruct,
          isList: true,
        ),
        'dayIndex': serializeParam(
          _dayIndex,
          ParamType.int,
        ),
        'dayStatus': serializeParam(
          _dayStatus,
          ParamType.String,
        ),
        'dayLocalOnly': serializeParam(
          _dayLocalOnly,
          ParamType.bool,
        ),
        'dividerStatus': serializeParam(
          _dividerStatus,
          ParamType.String,
        ),
      }.withoutNulls;

  static HomeTimelineTripStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      HomeTimelineTripStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        listRef: deserializeParam(
          data['listRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users', 'packingLists'],
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        allDay: deserializeParam(
          data['allDay'],
          ParamType.bool,
          false,
        ),
        destination: deserializeParam(
          data['destination'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        subtitle: deserializeParam(
          data['subtitle'],
          ParamType.String,
          false,
        ),
        dateLabel: deserializeParam(
          data['dateLabel'],
          ParamType.String,
          false,
        ),
        dayLabel: deserializeParam(
          data['dayLabel'],
          ParamType.String,
          false,
        ),
        newDay: deserializeParam(
          data['newDay'],
          ParamType.bool,
          false,
        ),
        hasNext: deserializeParam(
          data['hasNext'],
          ParamType.bool,
          false,
        ),
        divider: deserializeParam(
          data['divider'],
          ParamType.bool,
          false,
        ),
        localOnly: deserializeParam(
          data['localOnly'],
          ParamType.bool,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        progressLabel: deserializeParam(
          data['progressLabel'],
          ParamType.String,
          false,
        ),
        progress: deserializeParam(
          data['progress'],
          ParamType.double,
          false,
        ),
        forecast: deserializeStructParam(
          data['forecast'],
          ParamType.DataStruct,
          false,
          structBuilder: HomeForecastStruct.fromSerializableMap,
        ),
        items: deserializeStructParam<HomeTimelineItemStruct>(
          data['items'],
          ParamType.DataStruct,
          true,
          structBuilder: HomeTimelineItemStruct.fromSerializableMap,
        ),
        dayIndex: deserializeParam(
          data['dayIndex'],
          ParamType.int,
          false,
        ),
        dayStatus: deserializeParam(
          data['dayStatus'],
          ParamType.String,
          false,
        ),
        dayLocalOnly: deserializeParam(
          data['dayLocalOnly'],
          ParamType.bool,
          false,
        ),
        dividerStatus: deserializeParam(
          data['dividerStatus'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'HomeTimelineTripStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is HomeTimelineTripStruct &&
        id == other.id &&
        listRef == other.listRef &&
        date == other.date &&
        allDay == other.allDay &&
        destination == other.destination &&
        title == other.title &&
        subtitle == other.subtitle &&
        dateLabel == other.dateLabel &&
        dayLabel == other.dayLabel &&
        newDay == other.newDay &&
        hasNext == other.hasNext &&
        divider == other.divider &&
        localOnly == other.localOnly &&
        status == other.status &&
        progressLabel == other.progressLabel &&
        progress == other.progress &&
        forecast == other.forecast &&
        listEquality.equals(items, other.items) &&
        dayIndex == other.dayIndex &&
        dayStatus == other.dayStatus &&
        dayLocalOnly == other.dayLocalOnly &&
        dividerStatus == other.dividerStatus;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        listRef,
        date,
        allDay,
        destination,
        title,
        subtitle,
        dateLabel,
        dayLabel,
        newDay,
        hasNext,
        divider,
        localOnly,
        status,
        progressLabel,
        progress,
        forecast,
        const ListEquality().hash(items),
        dayIndex,
        dayStatus,
        dayLocalOnly,
        dividerStatus
      ]);
}

HomeTimelineTripStruct createHomeTimelineTripStruct({
  String? id,
  DocumentReference? listRef,
  DateTime? date,
  bool? allDay,
  String? destination,
  String? title,
  String? subtitle,
  String? dateLabel,
  String? dayLabel,
  bool? newDay,
  bool? hasNext,
  bool? divider,
  bool? localOnly,
  String? status,
  String? progressLabel,
  double? progress,
  HomeForecastStruct? forecast,
  int? dayIndex,
  String? dayStatus,
  bool? dayLocalOnly,
  String? dividerStatus,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    HomeTimelineTripStruct(
      id: id,
      listRef: listRef,
      date: date,
      allDay: allDay,
      destination: destination,
      title: title,
      subtitle: subtitle,
      dateLabel: dateLabel,
      dayLabel: dayLabel,
      newDay: newDay,
      hasNext: hasNext,
      divider: divider,
      localOnly: localOnly,
      status: status,
      progressLabel: progressLabel,
      progress: progress,
      forecast: forecast ?? (clearUnsetFields ? HomeForecastStruct() : null),
      dayIndex: dayIndex,
      dayStatus: dayStatus,
      dayLocalOnly: dayLocalOnly,
      dividerStatus: dividerStatus,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

HomeTimelineTripStruct? updateHomeTimelineTripStruct(
  HomeTimelineTripStruct? homeTimelineTrip, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    homeTimelineTrip
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addHomeTimelineTripStructData(
  Map<String, dynamic> firestoreData,
  HomeTimelineTripStruct? homeTimelineTrip,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (homeTimelineTrip == null) {
    return;
  }
  if (homeTimelineTrip.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && homeTimelineTrip.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final homeTimelineTripData =
      getHomeTimelineTripFirestoreData(homeTimelineTrip, forFieldValue);
  final nestedData =
      homeTimelineTripData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = homeTimelineTrip.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getHomeTimelineTripFirestoreData(
  HomeTimelineTripStruct? homeTimelineTrip, [
  bool forFieldValue = false,
]) {
  if (homeTimelineTrip == null) {
    return {};
  }
  final firestoreData = mapToFirestore(homeTimelineTrip.toMap());

  // Handle nested data for "forecast" field.
  addHomeForecastStructData(
    firestoreData,
    homeTimelineTrip.hasForecast() ? homeTimelineTrip.forecast : null,
    'forecast',
    forFieldValue,
  );

  // Add any Firestore field values
  mapToFirestore(homeTimelineTrip.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getHomeTimelineTripListFirestoreData(
  List<HomeTimelineTripStruct>? homeTimelineTrips,
) =>
    homeTimelineTrips
        ?.map((e) => getHomeTimelineTripFirestoreData(e, true))
        .toList() ??
    [];
