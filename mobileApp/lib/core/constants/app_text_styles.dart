import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppTextStyles {
  static const String _fontFamily = 'Poppins'; // Change to your font

  static TextStyle headline(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: AppDimensions.fontLarge,
      fontWeight: FontWeight.bold,
      fontFamily: _fontFamily,
      color: isDark ? AppColors.darkText : AppColors.lightText,
    );
  }

  static TextStyle title(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: AppDimensions.fontTitle,
      fontWeight: FontWeight.w600,
      fontFamily: _fontFamily,
      color: isDark ? AppColors.darkText : AppColors.lightText,
    );
  }

  static TextStyle body(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: AppDimensions.fontBody,
      fontFamily: _fontFamily,
      color: isDark ? AppColors.darkText : AppColors.lightText,
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontBody,
      fontWeight: FontWeight.w600,
      fontFamily: _fontFamily,
      color: Colors.white, // always white on primary button
    );
  }
}