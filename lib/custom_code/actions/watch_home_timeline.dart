// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/load_home_forecast.dart';
import '/custom_code/actions/reveal_home_week.dart';
import '/custom_code/widgets/calendar_event_list.dart'
    show
        PackReadyTimelineEntry,
        acknowledgeCalendarActivity,
        calendarActivityTitles,
        ensureCalendarSessionLoaded,
        isPackReadyOnlyActivity,
        lastCalendarActivity,
        packReadyPackingStatusForLists,
        packReadyTimelineEntries;

VoidCallback? _stopHomeTimeline;
DocumentReference? _homeOwner;
int _selectedHomeTripIndex = -1;

Future<void> watchHomeTimeline(BuildContext context, bool active) async {
  if (!active) return;
  final lifetime = ModalRoute.of(context)?.popped;
  if (lifetime == null) return;
  _stopHomeTimeline?.call();

  final state = FFAppState();
  StreamSubscription<User?>? auth;
  StreamSubscription<QuerySnapshot>? subscription;
  List<PackingListsRecord>? records;
  var stopped = false;

  void publishStatus(String status) {
    if (stopped || !context.mounted) return;
    _selectedHomeTripIndex = -1;
    state.update(() {
      state.homeTimelineStatus = status;
      state.homeTimelineTrips = [];
      state.homeTimelineDays = [];
      state.homeInitialTripIndex = 0;
      state.homeCarouselAnchor = '';
      state.homeNextTripIndex = -1;
    });
  }

  void publishTrips() {
    final lists = records;
    if (stopped || !context.mounted || lists == null) return;
    final entries = packReadyTimelineEntries(lists);
    final previous = state.homeTimelineTrips;
    final selected = _selectedHomeTripIndex;
    final retained = selected >= 0 && selected < previous.length
        ? previous[selected].id
        : null;
    final next = entries.indexWhere(
      (trip) => !trip.date.isBefore(DateTime.now()),
    );
    final wasDefault = selected == state.homeNextTripIndex ||
        (state.homeNextTripIndex < 0 && selected == previous.length - 1);
    var selection = retained == null || wasDefault
        ? -1
        : entries.indexWhere((trip) => trip.id == retained);
    final saved = lastCalendarActivity;
    if (saved != null) {
      final matching = entries.indexWhere(
        (trip) =>
            trip.record.reference == saved &&
            _sameHomeDay(trip.date, trip.record.leaveDate?.toLocal()),
      );
      final first = matching >= 0
          ? matching
          : entries.indexWhere((trip) => trip.record.reference == saved);
      if (first >= 0) {
        selection = first;
        acknowledgeCalendarActivity(saved);
      }
    }
    if (selection < 0) selection = next >= 0 ? next : entries.length - 1;
    final firstDay =
        entries.isEmpty ? 0 : _homeDayNumber(entries.first.date) - 3;
    final lastDay =
        entries.isEmpty ? -1 : _homeDayNumber(entries.last.date) + 3;
    final recordsByDay = <int, List<PackingListsRecord>>{};
    final firstTripByDay = <int, int>{};
    for (var i = 0; i < entries.length; i++) {
      final day = _homeDayNumber(entries[i].date);
      (recordsByDay[day] ??= []).add(entries[i].record);
      firstTripByDay.putIfAbsent(day, () => i);
    }
    final statuses = {
      for (final entry in recordsByDay.entries)
        entry.key: packReadyPackingStatusForLists(entry.value)?.name ?? '',
    };
    final localDays = {
      for (final entry in recordsByDay.entries)
        if (entry.value.any(isPackReadyOnlyActivity)) entry.key,
    };
    final days = [
      for (var day = firstDay; day <= lastDay; day++)
        _homeDayRow(
          day,
          firstTripByDay[day] ?? -1,
          statuses[day] ?? '',
          localDays.contains(day),
        ),
    ];
    final old = {for (final trip in previous) trip.id: trip};
    final rows = <HomeTimelineTripStruct>[];
    for (var i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final day = _homeDayNumber(entry.date);
      final nextDay =
          i + 1 < entries.length ? _homeDayNumber(entries[i + 1].date) : day;
      rows.add(
        _homeTrip(
          entry,
          old: old[entry.id],
          newDay: i > 0 && !_sameHomeDay(entry.date, entries[i - 1].date),
          hasNext: i + 1 < entries.length,
          dayIndex: day - firstDay,
          dayStatus: statuses[day]!,
          dayLocalOnly: localDays.contains(day),
          divider: nextDay != day,
          dividerStatus: statuses[nextDay]!,
        ),
      );
    }
    _selectedHomeTripIndex = selection;
    state.update(() {
      state.homeTimelineStatus = 'ready';
      state.homeTimelineTrips = rows;
      state.homeTimelineDays = days;
      state.homeNextTripIndex = next;
      if (selection >= 0 &&
          (previous.isEmpty ||
              selection != selected ||
              entries[selection].id != retained)) {
        state.homeInitialTripIndex = selection;
        state.homeCarouselAnchor =
            '${DateTime.now().microsecondsSinceEpoch}:$selection:${entries[selection].id}';
      }
    });
    if (selection >= 0) {
      unawaited(revealHomeWeek(context, rows[selection].dayIndex, false));
      unawaited(selectHomeTimelineIndex(selection));
    }
  }

  void watch(DocumentReference? owner) {
    subscription?.cancel();
    _homeOwner = owner;
    records = null;
    if (owner == null) {
      publishStatus('signedOut');
      return;
    }
    publishStatus('loading');
    ensureCalendarSessionLoaded(owner);
    subscription = PackingListsRecord.collection(owner)
        .orderBy('leaveDate')
        .snapshots()
        .listen(
      (snapshot) {
        if (stopped || owner != _homeOwner) return;
        records = snapshot.docs
            .map(PackingListsRecord.fromSnapshot)
            .where((trip) => trip.leaveDate != null)
            .toList();
        publishTrips();
      },
      onError: (Object _) {
        if (stopped || owner != _homeOwner) return;
        records = null;
        publishStatus('error');
      },
    );
  }

  void stop() {
    stopped = true;
    calendarActivityTitles.removeListener(publishTrips);
    subscription?.cancel();
    auth?.cancel();
  }

  _stopHomeTimeline = stop;
  calendarActivityTitles.addListener(publishTrips);
  unawaited(
    lifetime.then((_) {
      if (!identical(_stopHomeTimeline, stop)) return;
      publishStatus('loading');
      stop();
      _stopHomeTimeline = null;
      _homeOwner = null;
    }),
  );
  watch(currentUserReference);
  auth = FirebaseAuth.instance.authStateChanges().listen((user) {
    final owner = user == null ? null : UsersRecord.collection.doc(user.uid);
    if (owner != _homeOwner) watch(owner);
  });
}

