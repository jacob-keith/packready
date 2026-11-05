import '/components/pref_section_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'pref_section_model.dart';
export 'pref_section_model.dart';

class PrefSectionWidget extends StatefulWidget {
  const PrefSectionWidget({
    super.key,
    this.icon,
    String? title,
    String? subtitle,
    bool? isOpen,
    bool? isLast,
    this.child,
  })  : this.title = title ?? 'Packing Defaults',
        this.subtitle = subtitle ?? 'Carry-on, 3-5 days',
        this.isOpen = isOpen ?? true,
        this.isLast = isLast ?? false;

  final Widget? icon;
  final String title;
  final String subtitle;
  final bool isOpen;
  final bool isLast;
  final Widget Function()? child;

  @override
  State<PrefSectionWidget> createState() => _PrefSectionWidgetState();
}

class _PrefSectionWidgetState extends State<PrefSectionWidget>
    with TickerProviderStateMixin {
  late PrefSectionModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrefSectionModel());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 250.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(0.0, 1.0),
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        wrapWithModel(
          model: _model.prefSectionComponentModel,
          updateCallback: () => safeSetState(() {}),
          child: PrefSectionComponentWidget(
            parameter1: widget.icon,
            parameter2: valueOrDefault<String>(
              widget.title,
              'Packing Defaults',
            ),
            parameter3: valueOrDefault<String>(
              widget.subtitle,
              'Carry-on, 3-5 days',
            ),
            parameter4: _model.isExpanded,
            onHeaderTap: () async {
              logFirebaseEvent('PREF_SECTION_Container_paj6sj51_CALLBACK');
              _model.isExpanded = !(_model.isExpanded ?? true);
              safeSetState(() {});
            },
          ),
        ),
        if (_model.isExpanded ?? true)
          Container(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Container(
                child: Builder(builder: (_) {
                  return widget.child != null
                      ? widget.child!()
                      : SizedBox.shrink();
                }),
              ),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
        if (valueOrDefault<bool>(
          valueOrDefault<bool>(
            widget.isLast,
            false,
          )
              ? false
              : true,
          false,
        ))
          Divider(
            height: 16.0,
            thickness: 1.0,
            indent: 0.0,
            endIndent: 0.0,
            color: FlutterFlowTheme.of(context).alternate,
          ),
      ],
    );
  }
}
