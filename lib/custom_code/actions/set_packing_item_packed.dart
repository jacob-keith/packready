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

import '/custom_code/actions/begin_packing_visit.dart'
    show recordPackingVisitCheck;

Future<void> setPackingItemPacked(
  BuildContext context,
  DocumentReference? listRef,
  int? itemIndex,
  bool? packed,
) async {
  if (listRef == null || itemIndex == null || packed == null) return;
  try {
    final total =
        await FirebaseFirestore.instance.runTransaction<int?>((tx) async {
      final snapshot = await tx.get(listRef);
      if (!snapshot.exists) return null;
      final items = PackingListsRecord.fromSnapshot(snapshot).items.toList();
      if (itemIndex < 0 ||
          itemIndex >= items.length ||
          items[itemIndex].packed == packed) {
        return null;
      }
      items[itemIndex] = PackItemStruct.fromMap({
        ...items[itemIndex].toMap(),
        'packed': packed,
      });
      tx.update(listRef, {
        ...createPackingListsRecordData(
          completed: items.every((item) => item.packed),
        ),
        ...mapToFirestore({'items': getPackItemListFirestoreData(items)}),
      });
      return items.length;
    });
    if (packed && total != null && context.mounted) {
      recordPackingVisitCheck(context, false, total);
    }
  } on FirebaseException {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Couldn't update this item. Please try again.")),
      );
    }
  }
}
