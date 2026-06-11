import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color indigo = Color(0xFF6366F1);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color rose = Color(0xFFF472B6);
  static const Color amber = Color(0xFFFBBF24);
  static const Color mint = Color(0xFF34D399);

  static const Color darkBackground = Color(0xFF0B0F1A);
  static const Color darkSurface = Color(0xFF141B2D);
  static const Color darkSurfaceHigh = Color(0xFF1C2640);
  static const Color darkBorder = Color(0xFF2A3555);

  static const Color lightBackground = Color(0xFFF3F5FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceHigh = Color(0xFFEEF1FA);
  static const Color lightBorder = Color(0xFFDDE3F2);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [indigo, violet, rose],
  );

  static const LinearGradient subtleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x336366F1),
      Color(0x338B5CF6),
      Color(0x22F472B6),
    ],
  );

  static const LinearGradient glowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x406366F1),
      Color(0x008B5CF6),
    ],
  );
}
