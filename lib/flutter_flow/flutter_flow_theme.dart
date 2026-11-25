// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';

SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();

  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color neutralPanel;
  late Color onPrimary;
  late Color softShadow;
  late Color lightCardShadow;
  late Color weatherLowInk;
  late Color weatherHighInk;
  late Color tabBarSurface;
  late Color tabBarIdleInk;
  late Color tabBarActiveInk;
  late Color tabBarActivePill;
  late Color packedGreen;
  late Color packedGreenTint;
  late Color pendingYellow;
  late Color pendingYellowTint;
  late Color unpackedOrange;
  late Color unpackedOrangeTint;
  late Color calendarEventSlate;
  late Color calendarEventTint;
  late Color linkGreen;
  late Color subtleText;
  late Color subtleDivider;
  late Color warmTerracottaTint;
  late Color selectedSurface;
  late Color onLimeCta;

  FFDesignTokens get designToken => FFDesignTokens(this);

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF2E5E36);
  late Color secondary = const Color(0xFF769C47);
  late Color tertiary = const Color(0xFF77522D);
  late Color alternate = const Color(0xFFD5DFD0);
  late Color primaryText = const Color(0xFF122016);
  late Color secondaryText = const Color(0xFF4A5C50);
  late Color primaryBackground = const Color(0xFFF7FAF5);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0xFFDCEBCB);
  late Color accent2 = const Color(0xFFFDF0E6);
  late Color accent3 = const Color(0xFFE6F0F4);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF769C47);
  late Color warning = const Color(0xFFA9521A);
  late Color error = const Color(0xFFC4402F);
  late Color info = const Color(0xFF00CEC9);

  late Color neutralPanel = const Color(0xFFFFFFFF);
  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color softShadow = const Color(0x33000000);
  late Color lightCardShadow = const Color(0x000F2817);
  late Color weatherLowInk = const Color(0xFF153868);
  late Color weatherHighInk = const Color(0xFF7E1624);
  late Color tabBarSurface = const Color(0xFFF7FAF5);
  late Color tabBarIdleInk = const Color(0xFF4A5C50);
  late Color tabBarActiveInk = const Color(0xFF2E5E36);
  late Color tabBarActivePill = const Color(0xFFDCEBCB);
  late Color packedGreen = const Color(0xFF3E7A28);
  late Color packedGreenTint = const Color(0x303E7A28);
  late Color pendingYellow = const Color(0xFFC2720C);
  late Color pendingYellowTint = const Color(0x30C2720C);
  late Color unpackedOrange = const Color(0xFFC25C38);
  late Color unpackedOrangeTint = const Color(0x30C25C38);
  late Color calendarEventSlate = const Color(0xFF6B7870);
  late Color calendarEventTint = const Color(0x306B7870);
  late Color linkGreen = const Color(0xFF2E5E36);
  late Color subtleText = const Color(0xFF66786C);
  late Color subtleDivider = const Color(0xFFE3EBE0);
  late Color warmTerracottaTint = const Color(0xFFF3E7DF);
  late Color selectedSurface = const Color(0xFFE6ECDE);
  late Color onLimeCta = const Color(0xFF141C17);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Manrope';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.w800,
        fontSize: 58.0,
        height: 1.1,
      );
  String get displayMediumFamily => 'Manrope';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.w800,
        fontSize: 46.0,
        height: 1.15,
      );
  String get displaySmallFamily => 'Manrope';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 38.0,
        height: 1.2,
      );
  String get headlineLargeFamily => 'Manrope';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 32.0,
        height: 1.25,
      );
  String get headlineMediumFamily => 'Manrope';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
        height: 1.3,
      );
  String get headlineSmallFamily => 'Manrope';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
        height: 1.35,
      );
  String get titleLargeFamily => 'Manrope';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
        height: 1.4,
      );
  String get titleMediumFamily => 'Manrope';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        height: 1.4,
      );
  String get titleSmallFamily => 'Manrope';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.manrope(
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
        height: 1.4,
      );
  String get labelLargeFamily => 'Space Grotesk';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.spaceGrotesk(
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
        height: 1.2,
      );
  String get labelMediumFamily => 'Space Grotesk';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.spaceGrotesk(
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        height: 1.2,
      );
  String get labelSmallFamily => 'Space Grotesk';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.spaceGrotesk(
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 10.0,
        height: 1.2,
      );
  String get bodyLargeFamily => 'Inter';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
        height: 1.6,
      );
  String get bodyMediumFamily => 'Inter';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
        height: 1.6,
      );
  String get bodySmallFamily => 'Inter';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.inter(
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
        height: 1.5,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF769C47);
  late Color secondary = const Color(0xFF9DB681);
  late Color tertiary = const Color(0xFFE58A52);
  late Color alternate = const Color(0xFF2D322D);
  late Color primaryText = const Color(0xFFF3F6F4);
  late Color secondaryText = const Color(0xFF9BA49C);
  late Color primaryBackground = const Color(0xFF121412);
  late Color secondaryBackground = const Color(0xFF1C201D);
  late Color accent1 = const Color(0xFF243628);
  late Color accent2 = const Color(0xFF34241B);
  late Color accent3 = const Color(0xFF1D2E36);
  late Color accent4 = const Color(0xB2262D34);
  late Color success = const Color(0xFF9DB681);
  late Color warning = const Color(0xFFF2A751);
  late Color error = const Color(0xFFE87766);
  late Color info = const Color(0xFF81ECEC);

  late Color neutralPanel = const Color(0xFF1C201D);
  late Color onPrimary = const Color(0xFF121412);
  late Color softShadow = const Color(0x55000000);
  late Color lightCardShadow = const Color(0x000F2817);
  late Color weatherLowInk = const Color(0xFF8AC3FF);
  late Color weatherHighInk = const Color(0xFFFF9F9C);
  late Color tabBarSurface = const Color(0xFF121212);
  late Color tabBarIdleInk = const Color(0xFF9E9E9E);
  late Color tabBarActiveInk = const Color(0xFFFFFFFF);
  late Color tabBarActivePill = const Color(0xFF22331C);
  late Color packedGreen = const Color(0xFFAADA70);
  late Color packedGreenTint = const Color(0x3DAADA70);
  late Color pendingYellow = const Color(0xFFFAC65D);
  late Color pendingYellowTint = const Color(0x3DFAC65D);
  late Color unpackedOrange = const Color(0xFFE58A52);
  late Color unpackedOrangeTint = const Color(0x3DE58A52);
  late Color calendarEventSlate = const Color(0xFF848E86);
  late Color calendarEventTint = const Color(0x3D848E86);
  late Color linkGreen = const Color(0xFFF3F6F4);
  late Color subtleText = const Color(0xFF7B867C);
  late Color subtleDivider = const Color(0xFF222822);
  late Color warmTerracottaTint = const Color(0xFF3A3324);
  late Color selectedSurface = const Color(0xFF2E3330);
  late Color onLimeCta = const Color(0xFF121412);
}