bool _sameHomeDay(DateTime date, DateTime? other) =>
    other != null &&
    date.year == other.year &&
    date.month == other.month &&
    date.day == other.day;

int _homeDayNumber(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day).millisecondsSinceEpoch ~/
    Duration.millisecondsPerDay;

HomeTimelineDayStruct _homeDayRow(
  int day,
  int tripIndex,
  String status,
  bool localOnly,
) {
  final date = DateTime.fromMillisecondsSinceEpoch(
    day * Duration.millisecondsPerDay,
    isUtc: true,
  );
  return HomeTimelineDayStruct(
    weekday: dateTimeFormat('EEE', date).toUpperCase(),
    dateLabel: date.day.toString(),
    tripIndex: tripIndex,
    localOnly: localOnly,
    status: status == 'unpacked' ? 'incomplete' : status,
  );
}

HomeTimelineTripStruct _homeTrip(
  PackReadyTimelineEntry entry, {
  required HomeTimelineTripStruct? old,
  required bool newDay,
  required bool hasNext,
  required bool divider,
  required int dayIndex,
  required String dayStatus,
  required bool dayLocalOnly,
  required String dividerStatus,
}) {
  final record = entry.record;
  final date = entry.date;
  final title = entry.eventTitle;
  final allDay = entry.allDay ??
      (record.snapshotData['calendarAllDay'] == true ||
          (record.snapshotData['endTime'] == null &&
              date.hour == 0 &&
              date.minute == 0 &&
              date.second == 0 &&
              date.millisecond == 0));
  final place = (entry.location ??
              record.snapshotData['location'] ??
              record.snapshotData['destination'])
          ?.toString() ??
      '';
  final packed = record.items.where((item) => item.packed).length;
  final total = record.items.length;
  final previousForecast = old?.hasForecast() == true &&
          old?.date == date &&
          old?.destination == place &&
          old?.allDay == allDay
      ? old?.forecast
      : null;
  return HomeTimelineTripStruct(
    id: entry.id,
    listRef: record.reference,
    date: date,
    allDay: allDay,
    destination: place,
    title:
        title ?? (record.tripName.isEmpty ? 'Packing list' : record.tripName),
    subtitle: title == null ? '' : record.tripName,
    dateLabel: allDay
        ? "${dateTimeFormat('EEE, MMM d', date)} · All day"
        : dateTimeFormat('EEE, MMM d · h:mm a', date),
    dayLabel: dateTimeFormat('EEE d', date).toUpperCase(),
    newDay: newDay,
    hasNext: hasNext,
    divider: divider,
    dayIndex: dayIndex,
    dayStatus: dayStatus,
    dayLocalOnly: dayLocalOnly,
    dividerStatus: dividerStatus,
    status: packReadyPackingStatusForLists([record])?.name ?? 'event',
    progressLabel: '$packed of $total packed',
    progress: total == 0 ? 0.0 : packed / total,
    forecast: previousForecast,
    items: [
      for (var i = 0; i < total; i++)
        HomeTimelineItemStruct(
          listRef: record.reference,
          itemIndex: i,
          name: record.items[i].name,
          detail: record.items[i].detail,
          packed: record.items[i].packed,
        ),
    ],
  );
}

