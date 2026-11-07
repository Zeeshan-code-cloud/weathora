
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static AppColorPalette get light => const AppColorPalette(
    primary: Color(0xFF3978F6),
    secondary: Color(0xFF73B8FF),
    accent: Color(0xFF38BDF8),
    background: Color(0xFFF5F8FF),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFEAF0FA),
    textPrimary: Color(0xFF17233C),
    textSecondary: Color(0xFF6B7890),
    border: Color(0xFFE0E7F2),
    success: Color(0xFF20A878),
    warning: Color(0xFFF5A623),
    error: Color(0xFFE5484D),
    icon: Color(0xFF526581),
    shadow: Color(0x1430476B),
    primaryGradient:  LinearGradient(
  begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF5148D8),
      Color(0xFF3C79F5),
      Color(0xFF36D7FF),
    ],
  ),
  );

  static AppColorPalette get dark => const AppColorPalette(
    primary: Color(0xFF79A5FF),
    secondary: Color(0xFF4C9BFF),
    accent: Color(0xFF38BDF8),
    background: Color(0xFF0D1424),
    surface: Color(0xFF182238),
    surfaceVariant: Color(0xFF222F48),
    textPrimary: Color(0xFFF0F5FF),
    textSecondary: Color(0xFFA0AEC4),
    border: Color(0xFF2B3A54),
    success: Color(0xFF42D6A0),
    warning: Color(0xFFFFC15C),
    error: Color(0xFFFF7277),
    icon: Color(0xFFB7C5DC),
    shadow: Color(0x33000000),
    primaryGradient:   LinearGradient(
  begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF5148D8),
      Color(0xFF3C79F5),
      Color(0xFF36D7FF),
    ],
  ),
  );
}

class AppColorPalette {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color success;
  final Color warning;
  final Color error;
  final Color icon;
  final Color shadow;
  final LinearGradient primaryGradient;

  const AppColorPalette({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.success,
    required this.warning,
    required this.error,
    required this.icon,
    required this.shadow,
    required this.primaryGradient
  });
}
