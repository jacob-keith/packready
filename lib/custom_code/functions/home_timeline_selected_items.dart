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

/// Gets the indexed packing items for the selected timeline trip.
List<HomeTimelineItemStruct>? homeTimelineSelectedItems(
  List<HomeTimelineTripStruct>? trips,
  int? selectedIndex,
) {
  final list = trips ?? const <HomeTimelineTripStruct>[];
  if (list.isEmpty) return [];
  return list[(selectedIndex ?? 0).clamp(0, list.length - 1).toInt()].items;
}
