import 'package:flutter/material.dart';

class AppTheme {
  // Warna baru - Biru Muda Soft yang Fresh
  static const Color primarySoftBlue = Color(0xFF81C3F8);      // Biru muda cerah
  static const Color secondarySkyBlue = Color(0xFFA8DAFF);     // Biru langit
  static const Color lightCyan = Color(0xFFD4F1FF);            // Cyan terang
  static const Color veryLightBlue = Color(0xFFF0F9FF);        // Putih kebiruan
  static const Color accentBlue = Color(0xFF5BA3D0);           // Biru aksen
  static const Color darkBlue = Color(0xFF2B6CB0);             // Biru gelap
  static const Color accentOrange = Color(0xFFFFA726);         // Orange untuk rating
  static const Color accentGreen = Color(0xFF66BB6A);          // Hijau untuk success
  static const Color accentPink = Color(0xFFEC407A);           // Pink untuk accent
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primarySoftBlue, secondarySkyBlue],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [veryLightBlue, Colors.white],
  );
  
  static ThemeData lightTheme = ThemeData(
    primaryColor: primarySoftBlue,
    scaffoldBackgroundColor: veryLightBlue,
    colorScheme: ColorScheme.light(
      primary: primarySoftBlue,
      secondary: secondarySkyBlue,
      surface: Colors.white,
      background: veryLightBlue,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primarySoftBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primarySoftBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 3,
        shadowColor: primarySoftBlue.withOpacity(0.4),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),
  
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: lightCyan, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: lightCyan, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primarySoftBlue, width: 2.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2.5),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primarySoftBlue,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
  
  // Box Shadow untuk kartu
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: primarySoftBlue.withOpacity(0.15),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];
  
  // Box Shadow untuk button
  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primarySoftBlue.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 6),
    ),
  ];
}