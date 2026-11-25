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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<int?> calculateTotalItems() async {
  // Add your function code here!
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return 0;
  }

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('packingLists')
      .get();

  int totalItems = 0;

  for (final doc in snapshot.docs) {
    final data = doc.data();
    final items = data['items'];

    if (items is List) {
      totalItems += items.length;
    }
  }

  return totalItems;
}
