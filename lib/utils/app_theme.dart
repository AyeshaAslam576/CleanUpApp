import 'package:flutter/material.dart';

class AppTheme {
  // Color Palettes
  static const Color _primaryBlue = Color(0xFF02A4FF);
  static const Color _primaryBlueDark = Color(0xFF0188E6);
  static const Color _accentRed = Color(0xFFD82121);
  static const Color _accentRedLight = Color(0xFFD82121);

  // Light Theme Colors
  static const Color _lightBackground = Color(0xFFEEF1F9);
  static const Color _lightSurface = Color(0xFFF8F9FA);
  static const Color _lightCard = Color(0xFFFFFFFF);
  static const Color _lightText = Color(0xFF1A1A1A);
  static const Color _lightTextSecondary = Color(0xFF6C757D);
  static const Color _lightBorder = Color(0xFFE9ECEF);
  static const Color _lightShadow = Color(0x1A000000);

  // Dark Theme Colors
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkCard = Color(0xFF2D2D2D);
  static const Color _darkText = Color(0xFFFFFFFF);
  static const Color _darkTextSecondary = Color(0xFFB0B0B0);
  static const Color _darkBorder = Color(0xFF404040);
  static const Color _darkShadow = Color(0x40000000);

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: _primaryBlue,
        secondary: _accentRed,
        surface: _lightSurface,
        background: _lightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _lightText,
        onBackground: _lightText,
      ),
      scaffoldBackgroundColor: _lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _lightBackground,
        foregroundColor: _lightText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _lightText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: _lightCard,
        elevation: 2,
        shadowColor: _lightShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryBlue, width: 2),
        ),
      ),
      dividerTheme: const DividerThemeData(color: _lightBorder, thickness: 1),
      iconTheme: const IconThemeData(color: _lightTextSecondary, size: 24),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: _primaryBlue,
        secondary: _accentRed,
        surface: _darkSurface,
        background: _darkBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: _darkText,
        onBackground: _darkText,
      ),
      scaffoldBackgroundColor: _darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: _darkText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: _darkText,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: _darkCard,
        elevation: 4,
        shadowColor: _darkShadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primaryBlue, width: 2),
        ),
      ),
      dividerTheme: const DividerThemeData(color: _darkBorder, thickness: 1),
      iconTheme: const IconThemeData(color: _darkTextSecondary, size: 24),
    );
  }

  // Theme-aware colors
  static Color get primaryBlue => _primaryBlue;
  static Color get primaryBlueDark => _primaryBlueDark;
  static Color get accentRed => _accentRed;
  static Color get accentRedLight => _accentRedLight;

  // Light theme colors
  static Color get lightBackground => _lightBackground;
  static Color get lightSurface => _lightSurface;
  static Color get lightCard => _lightCard;
  static Color get lightText => _lightText;
  static Color get lightTextSecondary => _lightTextSecondary;
  static Color get lightBorder => _lightBorder;
  static Color get lightShadow => _lightShadow;

  // Dark theme colors
  static Color get darkBackground => _darkBackground;
  static Color get darkSurface => _darkSurface;
  static Color get darkCard => _darkCard;
  static Color get darkText => _darkText;
  static Color get darkTextSecondary => _darkTextSecondary;
  static Color get darkBorder => _darkBorder;
  static Color get darkShadow => _darkShadow;
}
