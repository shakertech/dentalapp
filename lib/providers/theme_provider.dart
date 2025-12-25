import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  /// 🌈 Gradient
  LinearGradient get primaryGradient => const LinearGradient(
    colors: [
      Color(0xFF1E88E5), // Blue 600
      Color(0xFF00ACC1), // Cyan 600
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// 🌤️ Light Theme
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E88E5), // Blue 600
      brightness: Brightness.light,
      primary: const Color(0xFF1E88E5),
      secondary: const Color(0xFF26C6DA), // Cyan 400
      surface: const Color(0xFFFFFFFF),
      onSurface: const Color(0xFF1E293B), // Slate 800
      onSurfaceVariant: const Color(0xFF64748B), // Slate 500
      error: const Color(0xFFEF4444), // Red 500
      outline: const Color(0xFFCBD5E1), // Slate 300
    ),
    scaffoldBackgroundColor: const Color(0xFFF1F5F9), // Slate 100
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E88E5),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shadowColor: const Color(0x1A000000), // Soft shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE2E8F0)), // Slate 200
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A), // Slate 900
          fontSize: 28,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xFF0F172A),
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF1E293B),
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF334155), // Slate 700
          fontSize: 16,
        ),
        bodyLarge: TextStyle(color: Color(0xFF334155), fontSize: 16),
        bodyMedium: TextStyle(
          color: Color(0xFF475569),
          fontSize: 14,
        ), // Slate 600
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: GoogleFonts.inter(
        color: const Color(0xFF64748B),
        fontWeight: FontWeight.w500,
      ),
      hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFEF4444)),
      ),
    ),
  );

  /// 🌙 Dark Theme
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF80CBC4),
      brightness: Brightness.dark,
      primary: const Color(0xFF80CBC4), // Lighter Teal for dark mode
      secondary: const Color(0xFF00ACC1),
      surface: const Color(0xFF1E1E1E),
      onSurface: const Color(0xFFECEFF1),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF263238),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textTheme: GoogleFonts.interTextTheme(
      const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 28,
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 24,
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFFECEFF1),
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xFFECEFF1),
          fontSize: 16,
        ),
        bodyLarge: TextStyle(color: Color(0xFFCFD8DC), fontSize: 16),
        bodyMedium: TextStyle(color: Color(0xFFB0BEC5), fontSize: 14),
      ),
    ),
    cardColor: const Color(0xFF263238),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF263238),
      labelStyle: GoogleFonts.inter(color: const Color(0xFFB0BEC5)),
      hintStyle: GoogleFonts.inter(color: const Color(0xFF78909C)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF455A64)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF455A64)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF80CBC4), width: 2),
      ),
    ),
  );
}
