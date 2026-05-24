import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const cream     = Color(0xFFF8F4EE);
  static const ink       = Color(0xFF1A1208);
  static const rust      = Color(0xFFB84C2A);
  static const rustLight = Color(0xFFF0DDD6);
  static const rustMid   = Color(0xFFD4623A);
  static const amber     = Color(0xFFC98A2E);
  static const sage      = Color(0xFF4A7C6B);
  static const sageLight = Color(0xFFDCEEE9);
  static const muted     = Color(0xFF7A6E63);
  static const border    = Color(0xFFD9CEC4);
  static const white     = Color(0xFFFFFFFF);
  static const dark      = Color(0xFF0F0B06);
}

/// Breakpoints
class Bp {
  /// Small mobile: < 400
  static bool isXSmall(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width < 400;

  /// Mobile: < 600
  static bool isMobile(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width < 600;

  /// Tablet+: >= 600
  static bool isTablet(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 600;

  /// Wide / desktop: >= 900
  static bool isWide(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 900;

  static double width(BuildContext ctx) => MediaQuery.of(ctx).size.width;

  /// Clamp a value between mobile and desktop scales
  static double scale(BuildContext ctx, {
    required double mobile,
    required double desktop,
    double breakAt = 900,
  }) {
    final w = width(ctx).clamp(320.0, breakAt);
    final t = (w - 320) / (breakAt - 320);
    return mobile + (desktop - mobile) * t;
  }
}

/// Responsive font scale multiplier
double fontScale(BuildContext ctx) {
  final w = Bp.width(ctx);
  if (w < 360) return 0.85;
  if (w < 480) return 0.90;
  if (w < 600) return 0.95;
  return 1.0;
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary:    AppColors.rust,
        secondary:  AppColors.sage,
        surface:    AppColors.cream,
        background: AppColors.cream,
        onPrimary:  AppColors.white,
        onSurface:  AppColors.ink,
      ),
      scaffoldBackgroundColor: AppColors.cream,
      textTheme: GoogleFonts.sourceCodeProTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 40, fontWeight: FontWeight.w700, color: AppColors.ink,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.ink,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 26, fontWeight: FontWeight.w400, color: AppColors.ink,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 22, fontWeight: FontWeight.w400, color: AppColors.ink,
        ),
        headlineSmall: GoogleFonts.playfairDisplay(
          fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.ink,
        ),
        bodyLarge: GoogleFonts.sourceSans3(
          fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.ink,
        ),
        bodyMedium: GoogleFonts.sourceSans3(
          fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.ink,
        ),
        bodySmall: GoogleFonts.sourceSans3(
          fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.muted,
        ),
        labelLarge: GoogleFonts.sourceSans3(
          fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink,
          letterSpacing: 1.0,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.cream.withOpacity(0.97),
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20, color: AppColors.ink, fontWeight: FontWeight.w400,
        ),
        iconTheme: const IconThemeData(color: AppColors.ink),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.cream,
          textStyle: GoogleFonts.sourceSans3(
            fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 1.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          tapTargetSize: MaterialTapTargetSize.padded, // bigger touch target
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.border),
          textStyle: GoogleFonts.sourceSans3(fontSize: 13, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          tapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.border, thickness: 1),
    );
  }
}