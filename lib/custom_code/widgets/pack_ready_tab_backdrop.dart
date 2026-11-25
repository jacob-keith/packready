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

import '/app_state.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/index.dart';

class PackReadyTabShellScope extends InheritedWidget {
  const PackReadyTabShellScope({
    super.key,
    required this.inViewport,
    required this.selectTab,
    required super.child,
  });

  final bool inViewport;
  final void Function(int index) selectTab;

  static PackReadyTabShellScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PackReadyTabShellScope>();

  static bool isInsideTabViewport(BuildContext context) =>
      maybeOf(context)?.inViewport == true;

  @override
  bool updateShouldNotify(PackReadyTabShellScope oldWidget) =>
      inViewport != oldWidget.inViewport;
}

class PackReadyTabBackdrop extends StatefulWidget {
  const PackReadyTabBackdrop({
    super.key,
    this.width,
    this.height,
    this.handoff,
    this.offset,
    this.shellMode,
    this.requestedTab,
  });

  final double? width;
  final double? height;
  final String? handoff;
  final double? offset;
  final bool? shellMode;
  final String? requestedTab;

  static const _routes = <String>[
    'mainscreen',
    'Activities',
    'RemindersPage',
    'Calendar',
    'PackReadyAi',
    'Connections',
  ];

  static const _labels = <String>[
    'Home',
    'Create',
    'Reminders',
    'Calendar',
    'AI',
    'Connections',
  ];

  static int? _pendingInitialTab;

  static int tabIndexForRoute(String routeName) => _routes.indexOf(routeName);

  static Future<void> openTab(
    BuildContext context,
    String routeName,
    double offset,
  ) async {
    final targetIndex = tabIndexForRoute(routeName);
    final scope = PackReadyTabShellScope.maybeOf(context);
    if (scope != null && targetIndex >= 0) {
      scope.selectTab(targetIndex);
      return;
    }

    if (targetIndex >= 0) {
      if (!context.mounted) return;
      _pendingInitialTab = targetIndex;
      _publishActiveTab(targetIndex);
      context.goNamed(
        'mainscreen',
        extra: <String, dynamic>{
          kTransitionInfoKey: const TransitionInfo(
            hasTransition: true,
            duration: Duration.zero,
          ),
        },
      );
      return;
    }

    if (!context.mounted) return;
    context.goNamed(
      routeName,
      extra: <String, dynamic>{
        kTransitionInfoKey: const TransitionInfo(
          hasTransition: true,
          duration: Duration.zero,
        ),
      },
    );
  }

  static void _publishActiveTab(int index) {
    final state = FFAppState();
    final label = _labels[index];
    if (state.packReadyShellActiveTab != label) {
      state.update(() => state.packReadyShellActiveTab = label);
    }
  }

  @override
  State<PackReadyTabBackdrop> createState() => _PackReadyTabBackdropState();
}

