// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/app_events/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Existing Home and Activity widgets import these helpers from this resource.
export '/custom_code/actions/calendar_studio.dart'
    show
        PackReadyPackingStatus,
        PackReadyTimelineEntry,
        acknowledgeCalendarActivity,
        calendarActivityTitles,
        calendarSeriesMatchesDate,
        effectiveCalendarActivityDate,
        ensureCalendarSessionLoaded,
        isPackReadyOnlyActivity,
        lastCalendarActivity,
        linkedCalendarActivityTitle,
        packReadyPackingStatusForLists,
        packReadyStatusLabel,
        packReadyStatusColor,
        packReadyTimelineEntries;

// The native Calendar page owns the visual tree. Keep this registration so
// the existing cross-widget imports remain stable during the swarm merge.
class CalendarEventList extends StatelessWidget {
  const CalendarEventList({super.key, this.width, this.height});
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class PackReadyDayBrackets extends CustomPainter {
  const PackReadyDayBrackets(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    const inset = .75;
    const arm = 6.5;
    for (final x in [inset, size.width - inset]) {
      for (final y in [inset, size.height - inset]) {
        final dx = x == inset ? arm : -arm;
        final dy = y == inset ? arm : -arm;
        canvas.drawPath(
          Path()
            ..moveTo(x + dx, y)
            ..lineTo(x, y)
            ..lineTo(x, y + dy),
          stroke,
        );
      }
    }
  }

  @override
  bool shouldRepaint(PackReadyDayBrackets oldDelegate) =>
      color != oldDelegate.color;
}

class PackReadyDashedBorder extends CustomPainter {
  const PackReadyDashedBorder({
    required this.color,
    this.strokeWidth = 1.35,
    this.radius = 7,
    this.dash = 5,
    this.gap = 3.5,
  });

  final Color color;
  final double strokeWidth;
  final double radius;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= strokeWidth || size.height <= strokeWidth) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final inset = strokeWidth / 2;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular((radius - inset).clamp(0.0, radius)),
    );
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = (distance + dash).clamp(0.0, metric.length).toDouble();
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(PackReadyDashedBorder oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      radius != oldDelegate.radius ||
      dash != oldDelegate.dash ||
      gap != oldDelegate.gap;
}
