import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  /// 🌤️ Light Theme
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2196F3), // Primary Blue
          brightness: Brightness.light,
          primary: const Color(0xFF1E88E5),
          secondary: const Color(0xFF90CAF9),
          surface: const Color(0xFFF6F8FC),
          onSurface: Colors.black87,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      );

  /// 🌙 Dark Theme
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF64B5F6),
          brightness: Brightness.dark,
          primary: const Color(0xFF64B5F6),
          secondary: const Color(0xFF1565C0),
          surface: const Color(0xFF121212),
          onSurface: Colors.white70,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1E1E1E),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: const TextTheme(
          headlineSmall:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        cardColor: const Color(0xFF1E1E1E),
      );
}
