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

import '/custom_code/actions/generate_ai_editor_draft.dart'
    show currentAiEditorDraft;

Future<void> syncNativeAiSchedule(
  BuildContext context,
  String? mode,
  DateTime? value,
  String? location,
  bool? checked,
) async {
  final draft = currentAiEditorDraft(context);
  if (draft == null) {
    FFAppState().update(
      () => FFAppState().nativeAiSchedule = NativeAiScheduleStruct(),
    );
    return;
  }
  switch (mode ?? '') {
    case 'date':
      if (value != null) draft.date = DateUtils.dateOnly(value);
    case 'start':
      if (value != null) {
        if (draft.calendarAllDay) draft.duration = null;
        draft.clockMinutes = value.hour * 60 + value.minute;
      }
    case 'end':
      if (value != null) draft.setCalendarEnd(TimeOfDay.fromDateTime(value));
    case 'location':
      draft.location = location ?? '';
      return;
    case 'template':
      draft.alsoSaveTemplate = checked == true;
  }
  final calendar = draft.calendar;
  FFAppState().update(
    () => FFAppState().nativeAiSchedule = NativeAiScheduleStruct(
      ready: true,
      linked: calendar?.eventId != null,
      hasCalendar: calendar != null,
      title: calendar?.title ?? '',
      date: draft.date,
      start: draft.calendarStart,
      end: draft.calendarEnd,
      allDay: draft.calendarAllDay,
      editableDay: draft.repeat == null && !draft.scheduleMissing,
      scheduleLabel: draft.scheduleLabel,
      exceptions: draft.exceptions,
      location: draft.location,
      alsoSaveTemplate: draft.alsoSaveTemplate,
      sample: draft.sample,
    ),
  );
}
