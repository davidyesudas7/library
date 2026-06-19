import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryContainer,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryContainer,
        onSecondaryContainer: AppColors.onSecondaryContainer,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onTertiary,
        tertiaryContainer: AppColors.tertiaryContainer,
        onTertiaryContainer: AppColors.onTertiaryContainer,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorContainer,
        onErrorContainer: AppColors.onErrorContainer,
        background: AppColors.background,
        onBackground: AppColors.onBackground,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        surfaceVariant: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
    );

    return baseTheme.copyWith(
      textTheme: baseTheme.textTheme.copyWith(
        displayLarge: GoogleFonts.ebGaramond(
          fontSize: 48,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.01 * 48,
          height: 56 / 48,
        ),
        headlineLarge: GoogleFonts.ebGaramond(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          height: 40 / 32,
        ),
        headlineMedium: GoogleFonts.ebGaramond(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          height: 32 / 24,
        ),
        titleLarge: GoogleFonts.hankenGrotesk(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.02 * 18,
          height: 24 / 18,
        ),
        bodyLarge: GoogleFonts.hankenGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 26 / 16,
        ),
        bodyMedium: GoogleFonts.hankenGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
        ),
        labelLarge: GoogleFonts.hankenGrotesk(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1 * 12,
          height: 16 / 12,
        ), // Map label-caps to labelLarge
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.outlineVariant, width: 1),
        ),
        color: AppColors.surfaceContainerLowest,
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: GoogleFonts.hankenGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1 * 12,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          textStyle: GoogleFonts.hankenGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.1 * 12,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
