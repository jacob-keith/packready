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

import 'dart:async';
import 'package:flutter/material.dart';

const homeWeekStripKey = ValueKey<String>('PackReadyHomeDateStrip');
const homeWeekDayWidth = 48.0;

Future<void> revealHomeWeek(
  BuildContext context,
  int? dayIndex,
  bool? animate,
) async {
  final idx = dayIndex ?? -1;
  final shouldAnimate = animate == true;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!context.mounted || idx < 0) return;
    final scope =
        context.findAncestorStateOfType<ScaffoldState>()?.context ?? context;
    final host = _find(
      scope as Element,
      (e) => e.widget.key == homeWeekStripKey,
    );
    if (host == null) return;
    final scrollable = _find(
      host,
      (e) =>
          e is StatefulElement &&
          e.state is ScrollableState &&
          e.widget is Scrollable &&
          axisDirectionToAxis((e.widget as Scrollable).axisDirection) ==
              Axis.horizontal,
    ) as StatefulElement?;
    final position = (scrollable?.state as ScrollableState?)?.position;
    if (position == null || !position.hasContentDimensions) return;
    final center =
        (idx + .5) * homeWeekDayWidth - position.viewportDimension / 2;
    final offset = center.clamp(0.0, position.maxScrollExtent).toDouble();
    if ((offset - position.pixels).abs() < 1) return;
    if (shouldAnimate) {
      unawaited(
        position.animateTo(
          offset,
          duration: const Duration(milliseconds: 190),
          curve: Curves.easeOut,
        ),
      );
    } else {
      position.jumpTo(offset);
    }
  });
}

Element? _find(Element root, bool Function(Element) matches) {
  if (matches(root)) return root;
  Element? result;
  root.visitChildren((child) {
    result ??= _find(child, matches);
  });
  return result;
}
