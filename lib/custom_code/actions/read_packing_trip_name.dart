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

Future<String?> readPackingTripName(DocumentReference? listRef) async {
  if (listRef == null) return null;
  try {
    final data =
        (await listRef.get().timeout(const Duration(seconds: 1))).data();
    return data is Map<String, dynamic> ? data['tripName'] as String? : null;
  } catch (_) {
    return null;
  }
}
