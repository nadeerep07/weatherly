import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF2196F3); // Blue
  static const Color secondaryColor = Color(0xFF4CAF50); // Green
  static const Color accentColor = Color(0xFFFFC107); // Amber
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light Gray
  static const Color textColor = Color(0xFF212121); // Dark Gray
  static const Color errorColor = Color(0xFFF44336); // Red
  static const Gradient dayGradient = LinearGradient(
    colors: [Color(0xFF64B5F6), Color(0xFF1976D2)], // Blue shades
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Gradient nightGradient = LinearGradient(
    colors: [Color(0xFF1A237E), Colors.black], // Blue shades
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
