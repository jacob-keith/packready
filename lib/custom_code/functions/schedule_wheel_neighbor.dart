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

/// Calculate the neighboring label for one date or time field.
DateTime scheduleWheelNeighbor(
  DateTime at,
  String part,
  int offset,
) {
  return switch (part) {
    'month' => DateTime(at.year, at.month + offset, 1),
    'day' => DateTime(at.year, at.month, at.day + offset),
    'year' => DateTime(at.year + offset, 1, 1),
    'hour' => DateTime(at.year, at.month, at.day, at.hour + offset),
    'minute' =>
      DateTime(at.year, at.month, at.day, at.hour, (at.minute + offset) % 60),
    'period' => DateTime(at.year, at.month, at.day, at.hour + 12),
    _ => at,
  };
}
