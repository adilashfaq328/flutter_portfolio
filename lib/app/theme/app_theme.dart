import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

sealed class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);

    final headline = GoogleFonts.spaceGroteskTextTheme(base.textTheme);
    final body = GoogleFonts.interTextTheme(headline);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.surfaceDim,
      textTheme: body.copyWith(
        displayLarge: body.displayLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -2,
          height: 0.95,
        ),
        headlineMedium: body.headlineMedium?.copyWith(
          fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
          fontWeight: FontWeight.w700,
          letterSpacing: -1,
        ),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryFixed,
        secondary: AppColors.secondary,
        surface: AppColors.surfaceDim,
        onSurface: AppColors.onSurface,
      ),
    );
  }
}

