import 'package:flutter/material.dart';

class NazelColors {
  NazelColors._();

  // Primary brand purples
  static const Color primary = Color(0xFF532093);
  static const Color primaryDark = Color(0xFF391069);
  static const Color primaryLight = Color(0xFF681CB0);
  static const Color purpleTint = Color(0xFFEAD9FF);
  static const Color purpleSoft = Color(0xFFF1E9F8);
  static const Color purpleBorder = Color(0xFFAE88D5);

  // Warm & Gold accents
  static const Color gold = Color(0xFFDBBD75);
  static const Color goldLight = Color(0xFFF2BD70);
  static const Color goldDark = Color(0xFFD59738);
  static const Color peachSoft = Color(0xFFF3E1D5);

  // Status colors
  static const Color success = Color(0xFF60B12C);
  static const Color successLight = Color(0xFFB7F1B7);
  static const Color danger = Color(0xFFE53935);

  // Neutral & Surfaces
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1D1B20);
  static const Color background = Color(0xFFF8F5FB);
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8F8F8F);
  static const Color borderLight = Color(0xFFD9D9D9);
  static const Color overlayDim = Color(0x73000000);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [primaryLight, primary],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [goldLight, gold],
  );
}
