import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF2E7D32), // Deep green (primary)
    scaffoldBackgroundColor: const Color(0xFFF9F9F9), // Light background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E7D32),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF2E7D32),
      secondary: const Color(0xFF81C784), // Soft green
      tertiary: const Color(0xFFFFB300), // Amber accent
      background: const Color(0xFFF9F9F9),
      surface: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFB300),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black54),
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF00E676), // Bright green for dark mode
    scaffoldBackgroundColor: const Color(0xFF121212), // Dark gray background
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF00E676),
      secondary: const Color(0xFF29B6F6), // Light blue
      tertiary: const Color(0xFFFF7043), // Orange for expenses
      background: const Color(0xFF121212),
      surface: const Color(0xFF1E1E1E),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF7043),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