class _PackReadyTabBackdropState extends State<PackReadyTabBackdrop>
    with SingleTickerProviderStateMixin {
  static const _transitionDuration = Duration(milliseconds: 275);
  static const _maxBlurSigma = 3.6;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _transitionDuration,
  )..addStatusListener(_handleStatus);

  String _mountedUid = '';
  int _activeIndex = 0;
  int? _outgoingIndex;
  int _direction = 1;

  List<Widget?> _mountedTabs = List<Widget?>.filled(6, null);
  List<GlobalKey> _tabKeys = List<GlobalKey>.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    if (widget.shellMode == true) {
      _syncUserSession(currentUserUid, initial: true);
    }
  }

  @override
  void didUpdateWidget(covariant PackReadyTabBackdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shellMode == true &&
        widget.requestedTab != oldWidget.requestedTab &&
        PackReadyTabBackdrop._pendingInitialTab == null) {
      _selectTab(
          PackReadyTabBackdrop._labels.indexOf(widget.requestedTab ?? ''));
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_handleStatus);
    _controller.dispose();
    super.dispose();
  }

  void _handleStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed &&
        _outgoingIndex != null &&
        mounted) {
      setState(() => _outgoingIndex = null);
    }
  }

  void _syncUserSession(String uid, {bool initial = false}) {
    final pending = PackReadyTabBackdrop._pendingInitialTab;
    if (initial || uid != _mountedUid) {
      _mountedUid = uid;
      if (!initial && _controller.isAnimating) {
        _controller.stop();
      }
      _outgoingIndex = null;
      _direction = 1;
      _activeIndex =
          (pending != null && pending >= 0 && pending < 6) ? pending : 0;
      PackReadyTabBackdrop._pendingInitialTab = null;
      _mountedTabs = List<Widget?>.filled(6, null);
      _tabKeys = List<GlobalKey>.generate(6, (_) => GlobalKey());
      _ensureMounted(_activeIndex);
      // A fresh/auth-changed shell can reset the native bar during build.
      final initialIndex = _activeIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _mountedUid == uid && _activeIndex == initialIndex) {
          PackReadyTabBackdrop._publishActiveTab(initialIndex);
        }
      });
    } else if (pending != null && pending >= 0 && pending < 6) {
      PackReadyTabBackdrop._pendingInitialTab = null;
      _controller.stop();
      _outgoingIndex = null;
      _activeIndex = pending;
      _ensureMounted(_activeIndex);
    }
  }

  Widget _buildTabPage(int index) {
    switch (index) {
      case 0:
        return const MainscreenWidget(embedHome: true);
      case 1:
        return const ActivitiesWidget(embedInTabShell: true);
      case 2:
        return const RemindersPageWidget(embedInTabShell: true);
      case 3:
        return const CalendarWidget(embedInTabShell: true);
      case 4:
        return const PackReadyAiWidget(embedInTabShell: true);
      case 5:
        return const ConnectionsWidget(embedInTabShell: true);
      default:
        return const MainscreenWidget(embedHome: true);
    }
  }

  void _ensureMounted(int index) {
    _mountedTabs[index] ??= _buildTabPage(index);
  }

  void _selectTab(int nextIndex) {
    if (nextIndex < 0 || nextIndex >= 6 || nextIndex == _activeIndex) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      _outgoingIndex = _activeIndex;
      _direction = (nextIndex - _activeIndex).sign;
      _activeIndex = nextIndex;
      _ensureMounted(nextIndex);
    });
    _controller.forward(from: 0.0);
    PackReadyTabBackdrop._publishActiveTab(nextIndex);
  }

  Widget _wrapTransition({
    required Widget child,
    required double dx,
    required double opacity,
    required double blurSigma,
  }) {
    var current = child;
    if (blurSigma >= 0.08) {
      current = ImageFiltered(
        imageFilter: ui.ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
          tileMode: ui.TileMode.clamp,
        ),
        child: current,
      );
    }
    if (opacity < 0.999) {
      current = Opacity(opacity: opacity.clamp(0.0, 1.0), child: current);
    }
    if (dx.abs() >= 0.1) {
      current = Transform.translate(offset: Offset(dx, 0), child: current);
    }
    return current;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.handoff == 'vignette') {
      if (Theme.of(context).brightness != Brightness.dark) {
        return const SizedBox.shrink();
      }
      final background = FlutterFlowTheme.of(context).primaryBackground;
      return IgnorePointer(
        child: SizedBox(
          width: double.infinity,
          height: 220,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  background,
                  const Color(0xFF161614),
                  const Color(0xFF131513),
                  background.withValues(alpha: 0),
                ],
                stops: const [0.0, 0.12, 0.45, 1.0],
              ),
            ),
          ),
        ),
      );
    }
    if (widget.shellMode != true) {
      return const SizedBox.shrink();
    }

    return SizedBox.expand(
      child: AuthUserStreamWidget(
        builder: (context) {
          final uid = currentUserUid;
          if (uid != _mountedUid ||
              PackReadyTabBackdrop._pendingInitialTab != null) {
            _syncUserSession(uid);
          }
          final theme = FlutterFlowTheme.of(context);

          return PackReadyTabShellScope(
            inViewport: true,
            selectTab: _selectTab,
            child: ColoredBox(
              color: theme.primaryBackground,
              child: ClipRect(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final viewportWidth = constraints.maxWidth.isFinite
                        ? constraints.maxWidth
                        : MediaQuery.sizeOf(context).width;
                    return AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        final animating =
                            _outgoingIndex != null && _controller.isAnimating;
                        final t = animating ? _controller.value : 1.0;
                        final eased = Curves.easeOutCubic.transform(t);
                        final blurSigma = animating
                            ? _maxBlurSigma * math.sin(math.pi * t)
                            : 0.0;

                        final orderedIndices = <int>[
                          for (var i = 0; i < 6; i++)
                            if (_mountedTabs[i] != null &&
                                i != _activeIndex &&
                                i != _outgoingIndex)
                              i,
                          if (animating &&
                              _outgoingIndex != null &&
                              _mountedTabs[_outgoingIndex!] != null)
                            _outgoingIndex!,
                          if (_mountedTabs[_activeIndex] != null) _activeIndex,
                        ];

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            for (final i in orderedIndices)
                              _buildSlot(
                                index: i,
                                animating: animating,
                                t: t,
                                eased: eased,
                                blurSigma: blurSigma,
                                viewportWidth: viewportWidth,
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSlot({
    required int index,
    required bool animating,
    required double t,
    required double eased,
    required double blurSigma,
    required double viewportWidth,
  }) {
    final isActive = index == _activeIndex;
    final isOutgoing = animating && index == _outgoingIndex;
    final visible = isActive || isOutgoing;

    final double dx;
    final double opacity;
    final double sigma;

    if (isActive && animating) {
      dx = _direction * viewportWidth * 0.16 * (1.0 - eased);
      opacity = Curves.easeOut.transform(t).clamp(0.0, 1.0);
      sigma = blurSigma;
    } else if (isOutgoing) {
      dx = -_direction * viewportWidth * 0.11 * eased;
      opacity = (1.0 - Curves.easeInOut.transform(t) * 1.15).clamp(0.0, 1.0);
      sigma = blurSigma;
    } else {
      dx = 0.0;
      opacity = 1.0;
      sigma = 0.0;
    }

    final inner = KeyedSubtree(
      key: _tabKeys[index],
      child: _mountedTabs[index]!,
    );

    return KeyedSubtree(
      key: ValueKey<String>('packready_tab_${_mountedUid}_$index'),
      child: Offstage(
        offstage: !visible,
        child: TickerMode(
          enabled: visible,
          child: IgnorePointer(
            ignoring: !isActive,
            child: ExcludeSemantics(
              excluding: !isActive,
              child: _wrapTransition(
                child: inner,
                dx: dx,
                opacity: opacity,
                blurSigma: sigma,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
