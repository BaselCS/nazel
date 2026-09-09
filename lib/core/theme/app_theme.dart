import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimens.dart';

class NazelTheme {
  NazelTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: NazelColors.background,
      primaryColor: NazelColors.primary,
      colorScheme: const ColorScheme.light(
        primary: NazelColors.primary,
        secondary: NazelColors.gold,
        surface: NazelColors.surfaceWhite,
        error: NazelColors.danger,
      ),
      cardTheme: CardThemeData(
        color: NazelColors.surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NazelDimens.radiusLg),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