class FFDesignTokens {
  const FFDesignTokens(this.theme);
  final FlutterFlowTheme theme;
  FFSpacing get spacing => const FFSpacing();
  FFRadius get radius => const FFRadius();
  FFShadows get shadow => FFShadows(theme);
}

class FFSpacing {
  const FFSpacing();
  double get none => 0.0;
  double get xs => 4.0;
  double get sm => 8.0;
  double get md => 16.0;
  double get lg => 24.0;
  double get xl => 32.0;
  double get xxl => 48.0;
  double get xxxl => 64.0;
}

class FFRadius {
  const FFRadius();
  double get none => 0.0;
  double get xs => 2.0;
  double get sm => 4.0;
  double get md => 8.0;
  double get lg => 12.0;
  double get xl => 16.0;
  double get xxl => 24.0;
  double get full => 9999.0;
}

class FFShadows {
  const FFShadows(this.theme);
  final FlutterFlowTheme theme;
  BoxShadow get lg => const BoxShadow(
      blurRadius: 16.0,
      color: const Color(0x1F000000),
      offset: const Offset(0.0, 8.0),
      spreadRadius: 0.0);
  BoxShadow get md => const BoxShadow(
      blurRadius: 8.0,
      color: const Color(0x1A000000),
      offset: const Offset(0.0, 4.0),
      spreadRadius: 0.0);
  BoxShadow get none => const BoxShadow(
      blurRadius: 0.0,
      color: const Color(0x00000000),
      offset: const Offset(0.0, 0.0),
      spreadRadius: 0.0);
  BoxShadow get sm => const BoxShadow(
      blurRadius: 4.0,
      color: const Color(0x14000000),
      offset: const Offset(0.0, 2.0),
      spreadRadius: 0.0);
  BoxShadow get xl => const BoxShadow(
      blurRadius: 24.0,
      color: const Color(0x24000000),
      offset: const Offset(0.0, 12.0),
      spreadRadius: 0.0);
  BoxShadow get xs => const BoxShadow(
      blurRadius: 2.0,
      color: const Color(0x0D000000),
      offset: const Offset(0.0, 1.0),
      spreadRadius: 0.0);
  BoxShadow get xxl => const BoxShadow(
      blurRadius: 32.0,
      color: const Color(0x29000000),
      offset: const Offset(0.0, 16.0),
      spreadRadius: 0.0);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null && fontFamily.isNotEmpty) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    return font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
          );
  }
}
