import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Type;
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/auth/firebase_auth/auth_util.dart';

/// Lists activity labels, retaining the selected filter until reset.
List<String>? historyCategoryLabels(
  List<HistoryTripStruct>? trips,
  String? selected,
) {
  final records = trips ?? const <HistoryTripStruct>[];
  final labels = <String, String>{};
  for (final trip in records) {
    final key = historyCategoryKey(trip.activity)!;
    if (trip.activity.isNotEmpty) labels.putIfAbsent(key, () => trip.activity);
  }
  if (records.isNotEmpty &&
      selected != null &&
      selected.isNotEmpty &&
      selected != 'All Trips') {
    labels.putIfAbsent(
        selected, () => selected[0].toUpperCase() + selected.substring(1));
  }
  if (labels.isEmpty) return [];
  return ['', for (final key in labels.keys.toList()..sort()) labels[key]!];
}