Future<void> selectHomeTimelineIndex(int index, [BuildContext? context]) async {
  final state = FFAppState();
  final owner = _homeOwner;
  final rows = state.homeTimelineTrips;
  if (owner == null ||
      owner != currentUserReference ||
      index < 0 ||
      index >= rows.length) return;
  if (_selectedHomeTripIndex != index) {
    _selectedHomeTripIndex = index;
    final dayIndex = rows[index].dayIndex;
    if (context != null) unawaited(revealHomeWeek(context, dayIndex, true));
  }
  final city = currentUserDocument?.homeCity ?? '';
  await Future.wait([
    for (var i = index - 1; i <= index + 1; i++)
      if (i >= 0 && i < rows.length && !rows[i].hasForecast())
        _loadTripWeather(owner, rows[i], city),
  ]);
}

Future<void> _loadTripWeather(
  DocumentReference owner,
  HomeTimelineTripStruct trip,
  String homeCity,
) async {
  final date = trip.date;
  if (date == null) return;
  final forecast = await loadHomeForecast(
    date,
    trip.allDay,
    trip.destination,
    homeCity,
  );
  if (forecast.temperature.isEmpty ||
      owner != _homeOwner ||
      owner != currentUserReference) return;
  final state = FFAppState();
  final current = state.homeTimelineTrips.indexWhere(
    (row) =>
        row.id == trip.id &&
        row.date == date &&
        row.allDay == trip.allDay &&
        row.destination == trip.destination,
  );
  if (current >= 0 && !state.homeTimelineTrips[current].hasForecast()) {
    state.update(() => state.homeTimelineTrips[current].forecast = forecast);
  }
}
