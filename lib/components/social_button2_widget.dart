import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'social_button2_model.dart';
export 'social_button2_model.dart';

class SocialButton2Widget extends StatefulWidget {
  const SocialButton2Widget({
    super.key,
    Color? bgColor,
    String? iconSlug,
    String? label,
    Color? textColor,
  })  : this.bgColor = bgColor ?? const Color(0xFFF1F2F6),
        this.iconSlug = iconSlug ?? 'https://cdn.simpleicons.org/google.svg',
        this.label = label ?? 'Google',
        this.textColor = textColor ?? const Color(0xFF1E272E);

  final Color bgColor;
  final String iconSlug;
  final String label;
  final Color textColor;

  @override
  State<SocialButton2Widget> createState() => _SocialButton2WidgetState();
}

class _SocialButton2WidgetState extends State<SocialButton2Widget> {
  late SocialButton2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SocialButton2Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          widget.bgColor,
          Color(0xFFF1F2F6),
        ),
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.network(
                valueOrDefault<String>(
                  widget.iconSlug,
                  'https://cdn.simpleicons.org/google.svg',
                ),
                width: 20.0,
                height: 20.0,
                fit: BoxFit.contain,
              ),
              Text(
                valueOrDefault<String>(
                  widget.label,
                  'Google',
                ),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      color: valueOrDefault<Color>(
                        widget.textColor,
                        Color(0xFF1E272E),
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
