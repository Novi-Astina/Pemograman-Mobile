import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Biru Muda Soft
  static const Color primary = Color(0xFF87CEEB);
  static const Color primaryLight = Color(0xFFB0E2FF);
  static const Color primaryDark = Color(0xFF5F9EA0);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF64B5F6);
  static const Color accent = Color(0xFF42A5F5);
  
  // Background Colors
  static const Color background = Color(0xFFF5F9FF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFE3F2FD);
  
  // Drawer Colors
  static const Color drawerHeader = Color(0xFF5F9EA0);
  static const Color drawerBackground = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);
  static const Color textWhite = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF29B6F6);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF87CEEB), Color(0xFF64B5F6)],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
  );
  
  // Shadow Colors
  static Color shadow = Colors.black.withOpacity(0.08);
  static Color shadowLight = Colors.black.withOpacity(0.04);
}