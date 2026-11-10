import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundPink,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryTeal,
        background: AppColors.backgroundPink,
        onBackground: AppColors.backgroundLight,
        primary: AppColors.primaryTeal,
        secondary: AppColors.accentPink,
        onSecondary: AppColors.textSecondary,
        onSecondaryContainer: AppColors.accentOrange,
        surface: AppColors.surfaceWhite,
        onSurface: AppColors.textPrimary,
        onInverseSurface: AppColors.textPlaceholder,
        error: AppColors.error,
      ),

      // Typography styling
      textTheme: TextTheme(
        displayLarge: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 36,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceWhite,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 20,
        ),
        hintStyle: GoogleFonts.quicksand(
          color: AppColors.textPlaceholder,
          fontSize: 20,
        ),
        errorStyle: GoogleFonts.quicksand(
          color: AppColors.error,
          fontSize: 12,
          height: 2,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
        ),
      ),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: GoogleFonts.quicksand(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.primaryTeal,
        contentTextStyle: GoogleFonts.quicksand(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          backgroundColor: AppColors.primaryTeal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26), // Fully rounded pill shape
          ),
          elevation: 0,
          textStyle: GoogleFonts.fredoka(
            fontSize: 20,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: AppColors.surfaceWhite,
          foregroundColor: AppColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade300, width: 0.5),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}
