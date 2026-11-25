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

String? fetchMeteocons(int? wmo) {
  if (wmo == null) return null;

  // Change 'latest' to a pinned version once you pick one.
  const format =
      'svg-static'; // -static'svg', 'svg-static' or 'lottie' (lottie uses .json)
  const style = 'fill'; // 'fill', 'flat', 'line' or 'monochrome'

  String icon;
  switch (wmo) {
    case 0:
    case 1:
      icon = 'clear-day';
      break;
    case 2:
      icon = 'partly-cloudy-day';
      break;
    case 3:
      icon = 'overcast';
      break;
    case 45:
    case 48:
      icon = 'fog';
      break;
    case 51:
    case 53:
    case 55:
      icon = 'drizzle';
      break;
    case 56:
    case 57:
    case 66:
    case 67:
      icon = 'sleet';
      break;
    case 61:
    case 63:
    case 81:
      icon = 'rain';
      break;
    case 65:
    case 82:
      icon = 'extreme-rain';
      break;
    case 71:
    case 73:
    case 77:
    case 86:
      icon = 'snow';
      break;
    case 75:
      icon = 'extreme-snow';
      break;
    case 80:
      icon = 'partly-cloudy-day-rain';
      break;
    case 85:
      icon = 'partly-cloudy-day-snow';
      break;
    case 95:
      icon = 'thunderstorms';
      break;
    case 96:
    case 99:
      icon = 'hail';
      break;
    default:
      icon = 'not-available';
  }

  return 'https://cdn.jsdelivr.net/npm/@meteocons/$format/$style/$icon.svg';
}
