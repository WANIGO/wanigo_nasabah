import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2563EB); // Biru utama
  static const Color secondary = Color(0xFF4A90E2); // Biru muda
  static const Color accent = Color(0xFF6BBEF5);
  static const Color background = Colors.white;
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color highlight = Colors.blue;
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Colors.black54;
  static const Color purple = Color(0xFF9C27B0);
}

class AppTextStyles {

  static const TextStyle bold16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle regular14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subtitleWhite = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.white,
  );

  static const TextStyle contentBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle contentNormal = TextStyle(
    fontSize: 14,
  );

  static const TextStyle greeting = TextStyle(
    fontSize: 18,
    color: AppColors.textPrimary,
  );

  static const TextStyle greetingBold = TextStyle(
    fontSize: 18,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle smallBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle badge = TextStyle(
    color: AppColors.highlight,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
}
