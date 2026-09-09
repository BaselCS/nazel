import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class NazelTypography {
  NazelTypography._();

  static TextStyle arabic({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = NazelColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.tajawal(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle latin({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = NazelColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.tajawal(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Pre-configured Styles (Responsive with .sp)
  static TextStyle get displayLarge => arabic(
        fontSize: 36.0,
        fontWeight: FontWeight.w900,
        color: NazelColors.textPrimary,
      );

  static TextStyle get modalTitle => arabic(
        fontSize: 32.0,
        fontWeight: FontWeight.w900,
        color: NazelColors.primary,
      );

  static TextStyle get sectionTitle => arabic(
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
        color: NazelColors.textPrimary,
      );

  static TextStyle get serviceTitle => arabic(
        fontSize: 21.0,
        fontWeight: FontWeight.w900,
        color: NazelColors.textPrimary,
      );

  static TextStyle get serviceSubtitle => arabic(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: NazelColors.textSecondary,
      );

  static TextStyle get bodyLarge => arabic(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: NazelColors.textPrimary,
      );

  static TextStyle get bodyMedium => arabic(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: NazelColors.textPrimary,
      );

  static TextStyle get bodySmall => arabic(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: NazelColors.textSecondary,
      );

  static TextStyle get caption => arabic(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: NazelColors.textSecondary,
      );
}
