// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart' hide Type;

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// DSL struct CalendarStudioView
class CalendarStudioViewStruct extends FFFirebaseStruct {
  CalendarStudioViewStruct({
    /// CalendarStudioView.date
    String? date,

    /// CalendarStudioView.monthTitle
    String? monthTitle,

    /// CalendarStudioView.dayTitle
    String? dayTitle,

    /// CalendarStudioView.summary
    String? summary,

    /// CalendarStudioView.weeks
    List<CalendarStudioWeekStruct>? weeks,

    /// CalendarStudioView.bands
    List<CalendarStudioBandStruct>? bands,

    /// CalendarStudioView.hourLabels
    List<String>? hourLabels,

    /// CalendarStudioView.hourStep
    double? hourStep,

    /// CalendarStudioView.hourInset
    double? hourInset,

    /// CalendarStudioView.nowOffset
    double? nowOffset,

    /// CalendarStudioView.nowLabel
    String? nowLabel,

    /// CalendarStudioView.hasEvents
    bool? hasEvents,

    /// CalendarStudioView.sources
    List<CalendarStudioSourceStruct>? sources,

    /// CalendarStudioView.live
    bool? live,

    /// CalendarStudioView.connected
    bool? connected,

    /// CalendarStudioView.reconnect
    bool? reconnect,

    /// CalendarStudioView.message
    String? message,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _date = date,
        _monthTitle = monthTitle,
        _dayTitle = dayTitle,
        _summary = summary,
        _weeks = weeks,
        _bands = bands,
        _hourLabels = hourLabels,
        _hourStep = hourStep,
        _hourInset = hourInset,
        _nowOffset = nowOffset,
        _nowLabel = nowLabel,
        _hasEvents = hasEvents,
        _sources = sources,
        _live = live,
        _connected = connected,
        _reconnect = reconnect,
        _message = message,
        super(firestoreUtilData);

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "monthTitle" field.
  String? _monthTitle;
  String get monthTitle => _monthTitle ?? '';
  set monthTitle(String? val) => _monthTitle = val;

  bool hasMonthTitle() => _monthTitle != null;

  // "dayTitle" field.
  String? _dayTitle;
  String get dayTitle => _dayTitle ?? '';
  set dayTitle(String? val) => _dayTitle = val;

  bool hasDayTitle() => _dayTitle != null;

  // "summary" field.
  String? _summary;
  String get summary => _summary ?? '';
  set summary(String? val) => _summary = val;

  bool hasSummary() => _summary != null;

  // "weeks" field.
  List<CalendarStudioWeekStruct>? _weeks;
  List<CalendarStudioWeekStruct> get weeks => _weeks ?? const [];
  set weeks(List<CalendarStudioWeekStruct>? val) => _weeks = val;

  void updateWeeks(Function(List<CalendarStudioWeekStruct>) updateFn) {
    updateFn(_weeks ??= []);
  }

  bool hasWeeks() => _weeks != null;

  // "bands" field.
  List<CalendarStudioBandStruct>? _bands;
  List<CalendarStudioBandStruct> get bands => _bands ?? const [];
  set bands(List<CalendarStudioBandStruct>? val) => _bands = val;

  void updateBands(Function(List<CalendarStudioBandStruct>) updateFn) {
    updateFn(_bands ??= []);
  }

  bool hasBands() => _bands != null;

  // "hourLabels" field.
  List<String>? _hourLabels;
  List<String> get hourLabels => _hourLabels ?? const [];
  set hourLabels(List<String>? val) => _hourLabels = val;

  void updateHourLabels(Function(List<String>) updateFn) {
    updateFn(_hourLabels ??= []);
  }

  bool hasHourLabels() => _hourLabels != null;

  // "hourStep" field.
  double? _hourStep;
  double get hourStep => _hourStep ?? 0.0;
  set hourStep(double? val) => _hourStep = val;

  void incrementHourStep(double amount) => hourStep = hourStep + amount;

  bool hasHourStep() => _hourStep != null;

  // "hourInset" field.
  double? _hourInset;
  double get hourInset => _hourInset ?? 0.0;
  set hourInset(double? val) => _hourInset = val;

  void incrementHourInset(double amount) => hourInset = hourInset + amount;

  bool hasHourInset() => _hourInset != null;

  // "nowOffset" field.
  double? _nowOffset;
  double get nowOffset => _nowOffset ?? 0.0;
  set nowOffset(double? val) => _nowOffset = val;

  void incrementNowOffset(double amount) => nowOffset = nowOffset + amount;

  bool hasNowOffset() => _nowOffset != null;

  // "nowLabel" field.
  String? _nowLabel;
  String get nowLabel => _nowLabel ?? '';
  set nowLabel(String? val) => _nowLabel = val;

  bool hasNowLabel() => _nowLabel != null;

  // "hasEvents" field.
  bool? _hasEvents;
  bool get hasEvents => _hasEvents ?? false;
  set hasEvents(bool? val) => _hasEvents = val;

  bool hasHasEvents() => _hasEvents != null;

  // "sources" field.
  List<CalendarStudioSourceStruct>? _sources;
  List<CalendarStudioSourceStruct> get sources => _sources ?? const [];
  set sources(List<CalendarStudioSourceStruct>? val) => _sources = val;

  void updateSources(Function(List<CalendarStudioSourceStruct>) updateFn) {
    updateFn(_sources ??= []);
  }

  bool hasSources() => _sources != null;

  // "live" field.
  bool? _live;
  bool get live => _live ?? false;
  set live(bool? val) => _live = val;

  bool hasLive() => _live != null;

  // "connected" field.
  bool? _connected;
  bool get connected => _connected ?? false;
  set connected(bool? val) => _connected = val;

  bool hasConnected() => _connected != null;

  // "reconnect" field.
  bool? _reconnect;
  bool get reconnect => _reconnect ?? false;
  set reconnect(bool? val) => _reconnect = val;

  bool hasReconnect() => _reconnect != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  static CalendarStudioViewStruct fromMap(Map<String, dynamic> data) =>
      CalendarStudioViewStruct(
        date: data['date'] as String?,
        monthTitle: data['monthTitle'] as String?,
        dayTitle: data['dayTitle'] as String?,
        summary: data['summary'] as String?,
        weeks: getStructList(
          data['weeks'],
          CalendarStudioWeekStruct.fromMap,
        ),
        bands: getStructList(
          data['bands'],
          CalendarStudioBandStruct.fromMap,
        ),
        hourLabels: getDataList(data['hourLabels']),
        hourStep: castToType<double>(data['hourStep']),
        hourInset: castToType<double>(data['hourInset']),
        nowOffset: castToType<double>(data['nowOffset']),
        nowLabel: data['nowLabel'] as String?,
        hasEvents: data['hasEvents'] as bool?,
        sources: getStructList(
          data['sources'],
          CalendarStudioSourceStruct.fromMap,
        ),
        live: data['live'] as bool?,
        connected: data['connected'] as bool?,
        reconnect: data['reconnect'] as bool?,
        message: data['message'] as String?,
      );

  static CalendarStudioViewStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarStudioViewStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'date': _date,
        'monthTitle': _monthTitle,
        'dayTitle': _dayTitle,
        'summary': _summary,
        'weeks': _weeks?.map((e) => e.toMap()).toList(),
        'bands': _bands?.map((e) => e.toMap()).toList(),
        'hourLabels': _hourLabels,
        'hourStep': _hourStep,
        'hourInset': _hourInset,
        'nowOffset': _nowOffset,
        'nowLabel': _nowLabel,
        'hasEvents': _hasEvents,
        'sources': _sources?.map((e) => e.toMap()).toList(),
        'live': _live,
        'connected': _connected,
        'reconnect': _reconnect,
        'message': _message,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'monthTitle': serializeParam(
          _monthTitle,
          ParamType.String,
        ),
        'dayTitle': serializeParam(
          _dayTitle,
          ParamType.String,
        ),
        'summary': serializeParam(
          _summary,
          ParamType.String,
        ),
        'weeks': serializeParam(
          _weeks,
          ParamType.DataStruct,
          isList: true,
        ),
        'bands': serializeParam(
          _bands,
          ParamType.DataStruct,
          isList: true,
        ),
        'hourLabels': serializeParam(
          _hourLabels,
          ParamType.String,
          isList: true,
        ),
        'hourStep': serializeParam(
          _hourStep,
          ParamType.double,
        ),
        'hourInset': serializeParam(
          _hourInset,
          ParamType.double,
        ),
        'nowOffset': serializeParam(
          _nowOffset,
          ParamType.double,
        ),
        'nowLabel': serializeParam(
          _nowLabel,
          ParamType.String,
        ),
        'hasEvents': serializeParam(
          _hasEvents,
          ParamType.bool,
        ),
        'sources': serializeParam(
          _sources,
          ParamType.DataStruct,
          isList: true,
        ),
        'live': serializeParam(
          _live,
          ParamType.bool,
        ),
        'connected': serializeParam(
          _connected,
          ParamType.bool,
        ),
        'reconnect': serializeParam(
          _reconnect,
          ParamType.bool,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
      }.withoutNulls;

  static CalendarStudioViewStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      CalendarStudioViewStruct(
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        monthTitle: deserializeParam(
          data['monthTitle'],
          ParamType.String,
          false,
        ),
        dayTitle: deserializeParam(
          data['dayTitle'],
          ParamType.String,
          false,
        ),
        summary: deserializeParam(
          data['summary'],
          ParamType.String,
          false,
        ),
        weeks: deserializeStructParam<CalendarStudioWeekStruct>(
          data['weeks'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioWeekStruct.fromSerializableMap,
        ),
        bands: deserializeStructParam<CalendarStudioBandStruct>(
          data['bands'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioBandStruct.fromSerializableMap,
        ),
        hourLabels: deserializeParam<String>(
          data['hourLabels'],
          ParamType.String,
          true,
        ),
        hourStep: deserializeParam(
          data['hourStep'],
          ParamType.double,
          false,
        ),
        hourInset: deserializeParam(
          data['hourInset'],
          ParamType.double,
          false,
        ),
        nowOffset: deserializeParam(
          data['nowOffset'],
          ParamType.double,
          false,
        ),
        nowLabel: deserializeParam(
          data['nowLabel'],
          ParamType.String,
          false,
        ),
        hasEvents: deserializeParam(
          data['hasEvents'],
          ParamType.bool,
          false,
        ),
        sources: deserializeStructParam<CalendarStudioSourceStruct>(
          data['sources'],
          ParamType.DataStruct,
          true,
          structBuilder: CalendarStudioSourceStruct.fromSerializableMap,
        ),
        live: deserializeParam(
          data['live'],
          ParamType.bool,
          false,
        ),
        connected: deserializeParam(
          data['connected'],
          ParamType.bool,
          false,
        ),
        reconnect: deserializeParam(
          data['reconnect'],
          ParamType.bool,
          false,
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CalendarStudioViewStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CalendarStudioViewStruct &&
        date == other.date &&
        monthTitle == other.monthTitle &&
        dayTitle == other.dayTitle &&
        summary == other.summary &&
        listEquality.equals(weeks, other.weeks) &&
        listEquality.equals(bands, other.bands) &&
        listEquality.equals(hourLabels, other.hourLabels) &&
        hourStep == other.hourStep &&
        hourInset == other.hourInset &&
        nowOffset == other.nowOffset &&
        nowLabel == other.nowLabel &&
        hasEvents == other.hasEvents &&
        listEquality.equals(sources, other.sources) &&
        live == other.live &&
        connected == other.connected &&
        reconnect == other.reconnect &&
        message == other.message;
  }

  @override
  int get hashCode => const ListEquality().hash([
        date,
        monthTitle,
        dayTitle,
        summary,
        const ListEquality().hash(weeks),
        const ListEquality().hash(bands),
        const ListEquality().hash(hourLabels),
        hourStep,
        hourInset,
        nowOffset,
        nowLabel,
        hasEvents,
        const ListEquality().hash(sources),
        live,
        connected,
        reconnect,
        message
      ]);
}

CalendarStudioViewStruct createCalendarStudioViewStruct({
  String? date,
  String? monthTitle,
  String? dayTitle,
  String? summary,
  double? hourStep,
  double? hourInset,
  double? nowOffset,
  String? nowLabel,
  bool? hasEvents,
  bool? live,
  bool? connected,
  bool? reconnect,
  String? message,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    CalendarStudioViewStruct(
      date: date,
      monthTitle: monthTitle,
      dayTitle: dayTitle,
      summary: summary,
      hourStep: hourStep,
      hourInset: hourInset,
      nowOffset: nowOffset,
      nowLabel: nowLabel,
      hasEvents: hasEvents,
      live: live,
      connected: connected,
      reconnect: reconnect,
      message: message,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

CalendarStudioViewStruct? updateCalendarStudioViewStruct(
  CalendarStudioViewStruct? calendarStudioView, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    calendarStudioView
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addCalendarStudioViewStructData(
  Map<String, dynamic> firestoreData,
  CalendarStudioViewStruct? calendarStudioView,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (calendarStudioView == null) {
    return;
  }
  if (calendarStudioView.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && calendarStudioView.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final calendarStudioViewData =
      getCalendarStudioViewFirestoreData(calendarStudioView, forFieldValue);
  final nestedData =
      calendarStudioViewData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      calendarStudioView.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getCalendarStudioViewFirestoreData(
  CalendarStudioViewStruct? calendarStudioView, [
  bool forFieldValue = false,
]) {
  if (calendarStudioView == null) {
    return {};
  }
  final firestoreData = mapToFirestore(calendarStudioView.toMap());

  // Add any Firestore field values
  mapToFirestore(calendarStudioView.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getCalendarStudioViewListFirestoreData(
  List<CalendarStudioViewStruct>? calendarStudioViews,
) =>
    calendarStudioViews
        ?.map((e) => getCalendarStudioViewFirestoreData(e, true))
        .toList() ??
    [];
