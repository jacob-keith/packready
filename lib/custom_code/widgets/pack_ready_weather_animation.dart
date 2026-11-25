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

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/scheduler.dart';

/// The 10 PackReady animated weather states (1:1 CustomPainter translations
/// of Mason's locked v2/v4 designs). Every forecast condition maps to one of
/// these 10 states — never a text-only fallback.
enum PackReadyWeatherKind {
  sunny, // S2 — Slow-Orbit Corona Sun
  partlyCloudy, // PD2 — Golden Backlight Drift
  cloudy, // C2 — Deep Overcast Bank
  fog, // F8 — Rolling Veil Over Treeline
  lightRain, // LR2 — Gentle Patter & Micro-Beads (light #7)
  rain, // #7 — Crown Splash + Ripple Hybrid
  heavyRain, // HR2 — Squall Sheets & Crown Splashes
  snow, // SN8 — Accumulating Snow Blanket
  windy, // W2 — Brisk Breeze & Drifting Air Motes
  thunderstorm, // T8 — Multi-Zone Cloud-to-Ground Squall live storm
}

/// Daily max wind threshold (mph) that switches clear/cloudy skies to Windy
/// when no precipitation, fog, or storm code takes priority.
const double kPackReadyWindyMphThreshold = 18.0;

/// Centralized WMO-to-animation mapping. Dedicated sleet/hail animations can
/// later be swapped into their own switch cases without touching callers.
PackReadyWeatherKind packReadyWeatherKindFor(
  int wmoCode, {
  double? windSpeedMph,
}) {
  final windy = (windSpeedMph ?? 0) >= kPackReadyWindyMphThreshold;
  switch (wmoCode) {
    case 95:
      return PackReadyWeatherKind.thunderstorm;
    case 96:
    case 99:
      // Hail / Hailstorm -> closest animation (Snow), preserving real label.
      return PackReadyWeatherKind.snow;
    case 65:
    case 82:
      return PackReadyWeatherKind.heavyRain;
    case 61:
    case 63:
    case 81:
      return PackReadyWeatherKind.rain;
    case 51:
    case 53:
    case 55:
    case 80:
      // Drizzle & Sunshowers (80) -> Light Rain animation, preserving real label.
      return PackReadyWeatherKind.lightRain;
    case 56:
    case 57:
    case 66:
    case 67:
      // Sleet / Freezing Rain -> closest animation (Snow), preserving real label.
      return PackReadyWeatherKind.snow;
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return PackReadyWeatherKind.snow;
    case 45:
    case 48:
      return PackReadyWeatherKind.fog;
    case 0:
    case 1:
      return windy ? PackReadyWeatherKind.windy : PackReadyWeatherKind.sunny;
    case 2:
      return windy
          ? PackReadyWeatherKind.windy
          : PackReadyWeatherKind.partlyCloudy;
    case 3:
      return windy ? PackReadyWeatherKind.windy : PackReadyWeatherKind.cloudy;
    default:
      return windy ? PackReadyWeatherKind.windy : PackReadyWeatherKind.cloudy;
  }
}

/// Short 1–2 word condition label displayed beneath the large temperature.
/// Reusable animated PackReady weather icon widget backed by zero-dependency
/// Flutter [CustomPainter] rendering.
class PackReadyWeatherAnimation extends StatefulWidget {
  const PackReadyWeatherAnimation({
    super.key,
    this.width,
    this.height,
    this.wmoCode,
    this.windSpeedMph,
    this.size,
  });

  final double? width;
  final double? height;
  final int? wmoCode;
  final double? windSpeedMph;
  final double? size;

  @override
  State<PackReadyWeatherAnimation> createState() =>
      _PackReadyWeatherAnimationState();
}

