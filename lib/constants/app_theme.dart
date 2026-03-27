import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ── Brand Colours ────────────────────────────────────────────
  static const Color primary = Color(0xFFE67E22); // Warm Orange
  static const Color secondary = Color(0xFF00796B); // Deep Teal
  static const Color background = Color(0xFFFFFFFF); // Clean White
  static const Color textDark = Color(0xFF2C3E50); // Deep Navy/Charcoal
  static const Color textGrey = Color(0xFF7F8C8D); // Soft Grey
  static const Color cardShadow = Color(0x1A2C3E50); // Navy shadow, 10% opacity

  // ── Category Colours (harmonised with brand) ─────────────────
  static const Map<String, Color> categoryColors = {
    'Swallows': Color(0xFFFFF3E0), // warm sandy
    'Rice': Color(0xFFFCE4EC), // soft rose
    'Soups': Color(0xFFE8F5E9), // fresh green
    'Proteins': Color(0xFFE3F2FD), // cool blue
    'Drinks': Color(0xFFE0F2F1), // teal tint
  };

  // ── Light Theme ───────────────────────────────────────────────
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      surface: background,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textDark,
    ),

    // ── Typography ──────────────────────────────────────────────
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: textDark,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textDark,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: textDark,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textGrey,
      ),
    ),

    // ── AppBar ──────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textDark,
      ),
      iconTheme: const IconThemeData(color: textDark),
    ),

    // ── Primary Button (Warm Orange) ────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),

    // ── Secondary / Outlined Button (Deep Teal) ─────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondary,
        side: const BorderSide(color: secondary, width: 1.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),

    // ── Text Button ─────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondary,
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),

    // ── Input Fields ────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF7F7F7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primary, width: 1.8),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      labelStyle: GoogleFonts.poppins(color: textGrey, fontSize: 14),
      hintStyle: GoogleFonts.poppins(color: textGrey, fontSize: 14),
    ),

    // ── FAB ─────────────────────────────────────────────────────
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: StadiumBorder(),
    ),

    // ── Chip ────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      selectedColor: primary.withOpacity(0.15),
      labelStyle: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),
      side: BorderSide.none,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // ── Divider ─────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: Color(0xFFEEEEEE),
      thickness: 1,
      space: 1,
    ),
  );

  // ── Helper: View Full Menu button style (Deep Teal filled) ───
  static ButtonStyle get viewMenuButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: secondary,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
  );
}
