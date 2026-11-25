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

import '/auth/firebase_auth/auth_util.dart';
import '/custom_code/actions/watch_pack_ready_connections.dart';

Future<String> mutatePackReadyConnection(
  String operation,
  String id,
  String text,
) async {
  final uid = currentUserUid;
  if (uid.isEmpty) return 'Sign in to use Connections.';
  final store = PackReadyConnectionsStore(uid);
  try {
    switch (operation) {
      case 'retry':
        await retryPackReadyConnectionTag();
      case 'request':
        final view = FFAppState().packReadyConnectionsData;
        if (view.uid != uid || view.tagStatus != 'ready') {
          return 'Wait for your tag before sending a request.';
        }
        await store.request(text, view.tag);
      case 'accept':
      case 'decline':
        if (id == 'demo:avery') {
          await store.respondDemo(operation == 'accept');
        } else {
          await store.respond(store.edges.doc(id), operation == 'accept');
        }
      case 'cancel':
        if (id == 'demo:casey') {
          await store.cancelDemo();
        } else {
          await store.cancelRequest(store.edges.doc(id));
        }
      case 'add':
        if (text.isNotEmpty) {
          final friend = PackReadyDemoFriend.values.byName(text);
          await store
              .addDemo(friend.shares.singleWhere((share) => share.id == id));
        } else {
          await store.add(store.shares.doc(id));
        }
      default:
        throw ArgumentError.value(operation);
    }
    refreshPackReadyDemoConnections(uid);
    return '';
  } catch (error) {
    return packReadyConnectionError(error);
  }
}
