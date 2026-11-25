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

import 'package:cloud_functions/cloud_functions.dart';

import '/custom_code/actions/load_pack_ready_calendar_events.dart'
    show CalendarAdapter, CalendarRead, CalendarSource;

const _appleWindowPastDays = 90;
const _appleWindowFutureDays = 365;
const _appleSliceLimit = 500;
const _appleMaxAnchors = 12;

String? _clipNote(String value) {
  final trimmed = value.trim();
  if (trimmed.isEmpty) return null;
  return trimmed.length <= 500 ? trimmed : trimmed.substring(0, 500);
}

Future<dynamic> callPackReadyAppleCalendar(dynamic payload) async {
  try {
    final call = FirebaseFunctions.instance.httpsCallable(
      'loadPackReadyAppleCalendars',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 35)),
    );
    return (await call.call(payload)).data;
  } on FirebaseFunctionsException catch (error) {
    throw FormatException(error.message ?? 'Could not refresh Apple Calendar.');
  }
}

class AppleCalendarAdapter implements CalendarAdapter {
  @override
  Future<List<CalendarSource>> sources() async {
    final data = await callPackReadyAppleCalendar({'operation': 'list'});
    return [
      for (final row in (data['sources'] as List? ?? const []).whereType<Map>())
        CalendarSource.fromMap(row),
    ];
  }

  Future<CalendarSource> add(String link, String name, String color) async {
    final data = await callPackReadyAppleCalendar({
      'operation': 'add',
      'link': link,
      'name': name,
      'color': color,
    });
    return CalendarSource.fromMap(data['source'] as Map);
  }

  static List<DateTime> _anchorsFor(DateTime from, DateTime to) {
    final anchors = <DateTime>[];
    var covered = from;
    while (covered.isBefore(to) && anchors.length < _appleMaxAnchors) {
      var anchor = covered.add(const Duration(days: 30));
      if (anchors.isNotEmpty &&
          anchor.add(const Duration(days: 60)).isAfter(to)) {
        final clamped = to.subtract(const Duration(days: 60));
        if (!clamped.subtract(const Duration(days: 30)).isAfter(covered)) {
          anchor = clamped;
        }
      }
      anchors.add(anchor);
      covered = anchor.add(const Duration(days: 60));
    }
    return anchors;
  }

  @override
  Future<CalendarRead> events(
    List<CalendarSource> calendars, {
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) async {
    if (calendars.isEmpty) {
      return (events: const <PackReadyCalendarEventStruct>[], warning: null);
    }
    final now = DateTime.now().toUtc();
    final from =
        (rangeStart ?? now.subtract(const Duration(days: _appleWindowPastDays)))
            .toUtc();
    final rawTo =
        (rangeEnd ?? now.add(const Duration(days: _appleWindowFutureDays)))
            .toUtc();
    final to = rawTo.isAfter(from) ? rawTo : from.add(const Duration(days: 1));
    final anchors = _anchorsFor(from, to);

    final events = <(String, String), PackReadyCalendarEventStruct>{};
    String? warning;
    var failed = false;
    var succeeded = 0;

    // Query one calendar at a time in batches of <= 3 to respect the callable's
    // per-call event cap and maxInstances: 3 concurrency limit.
    for (final calendar in calendars) {
      for (var i = 0; i < anchors.length; i += 3) {
        final batch = anchors.sublist(
          i,
          i + 3 > anchors.length ? anchors.length : i + 3,
        );
        final results = await Future.wait([
          for (final anchor in batch)
            callPackReadyAppleCalendar({
              'operation': 'events',
              'ids': [calendar.id],
              'anchor': anchor.toIso8601String(),
            }),
        ]);
        for (final data in results) {
          if (data['failed'] != 0) {
            failed = true;
            continue;
          }
          succeeded++;
          final rows = data['events'] as List? ?? const [];
          if (rows.length >= _appleSliceLimit) {
            warning ??=
                'Some Apple calendar dates exceeded 500 events; showing available events.';
          }
          for (final item in rows.whereType<Map>()) {
            final raw = Map<String, dynamic>.from(item);
            final startRaw = raw['start'] as String?;
            final endRaw = raw['end'] as String?;
            if (startRaw == null ||
                endRaw == null ||
                DateTime.tryParse(startRaw) == null ||
                DateTime.tryParse(endRaw) == null) {
              continue;
            }
            final event = PackReadyCalendarEventStruct.fromMap({
              ...raw,
              if (raw['notes'] is String)
                'notes': _clipNote(raw['notes'] as String),
            });
            events[(event.calendarId, event.id)] = event;
          }
        }
      }
    }
    if (failed && succeeded == 0) {
      return (
        events: const <PackReadyCalendarEventStruct>[],
        warning: 'Some Apple calendars could not refresh.',
      );
    }
    if (failed) {
      warning ??= 'Some Apple calendar dates could not refresh.';
    }
    return (events: events.values.toList(), warning: warning);
  }
}
