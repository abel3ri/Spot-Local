import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xffe65100),
    colorScheme: const ColorScheme.light(
      primary: Color(0xffe65100),
      primaryContainer: Color(0xffffcc80),
      secondary: Color(0xff2979ff),
      secondaryContainer: Color(0xffe4eaff),
      tertiary: Color(0xff2962ff),
      error: Color(0xffb00020),
      surface: Color(0xFFF5F5F5),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF5F5F5),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    fontFamily: GoogleFonts.quicksand().fontFamily,
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF5F5F5),
      selectedItemColor: Color(0xffe65100),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      showUnselectedLabels: true,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xffff5722),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    fontFamily: GoogleFonts.quicksand().fontFamily,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      headlineSmall: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      headlineLarge: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xffff5722),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      showUnselectedLabels: true,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff0b429c),
      brightness: Brightness.dark,
    )
        .copyWith(
          primary: const Color(0xffff5722),
          primaryContainer: const Color(0xffc87200),
          secondary: const Color(0xff82b1ff),
          secondaryContainer: const Color(0xff3770cf),
          tertiary: const Color(0xff448aff),
          error: const Color(0xffcf6679),
          surface: const Color(0xFF1E1E1E),
        )
        .copyWith(error: const Color(0xffcf6679)),
  );
}
