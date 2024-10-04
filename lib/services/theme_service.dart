// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     primaryColor: const Color(0xffe65100),
//     colorScheme: const ColorScheme.light(
//       primary: Color(0xffe65100),
//       primaryContainer: Color(0xffffcc80),
//       secondary: Color(0xff00796b),
//       secondaryContainer: Color(0xffb2dfdb),
//       tertiary: Color(0xff004d40),
//       error: Color(0xffb00020),
//       surface: Color(0xFFF5F5F5),
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFFF5F5F5),
//       elevation: 0,
//     ),
//     scaffoldBackgroundColor: const Color(0xFFF5F5F5),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     useMaterial3: true,
//     fontFamily: GoogleFonts.quicksand().fontFamily,
//     textTheme: const TextTheme(
//       bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
//       bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//       bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
//       titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//       titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Color(0xFFF5F5F5),
//       selectedItemColor: Color(0xffe65100),
//       unselectedItemColor: Colors.grey,
//       selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle: TextStyle(
//         fontWeight: FontWeight.normal,
//         fontSize: 12,
//       ),
//       showUnselectedLabels: true,
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     primaryColor: const Color(0xffff5722),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF121212),
//       elevation: 0,
//     ),
//     scaffoldBackgroundColor: const Color(0xFF121212),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     useMaterial3: true,
//     fontFamily: GoogleFonts.quicksand().fontFamily,
//     textTheme: const TextTheme(
//       bodySmall: TextStyle(
//           fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
//       bodyMedium: TextStyle(
//           fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
//       bodyLarge: TextStyle(
//           fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
//       titleSmall: TextStyle(
//           fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//       titleMedium: TextStyle(
//           fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       titleLarge: TextStyle(
//           fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//       headlineSmall: TextStyle(
//           fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//       headlineMedium: TextStyle(
//           fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//       headlineLarge: TextStyle(
//           fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Color(0xFF121212),
//       selectedItemColor: Color(0xffff5722),
//       unselectedItemColor: Colors.grey,
//       selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle:
//           TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
//       showUnselectedLabels: true,
//     ),
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: const Color(0xff0b429c),
//       brightness: Brightness.dark,
//     )
//         .copyWith(
//           primary: const Color(0xffff5722),
//           primaryContainer: const Color(0xffc87200),
//           secondary: const Color(0xff4caf50),
//           secondaryContainer: const Color(0xffa5d6a7),
//           tertiary: const Color(0xff1b5e20),
//           error: const Color(0xffcf6679),
//           surface: const Color(0xFF121212),
//         )
//         .copyWith(error: const Color(0xffcf6679)),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xffe65100),
    colorScheme: const ColorScheme.light(
      primary: Color(0xffe65100),
      primaryContainer: Color(0xffffcc80),
      secondary: Color(0xff00796b),
      secondaryContainer: Color(0xffb2dfdb),
      tertiary: Color(0xff004d40),
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
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xffff5722),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF303030),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFF303030),
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
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffff5722),
      brightness: Brightness.dark,
    )
        .copyWith(
          primary: const Color(0xffff5722),
          primaryContainer: const Color(0xffc87200),
          secondary: const Color(0xff4caf50),
          secondaryContainer: const Color(0xffa5d6a7),
          tertiary: const Color(0xff1b5e20),
          error: const Color(0xffcf6679),
          surface: const Color(0xFF303030),
        )
        .copyWith(error: const Color(0xffcf6679)),
  );
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AppTheme {
//   static ThemeData lightTheme = ThemeData(
//     primaryColor: const Color(0xff219ebc),
//     colorScheme: const ColorScheme.light(
//       primary: Color(0xff219ebc),
//       primaryContainer: Color(0xff8ecae6),
//       secondary: Color(0xfffb8500),
//       secondaryContainer: Color(0xffffb703),
//       tertiary: Color(0xff023047),
//       error: Color(0xffb00020),
//       surface: Color(0xFFF5F5F5),
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFFF5F5F5),
//       elevation: 0,
//     ),
//     scaffoldBackgroundColor: const Color(0xFFF5F5F5),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     useMaterial3: true,
//     fontFamily: GoogleFonts.quicksand().fontFamily,
//     textTheme: const TextTheme(
//       bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
//       bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//       bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
//       titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//       titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Color(0xFFF5F5F5),
//       selectedItemColor: Color(0xff219ebc),
//       unselectedItemColor: Colors.grey,
//       selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle: TextStyle(
//         fontWeight: FontWeight.normal,
//         fontSize: 12,
//       ),
//       showUnselectedLabels: true,
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     primaryColor: const Color(0xff219ebc),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Color(0xFF121212),
//       elevation: 0,
//     ),
//     scaffoldBackgroundColor: const Color(0xFF121212),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     useMaterial3: true,
//     fontFamily: GoogleFonts.quicksand().fontFamily,
//     textTheme: const TextTheme(
//       bodySmall: TextStyle(
//           fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
//       bodyMedium: TextStyle(
//           fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
//       bodyLarge: TextStyle(
//           fontSize: 16, fontWeight: FontWeight.normal, color: Colors.white),
//       titleSmall: TextStyle(
//           fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//       titleMedium: TextStyle(
//           fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       titleLarge: TextStyle(
//           fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//       headlineSmall: TextStyle(
//           fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//       headlineMedium: TextStyle(
//           fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//       headlineLarge: TextStyle(
//           fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Color(0xFF121212),
//       selectedItemColor: Color(0xfffb8500),
//       unselectedItemColor: Colors.grey,
//       selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//       unselectedLabelStyle:
//           TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
//       showUnselectedLabels: true,
//     ),
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: const Color(0xff0b429c),
//       brightness: Brightness.dark,
//     )
//         .copyWith(
//           primary: const Color(0xff219ebc),
//           primaryContainer: const Color(0xff8ecae6),
//           secondary: const Color(0xfffb8500),
//           secondaryContainer: const Color(0xffffb703),
//           tertiary: const Color(0xff023047),
//           error: const Color(0xffcf6679),
//           surface: const Color(0xFF121212),
//         )
//         .copyWith(error: const Color(0xffcf6679)),
//   );
// }

