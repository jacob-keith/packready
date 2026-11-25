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

/// DSL custom function nativePackingGroupRows
List<NativePackingRowStruct>? nativePackingGroupRows(
  List<PackItemStruct>? items,
  String? group,
) {
  String category(PackItemStruct item) {
    if (const ['Clothes', 'Toiletries', 'Electronics', 'Misc']
        .contains(item.category)) {
      return item.category;
    }
    final name = item.name.toLowerCase();
    if (RegExp(
            r'shirt|shorts|sock|pant|jacket|shoe|sneaker|boot|underwear|layer|clothes|hat|glove')
        .hasMatch(name)) return 'Clothes';
    if (RegExp(
            r'tooth|toiletr|soap|shampoo|deodorant|sunscreen|razor|conditioner')
        .hasMatch(name)) return 'Toiletries';
    if (RegExp(
            r'charger|power bank|headphone|earbud|camera|adapter|laptop|cable|electronics')
        .hasMatch(name)) return 'Electronics';
    return 'Misc';
  }

  return [
    for (final entry in (items ?? const <PackItemStruct>[]).asMap().entries)
      if (category(entry.value) == group)
        NativePackingRowStruct(
            name: entry.value.name,
            detail: entry.value.detail,
            packed: entry.value.packed,
            originalIndex: entry.key),
  ];
}