class _PackReadyWeatherAnimationState extends State<PackReadyWeatherAnimation>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final ValueNotifier<double> _seconds = ValueNotifier<double>(0.0);
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      _seconds.value = elapsed.inMicroseconds / 1000000.0;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disable = MediaQuery.disableAnimationsOf(context);
    _reduceMotion = disable;
    if (disable) {
      if (_ticker.isActive) _ticker.stop();
      _seconds.value = 1.15;
    } else if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _seconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final kind = packReadyWeatherKindFor(
      widget.wmoCode ?? 0,
      windSpeedMph: widget.windSpeedMph,
    );
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final available = constraints.biggest.shortestSide;
          final side = widget.size ?? (available.isFinite ? available : 64.0);
          return Center(
            child: RepaintBoundary(
              child: CustomPaint(
                size: Size.square(side),
                painter: _PackReadyWeatherPainter(
                  kind: kind,
                  dark: dark,
                  seconds: _seconds,
                  staticSnapshot: _reduceMotion,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DropTrack {
  const _DropTrack(this.sx, this.delay);
  final double sx;
  final double delay;
}

class _SnowFlakeSpec {
  const _SnowFlakeSpec(
    this.sx,
    this.dur,
    this.delay,
    this.crystal, [
    this.r = 2.0,
  ]);
  final double sx;
  final double dur;
  final double delay;
  final bool crystal;
  final double r;
}

class _StormChannel {
  const _StormChannel({
    required this.dur,
    required this.delay,
    required this.lx,
    required this.ly,
    required this.lr,
    required this.gx,
    required this.gy,
    required this.mainPts,
    required this.forkPts,
  });
  final double dur;
  final double delay;
  final double lx;
  final double ly;
  final double lr;
  final double gx;
  final double gy;
  final List<Offset> mainPts;
  final List<Offset> forkPts;
}

class _PackReadyWeatherPainter extends CustomPainter {
  _PackReadyWeatherPainter({
    required this.kind,
    required this.dark,
    required this.seconds,
    required this.staticSnapshot,
  }) : super(repaint: seconds);

  final PackReadyWeatherKind kind;
  final bool dark;
  final ValueNotifier<double> seconds;
  final bool staticSnapshot;

  static const double _tau = math.pi * 2.0;

  static final Path _cloudPath = Path()
    ..moveTo(34, 69)
    ..cubicTo(12, 69, 12, 38, 33, 38)
    ..cubicTo(40, 38, 43, 41, 45, 42)
    ..cubicTo(47, 19, 77, 16, 87, 36)
    ..cubicTo(111, 33, 120, 68, 95, 69)
    ..close();

  static final Path _miniFlakePath = _buildDendritePath(3.4, 0.56, 0.35);

  static final Path _windTopPath = Path()
    ..moveTo(12, 31)
    ..lineTo(66, 31)
    ..cubicTo(76, 31, 78, 21, 70, 19)
    ..cubicTo(64, 18, 61, 24, 65, 26);

  static final Path _windMidPath = Path()
    ..moveTo(12, 86)
    ..lineTo(95, 86)
    ..cubicTo(107, 86, 109, 74, 99, 72)
    ..cubicTo(93, 71, 90, 77, 95, 80);

  static final Path _windLowPath = Path()
    ..moveTo(22, 99)
    ..lineTo(86, 99)
    ..cubicTo(96, 99, 97, 109, 89, 110)
    ..cubicTo(83, 111, 80, 105, 84, 102);

  static final Path _fogThread1 = Path()
    ..moveTo(14, 78)
    ..quadraticBezierTo(44, 70, 70, 78)
    ..quadraticBezierTo(92, 84, 112, 75);

  static final Path _fogThread2 = Path()
    ..moveTo(16, 89)
    ..quadraticBezierTo(48, 83, 78, 90)
    ..quadraticBezierTo(96, 94, 110, 86);

  static final Path _snowCapPath = Path()
    ..moveTo(-40, 0)
    ..cubicTo(-28, -7, -12, -5, 0, -3.5)
    ..cubicTo(14, -7.5, 29, -6, 40, 0)
    ..cubicTo(24, 4.5, -24, 4.5, -40, 0)
    ..close();

  static final List<Path> _pinePaths = [
    _buildPinePath(32, 98, 40, 12),
    _buildPinePath(56, 98, 54, 15),
    _buildPinePath(80, 98, 46, 13.5),
    _buildPinePath(98, 98, 34, 10.5),
  ];

  static const _rain7Tracks = [
    _DropTrack(49, -0.04),
    _DropTrack(62, -0.86),
    _DropTrack(75, -0.44),
    _DropTrack(88, -1.24),
  ];

  static const _lightRainTracks = [
    _DropTrack(46, -0.05),
    _DropTrack(59, -0.98),
    _DropTrack(72, -0.52),
    _DropTrack(85, -1.46),
  ];

  static const _heavyRainTracks = [
    _DropTrack(42, -0.04),
    _DropTrack(52, -0.52),
    _DropTrack(62, -0.22),
    _DropTrack(72, -0.82),
    _DropTrack(82, -0.38),
    _DropTrack(92, -0.94),
  ];

  static const _stormRainTracks = [
    _DropTrack(38, -0.04),
    _DropTrack(51, -0.72),
    _DropTrack(64, -0.34),
    _DropTrack(77, -1.04),
    _DropTrack(90, -0.54),
  ];

  static const _snow8Flakes = [
    _SnowFlakeSpec(32, 3.5, -0.2, true),
    _SnowFlakeSpec(43, 4.1, -1.8, false, 2.0),
    _SnowFlakeSpec(53, 3.3, -0.9, true),
    _SnowFlakeSpec(64, 4.3, -2.9, false, 2.3),
    _SnowFlakeSpec(74, 3.6, -1.4, true),
    _SnowFlakeSpec(85, 4.0, -3.2, false, 1.9),
    _SnowFlakeSpec(94, 3.8, -0.6, true),
    _SnowFlakeSpec(48, 4.7, -3.7, false, 1.5),
    _SnowFlakeSpec(79, 4.6, -2.3, false, 1.5),
  ];

  static const _storm8Channels = [
    _StormChannel(
      dur: 4.3,
      delay: -0.35,
      lx: 40,
      ly: 52,
      lr: 25,
      gx: 34,
      gy: 112,
      mainPts: [
        Offset(42, 60),
        Offset(34, 76),
        Offset(42, 78),
        Offset(31, 96),
        Offset(37, 98),
        Offset(34, 111),
      ],
      forkPts: [Offset(38, 77), Offset(48, 88), Offset(45, 94)],
    ),
    _StormChannel(
      dur: 5.7,
      delay: -2.15,
      lx: 64,
      ly: 48,
      lr: 28,
      gx: 59,
      gy: 112,
      mainPts: [
        Offset(64, 60),
        Offset(57, 74),
        Offset(65, 76),
        Offset(56, 94),
        Offset(62, 96),
        Offset(59, 111),
      ],
      forkPts: [Offset(61, 75), Offset(72, 86), Offset(70, 93)],
    ),
    _StormChannel(
      dur: 6.5,
      delay: -4.20,
      lx: 88,
      ly: 52,
      lr: 25,
      gx: 82,
      gy: 112,
      mainPts: [
        Offset(86, 60),
        Offset(79, 76),
        Offset(86, 78),
        Offset(77, 95),
        Offset(83, 97),
        Offset(82, 111),
      ],
      forkPts: [Offset(82, 77), Offset(94, 87), Offset(91, 93)],
    ),
  ];

  static Path _buildDendritePath(double r, double ratio, double branchLen) {
    final p = Path();
    for (var i = 0; i < 6; i++) {
      final a = i * math.pi / 3.0 - math.pi / 2.0;
      final ca = math.cos(a);
      final sa = math.sin(a);
      p
        ..moveTo(0, 0)
        ..lineTo(ca * r, sa * r);
      final bx = ca * r * ratio;
      final by = sa * r * ratio;
      final bl = r * branchLen;
      for (final dir in const [-0.72, 0.72]) {
        final ba = a + dir;
        p
          ..moveTo(bx, by)
          ..lineTo(bx + math.cos(ba) * bl, by + math.sin(ba) * bl);
      }
    }
    return p;
  }

  static Path _buildPinePath(double cx, double baseY, double h, double w) =>
      Path()
        ..moveTo(cx, baseY - h)
        ..lineTo(cx + w * 0.48, baseY - h * 0.56)
        ..lineTo(cx + w * 0.24, baseY - h * 0.56)
        ..lineTo(cx + w * 0.72, baseY - h * 0.22)
        ..lineTo(cx + w * 0.36, baseY - h * 0.22)
        ..lineTo(cx + w, baseY)
        ..lineTo(cx - w, baseY)
        ..lineTo(cx - w * 0.36, baseY - h * 0.22)
        ..lineTo(cx - w * 0.72, baseY - h * 0.22)
        ..lineTo(cx - w * 0.24, baseY - h * 0.56)
        ..lineTo(cx - w * 0.48, baseY - h * 0.56)
        ..close();

  static Path _polyPath(List<Offset> pts) {
    final p = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      p.lineTo(pts[i].dx, pts[i].dy);
    }
    return p;
  }

  static double _phase(double t, double dur, [double delay = 0.0]) {
    final v = (t - delay) / dur;
    return v - v.floorToDouble();
  }

  static double _smooth01(double p) => 0.5 - 0.5 * math.cos(_tau * p);

  static double _lerp(double a, double b, double t) => a + (b - a) * t;

  static double _seg(double p, double p0, double p1) =>
      ((p - p0) / (p1 - p0)).clamp(0.0, 1.0);

  static double _easeOut(double x) {
    final inv = 1.0 - x;
    return 1.0 - inv * inv;
  }

  void _halo(
    Canvas c,
    double cx,
    double cy,
    double r,
    Color color,
    double a0,
    double a1, [
    double opacity = 1.0,
  ]) {
    if (opacity <= 0.004 || r <= 0) return;
    final p = Paint()
      ..shader = ui.Gradient.radial(
        Offset(cx, cy),
        r,
        [
          color.withValues(alpha: (a0 * opacity).clamp(0.0, 1.0)),
          color.withValues(alpha: (a1 * opacity).clamp(0.0, 1.0)),
          color.withValues(alpha: 0.0),
        ],
        const [0.0, 0.47, 1.0],
      );
    c.drawCircle(Offset(cx, cy), r, p);
  }

  void _ovalHalo(
    Canvas c,
    double cx,
    double cy,
    double rx,
    double ry,
    Color color,
    double a0,
    double a1, [
    double opacity = 1.0,
  ]) {
    if (opacity <= 0.004 || rx <= 0 || ry <= 0) return;
    c.save();
    c.translate(cx, cy);
    c.scale(1.0, ry / rx);
    _halo(c, 0, 0, rx, color, a0, a1, opacity);
    c.restore();
  }

  void _drawCloud(
    Canvas c, {
    required Color fill,
    required double fillAlpha,
    required Color stroke,
    required double strokeAlpha,
    double strokeWidth = 1.5,
    double dx = 0,
    double dy = 0,
    double scale = 1.0,
  }) {
    c.save();
    c.translate(dx, dy);
    if (scale != 1.0) c.scale(scale, scale);
    c.drawPath(
      _cloudPath,
      Paint()
        ..color = fill.withValues(alpha: fillAlpha)
        ..style = PaintingStyle.fill,
    );
    c.drawPath(
      _cloudPath,
      Paint()
        ..color = stroke.withValues(alpha: strokeAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    c.restore();
  }

  void _drawHorizonLine(
    Canvas c,
    double x1,
    double x2,
    double y,
    Color color,
    double width, [
    double alpha = 0.65,
  ]) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(x1, y),
        Offset(x2, y),
        [
          color.withValues(alpha: 0.0),
          color.withValues(alpha: alpha),
          color.withValues(alpha: alpha),
          color.withValues(alpha: 0.0),
        ],
        const [0.0, 0.2, 0.8, 1.0],
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;
    c.drawLine(Offset(x1, y), Offset(x2, y), paint);
  }

  void _drawPartialPath(
    Canvas c,
    Path path,
    double startFrac,
    double endFrac,
    Paint paint,
  ) {
    final s = startFrac.clamp(0.0, 1.0);
    final e = endFrac.clamp(0.0, 1.0);
    if (e - s <= 0.002) return;
    for (final metric in path.computeMetrics()) {
      final len = metric.length;
      final segment = metric.extractPath(len * s, len * e);
      c.drawPath(segment, paint);
    }
  }

  void _drawFlowRibbon(
    Canvas c,
    Path path,
    double t,
    double dur,
    double delay,
    Color color,
    double strokeWidth, {
    double dashFrac = 0.44,
    double trackAlpha = 0.16,
  }) {
    if (trackAlpha > 0) {
      c.drawPath(
        path,
        Paint()
          ..color = color.withValues(alpha: trackAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
    final p = _phase(t, dur, delay);
    // Smooth dash travel across [0..1] mirroring stroke-dashoffset 48 -> -104
    final head = _lerp(-0.04, 1.0 + dashFrac + 0.04, p);
    final tail = head - dashFrac;
    double alpha;
    if (p < 0.16) {
      alpha = _seg(p, 0.0, 0.16) * 0.94;
    } else if (p < 0.70) {
      alpha = _lerp(0.94, 0.88, _seg(p, 0.16, 0.70));
    } else if (p < 0.92) {
      alpha = _lerp(0.88, 0.0, _seg(p, 0.70, 0.92));
    } else {
      alpha = 0.0;
    }
    if (alpha <= 0.01) return;
    _drawPartialPath(
      c,
      path,
      tail,
      head,
      Paint()
        ..color = color.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _drawImpactBeads(
    Canvas c,
    double hx,
    double gy,
    double p,
    Color color,
    double r,
  ) {
    if (p < 0.54 || p > 0.86) return;
    double bx, by, scale, alpha;
    if (p < 0.57) {
      final k = _seg(p, 0.54, 0.57);
      bx = _lerp(0, 1.5, k);
      by = _lerp(0, -2.5, k);
      scale = _lerp(0.4, 1.05, k);
      alpha = k * 0.95;
    } else if (p < 0.67) {
      final k = _seg(p, 0.57, 0.67);
      bx = _lerp(1.5, 5.5, k);
      by = _lerp(-2.5, -8.0, k);
      scale = _lerp(1.05, 1.0, k);
      alpha = _lerp(0.95, 0.91, k);
    } else if (p < 0.77) {
      final k = _seg(p, 0.67, 0.77);
      bx = _lerp(5.5, 8.7, k);
      by = _lerp(-8.0, -5.0, k);
      scale = _lerp(1.0, 0.79, k);
      alpha = _lerp(0.91, 0.54, k);
    } else {
      final k = _seg(p, 0.77, 0.86);
      bx = _lerp(8.7, 10.4, k);
      by = _lerp(-5.0, -1.0, k);
      scale = _lerp(0.79, 0.43, k);
      alpha = _lerp(0.54, 0.0, k);
    }
    if (alpha <= 0.01) return;
    final paint = Paint()..color = color.withValues(alpha: alpha);
    c.drawCircle(Offset(hx - bx, gy + by), r * scale, paint);
    c.drawCircle(Offset(hx + bx, gy + by * 0.95), r * scale, paint);
  }

  void _drawImpactRipple(
    Canvas c,
    double hx,
    double gy,
    double p,
    Color color,
    double rx,
    double ry,
    double strokeWidth,
  ) {
    if (p < 0.54 || p > 0.98) return;
    double scale, alpha;
    if (p < 0.57) {
      final k = _easeOut(_seg(p, 0.54, 0.57));
      scale = _lerp(0.14, 0.24, k);
      alpha = k * 0.96;
    } else if (p < 0.78) {
      final k = _easeOut(_seg(p, 0.57, 0.78));
      scale = _lerp(0.24, 0.84, k);
      alpha = _lerp(0.96, 0.50, k);
    } else {
      final k = _easeOut(_seg(p, 0.78, 0.98));
      scale = _lerp(0.84, 1.14, k);
      alpha = _lerp(0.50, 0.0, k);
    }
    if (alpha <= 0.01) return;
    c.drawOval(
      Rect.fromCenter(
        center: Offset(hx, gy),
        width: rx * 2 * scale,
        height: ry * 2 * scale,
      ),
      Paint()
        ..color = color.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  void _drawDropAndGlint(
    Canvas c,
    double sx,
    double sy,
    double p, {
    required double fallDx,
    required double fallDy,
    required double lineDx,
    required double lineDy,
    required double strokeWidth,
    required double haloR,
    required Color dropColor,
    required double haloA0,
    required double haloA1,
    double hitP = 0.57,
  }) {
    if (p >= hitP) return;
    final k = p / hitP;
    final tx = fallDx * k;
    final ty = fallDy * k;
    double alpha;
    if (p < 0.10) {
      alpha = _seg(p, 0.0, 0.10) * 0.98;
    } else if (p < hitP - 0.07) {
      alpha = 1.0;
    } else {
      alpha = _lerp(1.0, 0.0, _seg(p, hitP - 0.07, hitP));
    }
    if (alpha <= 0.01) return;
    final x0 = sx + tx;
    final y0 = sy + ty;
    _halo(
      c,
      x0 + lineDx * 0.5,
      y0 + lineDy * 0.5,
      haloR,
      dropColor,
      haloA0,
      haloA1,
      alpha,
    );
    c.drawLine(
      Offset(x0, y0),
      Offset(x0 + lineDx, y0 + lineDy),
      Paint()
        ..color = dropColor.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final t = staticSnapshot
        ? (kind == PackReadyWeatherKind.thunderstorm ? 4.02 : 1.15)
        : seconds.value;
    final side = math.min(size.width, size.height);
    canvas.save();
    canvas.translate((size.width - side) / 2, (size.height - side) / 2);
    canvas.scale(side / 144.0, side / 144.0);
    canvas.translate(10.0, 12.0);

    switch (kind) {
      case PackReadyWeatherKind.sunny:
        _paintSunnyS2(canvas, t);
      case PackReadyWeatherKind.partlyCloudy:
        _paintPartlyCloudyPD2(canvas, t);
      case PackReadyWeatherKind.cloudy:
        _paintCloudyC2(canvas, t);
      case PackReadyWeatherKind.fog:
        _paintFogF8(canvas, t);
      case PackReadyWeatherKind.lightRain:
        _paintLightRainLR2(canvas, t);
      case PackReadyWeatherKind.rain:
        _paintRain7(canvas, t);
      case PackReadyWeatherKind.heavyRain:
        _paintHeavyRainHR2(canvas, t);
      case PackReadyWeatherKind.snow:
        _paintSnowSN8(canvas, t);
      case PackReadyWeatherKind.windy:
        _paintWindyW2(canvas, t);
      case PackReadyWeatherKind.thunderstorm:
        _paintThunderstormT8(canvas, t);
    }

    canvas.restore();
  }

  /* ── 1. SUNNY (S2 — Slow-Orbit Corona Sun) ── */
  void _paintSunnyS2(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFFFFB946) : const Color(0xFFE08212);
    final fillColor = dark ? const Color(0xFFE69E35) : const Color(0xFFF2AD44);
    final strokeColor =
        dark ? const Color(0xFFFFD77A) : const Color(0xFFA35B12);
    final rayColor = dark ? const Color(0xFFFFC95E) : const Color(0xFFC46F14);

    final b = _smooth01(_phase(t, 5.4));
    _halo(
      c,
      62,
      60,
      56 * _lerp(0.985, 1.04, b),
      haloColor,
      dark ? 0.35 : 0.19,
      dark ? 0.15 : 0.08,
      _lerp(0.85, 1.0, b),
    );

    final cb = _smooth01(_phase(t, 5.2));
    c.drawCircle(
      const Offset(62, 60),
      28.5 * _lerp(0.96, 1.06, cb),
      Paint()
        ..color = strokeColor.withValues(alpha: _lerp(0.26, 0.58, cb))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25,
    );

    final angleOffset = _phase(t, 24.0) * _tau;
    for (var i = 0; i < 8; i++) {
      final a = angleOffset + i * math.pi / 4.0;
      final ca = math.cos(a);
      final sa = math.sin(a);
      final r0 = i.isEven ? 31.0 : 32.5;
      final len = i.isEven ? 9.0 : 5.5;
      c.drawLine(
        Offset(62 + ca * r0, 60 + sa * r0),
        Offset(62 + ca * (r0 + len), 60 + sa * (r0 + len)),
        Paint()
          ..color = rayColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = i.isEven ? 2.4 : 1.85
          ..strokeCap = StrokeCap.round,
      );
    }

    c.drawCircle(
      const Offset(62, 60),
      22.5,
      Paint()..color = fillColor.withValues(alpha: dark ? 0.88 : 0.92),
    );
    c.drawCircle(
      const Offset(62, 60),
      22.5,
      Paint()
        ..color = strokeColor.withValues(alpha: 0.94)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.55,
    );
  }

  /* ── 2. PARTLY CLOUDY (PD2 — Golden Backlight Drift) ── */
  void _paintPartlyCloudyPD2(Canvas c, double t) {
    final sunHalo = dark ? const Color(0xFFFFB946) : const Color(0xFFE08212);
    final sunFill = dark ? const Color(0xFFE69E35) : const Color(0xFFF2AD44);
    final sunStroke = dark ? const Color(0xFFFFD77A) : const Color(0xFFA35B12);
    final sunRay = dark ? const Color(0xFFFFC95E) : const Color(0xFFC46F14);
    final cloudHalo = dark ? const Color(0xFF80CFE6) : const Color(0xFF287D9C);
    final cloudFill = dark ? const Color(0xFF67AEC4) : const Color(0xFF59A7C2);
    final cloudStroke =
        dark ? const Color(0xFF8EDEF0) : const Color(0xFF1E647D);

    final sb = _smooth01(_phase(t, 5.2));
    _halo(
      c,
      44,
      42,
      44 * _lerp(0.985, 1.04, sb),
      sunHalo,
      dark ? 0.35 : 0.19,
      dark ? 0.15 : 0.08,
      _lerp(0.85, 1.0, sb),
    );

    final rayScale = _lerp(0.97, 1.06, sb);
    final rayAlpha = _lerp(0.85, 1.0, sb);
    for (var i = 0; i < 8; i++) {
      final a = i * math.pi / 4.0;
      final ca = math.cos(a);
      final sa = math.sin(a);
      c.drawLine(
        Offset(44 + ca * 22.3 * rayScale, 42 + sa * 22.3 * rayScale),
        Offset(44 + ca * 28.3 * rayScale, 42 + sa * 28.3 * rayScale),
        Paint()
          ..color = sunRay.withValues(alpha: rayAlpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round,
      );
    }
    c.drawCircle(
      const Offset(44, 42),
      17.5,
      Paint()..color = sunFill.withValues(alpha: dark ? 0.88 : 0.92),
    );
    c.drawCircle(
      const Offset(44, 42),
      17.5,
      Paint()
        ..color = sunStroke.withValues(alpha: 0.94)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    final cb = _smooth01(_phase(t, 5.8, -1.5));
    _halo(
      c,
      68,
      66,
      48 * _lerp(0.985, 1.04, cb),
      cloudHalo,
      dark ? 0.35 : 0.17,
      dark ? 0.15 : 0.07,
      _lerp(0.85, 1.0, cb),
    );

    final drift = _smooth01(_phase(t, 6.6));
    _drawCloud(
      c,
      fill: cloudFill,
      fillAlpha: dark ? 0.88 : 0.90,
      stroke: cloudStroke,
      strokeAlpha: 0.92,
      strokeWidth: 1.55,
      dx: 10 + _lerp(-2.6, 2.6, drift),
      dy: 17 + _lerp(0.0, -1.0, drift),
      scale: 0.92,
    );
  }

  /* ── 3. CLOUDY / OVERCAST (C2 — Deep Overcast Bank) ── */
  void _paintCloudyC2(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF8AAAE0) : const Color(0xFF4E70A8);
    final fillColor = dark ? const Color(0xFF6B89B5) : const Color(0xFF84A3CC);
    final strokeColor =
        dark ? const Color(0xFFAAC7F2) : const Color(0xFF3C5987);
    final backFill = dark ? const Color(0xFF4A638A) : const Color(0xFFA4BCE0);
    final backStroke = dark ? const Color(0xFF809FCC) : const Color(0xFF5673A3);

    final b1 = _smooth01(_phase(t, 6.6));
    _halo(
      c,
      62,
      58,
      56 * _lerp(0.985, 1.04, b1),
      haloColor,
      dark ? 0.32 : 0.17,
      dark ? 0.13 : 0.07,
      _lerp(0.85, 1.0, b1),
    );
    final b2 = _smooth01(_phase(t, 5.4, -2.0));
    _ovalHalo(
      c,
      62,
      82,
      46 * _lerp(0.985, 1.04, b2),
      12 * _lerp(0.985, 1.04, b2),
      haloColor,
      dark ? 0.32 : 0.17,
      dark ? 0.13 : 0.07,
      0.65 * _lerp(0.85, 1.0, b2),
    );

    final d = _smooth01(_phase(t, 7.2));
    _drawCloud(
      c,
      fill: backFill,
      fillAlpha: 0.88,
      stroke: backStroke,
      strokeAlpha: 0.88,
      strokeWidth: 2.1,
      dx: 2 + _lerp(2.4, -2.4, d),
      dy: 14 + _lerp(0.5, -1.0, d),
      scale: 0.66,
    );
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: dark ? 0.88 : 0.90,
      stroke: strokeColor,
      strokeAlpha: 0.92,
      strokeWidth: 1.65,
      dx: 10 + _lerp(-2.6, 2.6, d),
      dy: 21 + _lerp(0.0, -1.0, d),
      scale: 0.88,
    );
  }

  /* ── 4. FOG (F8 — Rolling Veil Over Treeline) ── */
  void _paintFogF8(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF8EC9C5) : const Color(0xFF3C7370);
    final plumeColor = dark ? const Color(0xFFA5DBD7) : const Color(0xFF7AA8A5);
    final cardColor = dark ? const Color(0xFF1C201D) : const Color(0xFFFFFFFF);
    final treeFill = dark ? const Color(0xFF456E6D) : const Color(0xFF5C8C88);
    final treeStroke = dark ? const Color(0xFF8EC7C3) : const Color(0xFF265452);
    final strokeColor =
        dark ? const Color(0xFFAEDCD9) : const Color(0xFF2E5958);

    final hb = _smooth01(_phase(t, 6.8));
    _halo(
      c,
      62,
      62,
      56 * _lerp(0.985, 1.04, hb),
      haloColor,
      dark ? 0.34 : 0.17,
      dark ? 0.15 : 0.07,
      _lerp(0.85, 1.0, hb),
    );

    // Treeline softly obscuring and revealing as the front veil rolls across
    final vp = _phase(t, 7.6, -1.2);
    double treeVis;
    if (vp < 0.45) {
      treeVis = _lerp(0.96, 0.34, _smooth01(vp / 0.9));
    } else if (vp < 0.65) {
      treeVis = _lerp(0.34, 0.42, (vp - 0.45) / 0.20);
    } else {
      treeVis = _lerp(0.42, 0.96, (vp - 0.65) / 0.35);
    }

    const treeOpacities = [0.65, 1.0, 0.82, 0.58];
    for (var i = 0; i < _pinePaths.length; i++) {
      final op = treeOpacities[i] * treeVis;
      c.drawPath(
        _pinePaths[i],
        Paint()..color = treeFill.withValues(alpha: 0.82 * op),
      );
      c.drawPath(
        _pinePaths[i],
        Paint()
          ..color = treeStroke.withValues(alpha: 0.90 * op)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.3
          ..strokeJoin = StrokeJoin.round,
      );
    }

    // Front rolling obscuring veil + volumetric plume
    double vx, vy, vsx, vAlpha;
    if (vp < 0.35) {
      final k = _seg(vp, 0.0, 0.35);
      vx = _lerp(-26, -4, k);
      vy = _lerp(0, -1.5, k);
      vsx = _lerp(0.92, 1.06, k);
      vAlpha = _lerp(0.14, 0.96, k);
    } else if (vp < 0.65) {
      final k = _seg(vp, 0.35, 0.65);
      vx = _lerp(-4, 12, k);
      vy = _lerp(-1.5, 0.5, k);
      vsx = _lerp(1.06, 1.02, k);
      vAlpha = _lerp(0.96, 0.88, k);
    } else {
      final k = _seg(vp, 0.65, 1.0);
      vx = _lerp(12, 28, k);
      vy = _lerp(0.5, 1.0, k);
      vsx = _lerp(1.02, 0.90, k);
      vAlpha = _lerp(0.88, 0.14, k);
    }
    _ovalHalo(c, 54 + vx, 78 + vy, 44 * vsx, 18, cardColor, 0.82, 0.36, vAlpha);
    _ovalHalo(
      c,
      64 + vx,
      75 + vy,
      34 * vsx,
      13,
      plumeColor,
      0.44,
      0.20,
      vAlpha,
    );

    // Counter-rolling lower mist plume
    final cp = _phase(t, 8.8, -3.4);
    double cx, cy, csx, cAlpha;
    if (cp < 0.42) {
      final k = _seg(cp, 0.0, 0.42);
      cx = _lerp(24, 2, k);
      cy = _lerp(1, -1, k);
      csx = _lerp(0.92, 1.05, k);
      cAlpha = _lerp(0.18, 0.92, k);
    } else if (cp < 0.72) {
      final k = _seg(cp, 0.42, 0.72);
      cx = _lerp(2, -14, k);
      cy = _lerp(-1, 0.5, k);
      csx = _lerp(1.05, 1.0, k);
      cAlpha = _lerp(0.92, 0.78, k);
    } else {
      final k = _seg(cp, 0.72, 1.0);
      cx = _lerp(-14, -26, k);
      cy = _lerp(0.5, 1, k);
      csx = _lerp(1.0, 0.90, k);
      cAlpha = _lerp(0.78, 0.18, k);
    }
    _ovalHalo(
      c,
      66 + cx,
      90 + cy,
      46 * csx,
      16,
      plumeColor,
      0.44,
      0.20,
      cAlpha,
    );

    _drawHorizonLine(c, 16, 108, 99, strokeColor, 1.6, 0.68);
    _drawFlowRibbon(
      c,
      _fogThread1,
      t,
      6.2,
      -0.8,
      strokeColor,
      1.5,
      dashFrac: 0.34,
      trackAlpha: 0.0,
    );
    _drawFlowRibbon(
      c,
      _fogThread2,
      t,
      6.8,
      -3.2,
      strokeColor,
      1.35,
      dashFrac: 0.34,
      trackAlpha: 0.0,
    );
  }

  /* ── 5. LIGHT RAIN / DRIZZLE (LR2 — Gentle Patter & Micro-Beads) ── */
  void _paintLightRainLR2(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF7CE0F5) : const Color(0xFF157491);
    final fillColor = dark ? const Color(0xFF5FAABB) : const Color(0xFF56A8C0);
    final strokeColor =
        dark ? const Color(0xFF8EE4F2) : const Color(0xFF1D6880);
    final dropColor = dark ? const Color(0xFF8DE6F8) : const Color(0xFF14718F);

    final b = _smooth01(_phase(t, 5.4));
    _halo(
      c,
      63,
      47,
      55 * _lerp(0.985, 1.04, b),
      haloColor,
      dark ? 0.35 : 0.17,
      dark ? 0.15 : 0.07,
      _lerp(0.85, 1.0, b),
    );
    final fy = _lerp(0.0, -2.0, _smooth01(_phase(t, 5.6)));
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: dark ? 0.88 : 0.90,
      stroke: strokeColor,
      strokeAlpha: 0.92,
      dy: -4 + fy,
    );

    const dur = 1.9;
    const gy = 109.0;
    for (final tr in _lightRainTracks) {
      final p = _phase(t, dur, tr.delay);
      final hx = tr.sx - 7.8;
      if (p >= 0.54 && p <= 0.70) {
        final ga = p < 0.57
            ? _seg(p, 0.54, 0.57) * 0.95
            : _lerp(0.95, 0.0, _seg(p, 0.57, 0.70));
        _halo(
          c,
          hx,
          gy,
          6.0,
          dropColor,
          dark ? 0.56 : 0.25,
          dark ? 0.24 : 0.10,
          ga,
        );
      }
      if (p >= 0.54 && p <= 0.80) {
        final bp = _seg(p, 0.54, 0.80);
        final lift = math.sin(math.pi * bp) * 6.4;
        final alpha = math.sin(math.pi * bp) * 0.92;
        c.drawCircle(
          Offset(hx, gy - lift),
          1.25,
          Paint()..color = dropColor.withValues(alpha: alpha),
        );
      }
      _drawImpactRipple(c, hx, gy, p, dropColor, 6.8, 2.0, 1.1);
      _drawDropAndGlint(
        c,
        tr.sx,
        69,
        p,
        fallDx: -6.5,
        fallDy: 34.0,
        lineDx: -1.3,
        lineDy: 6.0,
        strokeWidth: 1.85,
        haloR: 6.5,
        dropColor: dropColor,
        haloA0: dark ? 0.56 : 0.25,
        haloA1: dark ? 0.24 : 0.10,
        hitP: 0.58,
      );
    }
  }

  /* ── 6. RAIN (#7 — Crown Splash + Ripple Hybrid) ── */
  void _paintRain7(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF75DBF2) : const Color(0xFF126A86);
    final fillColor = dark ? const Color(0xFF60AEBF) : const Color(0xFF50A1B9);
    final strokeColor =
        dark ? const Color(0xFF7BDAE9) : const Color(0xFF1B6279);
    final dropColor = dark ? const Color(0xFF75DBF2) : const Color(0xFF126A86);
    final impactColor =
        dark ? const Color(0xFF8BE6FA) : const Color(0xFF116E8C);

    final b = _smooth01(_phase(t, 5.4));
    _halo(
      c,
      63,
      47,
      56 * _lerp(0.985, 1.04, b),
      haloColor,
      dark ? 0.35 : 0.17,
      dark ? 0.15 : 0.07,
      _lerp(0.85, 1.0, b),
    );
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: dark ? 0.88 : 0.90,
      stroke: strokeColor,
      strokeAlpha: 0.92,
      dy: -4,
    );

    const dur = 1.6;
    const gy = 110.0;
    for (final tr in _rain7Tracks) {
      final p = _phase(t, dur, tr.delay);
      final hx = tr.sx - 11.5;
      if (p >= 0.53 && p <= 0.70) {
        final ga = p < 0.57
            ? _seg(p, 0.53, 0.57) * 0.96
            : _lerp(0.96, 0.0, _seg(p, 0.57, 0.70));
        _halo(
          c,
          hx,
          gy,
          8.5,
          dropColor,
          dark ? 0.56 : 0.25,
          dark ? 0.24 : 0.10,
          ga,
        );
      }
      _drawImpactRipple(c, hx, gy, p, impactColor, 12.5, 3.4, 1.4);
      _drawImpactBeads(c, hx, gy, p, impactColor, 1.35);
      _drawDropAndGlint(
        c,
        tr.sx,
        69,
        p,
        fallDx: -9.5,
        fallDy: 34.0,
        lineDx: -2.0,
        lineDy: 7.0,
        strokeWidth: 2.7,
        haloR: 8.5,
        dropColor: dropColor,
        haloA0: dark ? 0.56 : 0.25,
        haloA1: dark ? 0.24 : 0.10,
      );
    }
  }

  /* ── 7. HEAVY RAIN (HR2 — Squall Sheets & Crown Splashes) ── */
  void _paintHeavyRainHR2(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF4AC8EC) : const Color(0xFF0E5C7A);
    final fillColor = dark ? const Color(0xFF3E849E) : const Color(0xFF4189A3);
    final strokeColor =
        dark ? const Color(0xFF72D5F0) : const Color(0xFF134B63);
    final backFill = dark ? const Color(0xFF2B5E75) : const Color(0xFF609DB5);
    final backStroke = dark ? const Color(0xFF56A8C4) : const Color(0xFF29637A);
    final dropColor = dark ? const Color(0xFF75E2FC) : const Color(0xFF0D5D7A);

    const gy = 112.0;
    _drawHorizonLine(c, 18, 96, gy, dropColor, 1.8, 0.62);

    final b = _smooth01(_phase(t, 4.0));
    _halo(
      c,
      62,
      46,
      56 * _lerp(0.985, 1.04, b),
      haloColor,
      dark ? 0.36 : 0.19,
      dark ? 0.15 : 0.08,
      _lerp(0.85, 1.0, b),
    );
    _drawCloud(
      c,
      fill: backFill,
      fillAlpha: 0.85,
      stroke: backStroke,
      strokeAlpha: 0.85,
      strokeWidth: 1.8,
      dx: 36,
      dy: 4,
      scale: 0.62,
    );
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: 0.90,
      stroke: strokeColor,
      strokeAlpha: 0.93,
      dy: -5,
    );

    const dur = 1.12;
    for (final tr in _heavyRainTracks) {
      final p = _phase(t, dur, tr.delay);
      final hx = tr.sx - 13.7;
      if (p >= 0.53 && p <= 0.94) {
        double sx, alpha;
        if (p < 0.58) {
          final k = _seg(p, 0.53, 0.58);
          sx = _lerp(0.15, 0.58, k);
          alpha = k * 0.98;
        } else if (p < 0.78) {
          final k = _seg(p, 0.58, 0.78);
          sx = _lerp(0.58, 1.38, k);
          alpha = _lerp(0.98, 0.42, k);
        } else {
          final k = _seg(p, 0.78, 0.94);
          sx = _lerp(1.38, 1.75, k);
          alpha = _lerp(0.42, 0.0, k);
        }
        c.drawLine(
          Offset(hx - 7 * sx, gy),
          Offset(hx + 7 * sx, gy),
          Paint()
            ..color = dropColor.withValues(alpha: alpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0
            ..strokeCap = StrokeCap.round,
        );
      }
      _drawImpactBeads(c, hx, gy, p, dropColor, 1.3);
      _drawDropAndGlint(
        c,
        tr.sx,
        67,
        p,
        fallDx: -11.0,
        fallDy: 36.0,
        lineDx: -2.7,
        lineDy: 9.0,
        strokeWidth: 2.35,
        haloR: 7.5,
        dropColor: dropColor,
        haloA0: dark ? 0.56 : 0.25,
        haloA1: dark ? 0.24 : 0.10,
        hitP: 0.56,
      );
    }
  }

  /* ── 8. SNOW (SN8 — Accumulating Snow Blanket) ── */
  void _paintSnowSN8(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF96D6FF) : const Color(0xFF3273AA);
    final fillColor = dark ? const Color(0xFF699BC2) : const Color(0xFF82B0D4);
    final strokeColor =
        dark ? const Color(0xFFC2E8FF) : const Color(0xFF2A5B85);
    final flakeColor = dark ? const Color(0xFFF2FAFF) : const Color(0xFF226498);
    final capFill = dark ? const Color(0xFF98D2F5) : const Color(0xFF7BB3DB);
    final capStroke = dark ? const Color(0xFFDFF4FF) : const Color(0xFF29618C);
    final floorGlow = dark ? const Color(0xFF85CCF7) : const Color(0xFF3A7DB5);

    const gy = 110.0;
    final fb = _smooth01(_phase(t, 6.0));
    _ovalHalo(
      c,
      62,
      gy + 1,
      46 * _lerp(0.985, 1.04, fb),
      10 * _lerp(0.985, 1.04, fb),
      floorGlow,
      dark ? 0.48 : 0.22,
      dark ? 0.18 : 0.08,
      _lerp(0.85, 1.0, fb),
    );

    // Visibly accumulating / pulsing snow cap along ground plane
    final bp = _phase(t, 7.2, -2.8);
    double capSx, capSy, capAlpha;
    if (bp < 0.58) {
      final k = _smooth01(bp / 1.16);
      capSx = _lerp(0.92, 1.03, k);
      capSy = _lerp(0.58, 1.16, k);
      capAlpha = _lerp(0.65, 1.0, k);
    } else if (bp < 0.82) {
      final k = _seg(bp, 0.58, 0.82);
      capSx = _lerp(1.03, 1.02, k);
      capSy = _lerp(1.16, 1.12, k);
      capAlpha = _lerp(1.0, 0.94, k);
    } else {
      final k = _seg(bp, 0.82, 1.0);
      capSx = _lerp(1.02, 0.92, k);
      capSy = _lerp(1.12, 0.58, k);
      capAlpha = _lerp(0.94, 0.65, k);
    }
    c.save();
    c.translate(62, gy + 2);
    c.scale(capSx, capSy);
    c.drawPath(
      _snowCapPath,
      Paint()..color = capFill.withValues(alpha: 0.42 * capAlpha),
    );
    c.drawPath(
      _snowCapPath,
      Paint()
        ..color = capStroke.withValues(alpha: 0.88 * capAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.45
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    c.restore();

    final hb = _smooth01(_phase(t, 5.6));
    _halo(
      c,
      63,
      46,
      56 * _lerp(0.985, 1.04, hb),
      haloColor,
      dark ? 0.35 : 0.18,
      dark ? 0.15 : 0.07,
      _lerp(0.85, 1.0, hb),
    );
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: dark ? 0.88 : 0.90,
      stroke: strokeColor,
      strokeAlpha: 0.94,
      dy: -5,
    );

    for (final f in _snow8Flakes) {
      final p = _phase(t, f.dur, f.delay);
      final sway = math.sin(_tau * p * 1.4 + (f.crystal ? 0.0 : 2.2)) * 3.8;
      final dy = _lerp(0.0, 41.0, p);
      double alpha, scale;
      if (p < 0.12) {
        final k = _seg(p, 0.0, 0.12);
        alpha = k * 0.96;
        scale = _lerp(0.65, 1.0, k);
      } else if (p < 0.82) {
        alpha = 0.95;
        scale = 1.0;
      } else if (p < 0.94) {
        final k = _seg(p, 0.82, 0.94);
        alpha = _lerp(0.95, 0.0, k);
        scale = _lerp(1.0, 0.35, k);
      } else {
        alpha = 0.0;
        scale = 0.35;
      }
      if (alpha > 0.01) {
        final fx = f.sx + sway;
        final fy = 67.0 + dy;
        _halo(
          c,
          fx,
          fy,
          f.crystal ? 6.5 : 4.8,
          haloColor,
          dark ? 0.56 : 0.25,
          dark ? 0.22 : 0.10,
          alpha,
        );
        c.save();
        c.translate(fx, fy);
        if (f.crystal) {
          c.rotate(p * 3.5);
          c.scale(scale, scale);
          c.drawPath(
            _miniFlakePath,
            Paint()
              ..color = flakeColor.withValues(alpha: alpha)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.3
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round,
          );
        } else {
          c.drawCircle(
            Offset.zero,
            f.r * scale,
            Paint()..color = flakeColor.withValues(alpha: alpha),
          );
        }
        c.restore();
      }
      // Settling shimmer dot along snow cap
      if (p >= 0.76 && p <= 0.98) {
        final sa = p < 0.85
            ? _seg(p, 0.76, 0.85) * 0.96
            : _lerp(0.96, 0.0, _seg(p, 0.85, 0.98));
        final sr = p < 0.85
            ? _lerp(0.3, 1.9, _seg(p, 0.76, 0.85))
            : _lerp(1.9, 0.8, _seg(p, 0.85, 0.98));
        c.drawCircle(
          Offset(f.sx - 1, gy - 2),
          sr,
          Paint()..color = flakeColor.withValues(alpha: sa),
        );
      }
    }
  }

  /* ── 9. WINDY (W2 — Brisk Breeze & Drifting Air Motes) ── */
  void _paintWindyW2(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF6CE0C7) : const Color(0xFF177D69);
    final fillColor = dark ? const Color(0xFF4E9E91) : const Color(0xFF55A698);
    final strokeColor =
        dark ? const Color(0xFF8EF2DC) : const Color(0xFF1B6356);
    final ribbonColor =
        dark ? const Color(0xFF8EF5DF) : const Color(0xFF147361);

    final hb = _smooth01(_phase(t, 4.6));
    _halo(
      c,
      62,
      60,
      55 * _lerp(0.985, 1.04, hb),
      haloColor,
      dark ? 0.32 : 0.17,
      dark ? 0.13 : 0.07,
      _lerp(0.85, 1.0, hb),
    );
    _drawFlowRibbon(c, _windTopPath, t, 2.4, -0.4, ribbonColor, 2.1);

    final d = _smooth01(_phase(t, 4.8));
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: dark ? 0.87 : 0.90,
      stroke: strokeColor,
      strokeAlpha: 0.92,
      strokeWidth: 1.8,
      dx: 8 + _lerp(-2.6, 2.6, d),
      dy: 12 + _lerp(0.0, -1.0, d),
      scale: 0.84,
    );

    _drawFlowRibbon(c, _windMidPath, t, 2.7, -1.2, ribbonColor, 2.5);
    _drawFlowRibbon(c, _windLowPath, t, 2.5, -2.0, ribbonColor, 2.2);

    const motes = [
      (36.0, 78.0, 10.0, 1.8, 2.1, -0.3),
      (52.0, 93.0, 12.0, 1.6, 2.3, -1.3),
      (24.0, 42.0, 8.0, 1.5, 2.5, -0.9),
    ];
    for (final m in motes) {
      final p = _phase(t, m.$5, m.$6);
      final dx = _lerp(-18.0, 34.0, p);
      final dy = _lerp(0.0, -2.0, p);
      double alpha;
      if (p < 0.22) {
        alpha = _seg(p, 0.0, 0.22) * 0.88;
      } else if (p < 0.78) {
        alpha = 0.88;
      } else {
        alpha = _lerp(0.88, 0.0, _seg(p, 0.78, 1.0));
      }
      if (alpha <= 0.01) continue;
      c.drawLine(
        Offset(m.$1 + dx, m.$2 + dy),
        Offset(m.$1 + dx + m.$3, m.$2 + dy),
        Paint()
          ..color = ribbonColor.withValues(alpha: alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = m.$4
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  /* ── 10. THUNDERSTORM (T8 — Multi-Zone Live Storm Squall) ── */
  void _paintThunderstormT8(Canvas c, double t) {
    final haloColor = dark ? const Color(0xFF65C2F2) : const Color(0xFF296B9E);
    final fillColor = dark ? const Color(0xFF3F5772) : const Color(0xFF61809E);
    final strokeColor =
        dark ? const Color(0xFF9ACBE9) : const Color(0xFF243E59);
    final backFill = dark ? const Color(0xFF2B3E54) : const Color(0xFF809AB5);
    final backStroke = dark ? const Color(0xFF6A8DAC) : const Color(0xFF3C5875);
    final lobeColor = dark ? const Color(0xFF8DE7FF) : const Color(0xFF38BDF8);
    final arcGlow = dark ? const Color(0xFF66E0FF) : const Color(0xFF0DA6DB);
    final arcCore = dark ? const Color(0xFFF5FEFF) : const Color(0xFF0A5380);
    final rainColor = dark ? const Color(0xFF75DBF2) : const Color(0xFF146A8A);

    final hb = _smooth01(_phase(t, 4.4));
    _halo(
      c,
      62,
      48,
      56 * _lerp(0.985, 1.04, hb),
      haloColor,
      dark ? 0.34 : 0.19,
      dark ? 0.14 : 0.08,
      _lerp(0.85, 1.0, hb),
    );

    // Continuous active storm rain & crown splashes underneath
    const rainDur = 1.35;
    const gy = 112.0;
    for (final tr in _stormRainTracks) {
      final p = _phase(t, rainDur, tr.delay);
      final hx = tr.sx - 11.5;
      _drawImpactRipple(c, hx, gy, p, rainColor, 9.5, 2.6, 1.2);
      _drawImpactBeads(c, hx, gy, p, arcCore, 1.15);
      _drawDropAndGlint(
        c,
        tr.sx,
        68,
        p,
        fallDx: -9.5,
        fallDy: 34.0,
        lineDx: -2.0,
        lineDy: 7.0,
        strokeWidth: 2.15,
        haloR: 6.8,
        dropColor: rainColor,
        haloA0: dark ? 0.56 : 0.25,
        haloA1: dark ? 0.24 : 0.10,
      );
    }

    // Layered storm clouds
    _drawCloud(
      c,
      fill: backFill,
      fillAlpha: 0.88,
      stroke: backStroke,
      strokeAlpha: 0.88,
      strokeWidth: 1.9,
      dx: 36,
      dy: 3,
      scale: 0.62,
    );
    _drawCloud(
      c,
      fill: fillColor,
      fillAlpha: 0.91,
      stroke: strokeColor,
      strokeAlpha: 0.94,
      strokeWidth: 1.55,
      dy: -6,
    );

    // 3 independent incommensurate strike channels (Left / Center / Right)
    for (final ch in _storm8Channels) {
      final p = _phase(t, ch.dur, ch.delay);
      if (p < 0.03 || p > 0.23) continue;

      // Localized shifting cloud-lobe illumination synced to this channel
      double lobeAlpha, lobeScale;
      if (p < 0.075) {
        final k = _seg(p, 0.03, 0.075);
        lobeAlpha = k;
        lobeScale = _lerp(0.76, 1.16, k);
      } else if (p < 0.105) {
        final k = _seg(p, 0.075, 0.105);
        lobeAlpha = _lerp(1.0, 0.24, k);
        lobeScale = _lerp(1.16, 0.95, k);
      } else if (p < 0.13) {
        final k = _seg(p, 0.105, 0.13);
        lobeAlpha = _lerp(0.24, 0.94, k);
        lobeScale = _lerp(0.95, 1.12, k);
      } else {
        final k = _seg(p, 0.13, 0.22);
        lobeAlpha = _lerp(0.94, 0.0, k);
        lobeScale = _lerp(1.12, 0.84, k);
      }
      _halo(
        c,
        ch.lx,
        ch.ly,
        ch.lr * lobeScale,
        lobeColor,
        dark ? 0.72 : 0.56,
        dark ? 0.30 : 0.22,
        lobeAlpha,
      );

      // Ground strike glow, shockwave ring & upward sparks
      if (p >= 0.065 && p <= 0.23) {
        _halo(
          c,
          ch.gx,
          ch.gy,
          14 * lobeScale,
          lobeColor,
          dark ? 0.72 : 0.56,
          dark ? 0.30 : 0.22,
          lobeAlpha,
        );
        final sk = _easeOut(_seg(p, 0.065, 0.23));
        final shockAlpha = p < 0.09
            ? _seg(p, 0.065, 0.09)
            : _lerp(1.0, 0.0, _seg(p, 0.09, 0.23));
        final shockScale = _lerp(0.16, 1.25, sk);
        c.drawOval(
          Rect.fromCenter(
            center: Offset(ch.gx, ch.gy),
            width: 28 * shockScale,
            height: 7.6 * shockScale,
          ),
          Paint()
            ..color = arcGlow.withValues(alpha: shockAlpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.45,
        );
        final spK = _seg(p, 0.065, 0.22);
        final spDx = _lerp(0, 11.5, spK);
        final spDy = -math.sin(math.pi * spK) * 9.0;
        final spAlpha = (1.0 - spK).clamp(0.0, 1.0);
        final spPaint = Paint()..color = arcCore.withValues(alpha: spAlpha);
        c.drawCircle(Offset(ch.gx - spDx, ch.gy + spDy), 1.35, spPaint);
        c.drawCircle(Offset(ch.gx + spDx, ch.gy + spDy * 0.94), 1.35, spPaint);
      }

      // Leader -> return stroke -> double-flicker restrike
      final drawFrac = p < 0.08 ? _seg(p, 0.04, 0.08) : 1.0;
      double boltAlpha;
      if (p < 0.04) {
        boltAlpha = _seg(p, 0.03, 0.04) * 0.85;
      } else if (p < 0.08) {
        boltAlpha = _lerp(0.85, 1.0, _seg(p, 0.04, 0.08));
      } else if (p < 0.105) {
        boltAlpha = _lerp(1.0, 0.18, _seg(p, 0.08, 0.105));
      } else if (p < 0.13) {
        boltAlpha = _lerp(0.18, 0.98, _seg(p, 0.105, 0.13));
      } else {
        boltAlpha = _lerp(0.98, 0.0, _seg(p, 0.13, 0.20));
      }
      if (boltAlpha > 0.01 && drawFrac > 0.01) {
        final mainPath = _polyPath(ch.mainPts);
        _drawPartialPath(
          c,
          mainPath,
          0.0,
          drawFrac,
          Paint()
            ..color = arcGlow.withValues(alpha: 0.48 * boltAlpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5.2
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round,
        );
        _drawPartialPath(
          c,
          mainPath,
          0.0,
          drawFrac,
          Paint()
            ..color = arcCore.withValues(alpha: boltAlpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.8
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round,
        );
      }
      if (p >= 0.055 && p <= 0.19) {
        final forkFrac = p < 0.085 ? _seg(p, 0.055, 0.085) : 1.0;
        final forkAlpha = boltAlpha * 0.95;
        if (forkAlpha > 0.01 && forkFrac > 0.01) {
          final forkPath = _polyPath(ch.forkPts);
          _drawPartialPath(
            c,
            forkPath,
            0.0,
            forkFrac,
            Paint()
              ..color = arcGlow.withValues(alpha: 0.48 * forkAlpha)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.6
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round,
          );
          _drawPartialPath(
            c,
            forkPath,
            0.0,
            forkFrac,
            Paint()
              ..color = arcCore.withValues(alpha: forkAlpha)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.2
              ..strokeCap = StrokeCap.round
              ..strokeJoin = StrokeJoin.round,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_PackReadyWeatherPainter oldDelegate) =>
      oldDelegate.kind != kind ||
      oldDelegate.dark != dark ||
      oldDelegate.staticSnapshot != staticSnapshot;
}
