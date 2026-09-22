import 'package:flutter/material.dart';

class NazelColors {
  NazelColors._();

  // Primary brand purples
  static const Color primary = Color(0xFF532093);
  static const Color primaryDark = Color(0xFF391069);
  static const Color primaryLight = Color(0xFF681CB0);
  static const Color accentPurple = Color(0xFF8A38F5);
  static const Color purpleTint = Color(0xFFEAD9FF);
  static const Color purpleSoft = Color(0xFFF1E9F8);
  static const Color purpleBorder = Color(0xFFAE88D5);

  // Sidebar dark purples (used in the right sidebar background/cards)
  static const Color sidebarBg = Color(0xFF1A0A2D);
  static const Color sidebarDeep = Color(0xFF14022A);
  static const Color sidebarCard = Color(0xFF260D49);

  // Const alpha-variants (for use inside const widget trees / gradients)
  static const Color primaryFade93 = Color(0xEE532093); // ~93% opacity
  static const Color primaryFade40 = Color(0x66532093); // ~40% opacity
  static const Color goldDivider = Color(0xffF5C989);

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
  static const Color textSecondary = Color(0xFF666666);
  static const Color borderLight = Color(0xFFD9D9D9);
  static const Color overlayDim = Color(0x73000000);

  // Kiosk & Editorial Theme Tokens
  static const Color sand = Color(0xFFF6F2EC);
  static const Color paper = Color(0xFFFAF7F2);
  static const Color ink = Color(0xFF1E1C1A);
  static const Color muted = Color(0xFF7A756E);
  static const Color line = Color(0xFFE5DFD5);
  static const Color khuzama = Color(0xFF532093);

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
