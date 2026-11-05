import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'google_signin_button_model.dart';
export 'google_signin_button_model.dart';

class GoogleSigninButtonWidget extends StatefulWidget {
  const GoogleSigninButtonWidget({super.key});

  @override
  State<GoogleSigninButtonWidget> createState() =>
      _GoogleSigninButtonWidgetState();
}

class _GoogleSigninButtonWidgetState extends State<GoogleSigninButtonWidget> {
  late GoogleSigninButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GoogleSigninButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              logFirebaseEvent('GOOGLE_SIGNIN_BUTTON_Container_ON_TAP');
              GoRouter.of(context).prepareAuthEvent();
              final user = await authManager.signInWithGoogle(context);
              if (user == null) {
                return;
              }

              context.goNamedAuth(MainscreenWidget.routeName, context.mounted);
            },
            child: Container(
              height: 56.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 1.0,
                ),
              ),
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 0),
                    fadeOutDuration: Duration(milliseconds: 0),
                    imageUrl:
                        'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3c/Google_Favicon_2025.svg/960px-Google_Favicon_2025.svg.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
                    width: 20.0,
                    height: 20.0,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'Google',
                    style: FlutterFlowTheme.of(context).labelLarge.override(
                          font: GoogleFonts.spaceGrotesk(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelLarge
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelLarge.fontStyle,
                          lineHeight: 1.2,
                        ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
            ),
          ),
        ),
      ].divide(SizedBox(width: 16.0)),
    );
  }
}
