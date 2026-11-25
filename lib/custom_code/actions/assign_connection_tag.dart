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

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/watch_pack_ready_connections.dart';

Future<void> assignConnectionTag() async {
  if (currentUserUid.isEmpty) return;
  try {
    await ensurePackReadyConnectionTag(currentUserUid, currentUserDisplayName);
  } on FirebaseException {
    // Connections retries when the tag directory is reachable.
  } on FormatException {
    // Connections can show the error without interrupting profile setup.
  }
}
