import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primary = Color(0xFFE84C10);        // Orange-red
    static const Color lightOrange = Color.fromARGB(255, 223, 139, 106);        // Orange-red

  static const Color secondary = Color(0xFF29BEBF);      // Teal
  static const Color background = Color(0xFFFFFFFF);     // White
  static const Color surface = Color(0xFFFEFEFE);        // Light gray
  static const Color textPrimary = Color(0xFF14181B);    // Dark text
  static const Color textSecondary = Color(0xFF57636C);  // Gray text
    static const Color iconColor = Color.fromARGB(255, 152, 153, 153);  // Gray text
  static const Color fillColor = Color(0xFFD4D6D6);        // Green

  static const Color success = Color(0xFF249689);        // Green
  static const Color error = Color(0xFFFF5963);          // Red
  static const Color warning = Color(0xFFF9CF58);        // Yellow

  // Text Styles
  static TextStyle get headingLarge => GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get headingMedium => GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static TextStyle get headingSmall => GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppTheme.iconColor,
  );

  static TextStyle get bodySmall => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
   static TextStyle get bodySmallOrange => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: primary,
  );
 static TextStyle get bodySmallWhite => GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: surface,
  );

  static TextStyle get buttonText => GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
static TextStyle get buttonText2 => GoogleFonts.plusJakartaSans(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  // Theme Data for MaterialApp
  static ThemeData get lightTheme => ThemeData(
    primarySwatch: MaterialColor(0xFFE84C10, {
      50: Color(0xFFFDEFEB),
      100: Color(0xFFFAD6CC),
      200: Color(0xFFF6BAAA),
      300: Color(0xFFF29E88),
      400: Color(0xFFEE8970),
      500: Color(0xFFE84C10), // Primary color
      600: Color(0xFFE54508),
      700: Color(0xFFE23B06),
      800: Color(0xFFDE3205),
      900: Color(0xFFD82102),
    }),
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      background: background,
      surface: surface,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: textPrimary,
      onSurface: textPrimary,
      onError: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: headingLarge,
      headlineMedium: headingMedium,
      headlineSmall: headingSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      titleTextStyle: headingMedium.copyWith(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        textStyle: buttonText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

// Helper extension for easy color access
extension AppColors on BuildContext {
  Color get primaryColor => AppTheme.primary;
  Color get secondaryColor => AppTheme.secondary;
  Color get backgroundColor => AppTheme.background;
  Color get textColor => AppTheme.textPrimary;
  Color get secondaryTextColor => AppTheme.textSecondary;
}

// Helper extension for easy text style access
extension AppTextStyles on BuildContext {
  TextStyle get headingLarge => AppTheme.headingLarge;
  TextStyle get headingMedium => AppTheme.headingMedium;
  TextStyle get headingSmall => AppTheme.headingSmall;
  TextStyle get bodyLarge => AppTheme.bodyLarge;
  TextStyle get bodyMedium => AppTheme.bodyMedium;
  TextStyle get bodySmall => AppTheme.bodySmall;
}