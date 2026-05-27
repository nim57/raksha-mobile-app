import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

class AppTextStyles {
  static const String _fontFamily = 'Poppins'; // Change to your font


  // New: Skip button text style
  static TextStyle skipButton(BuildContext context) {
    // No dynamic dark/light change needed – uses fixed colour from design
    return GoogleFonts.inter(
      fontSize: AppDimensions.fontSmall,  // Assume you define fontSmall = 14.0
      fontWeight: FontWeight.w700,
      letterSpacing: 0.7,
      color: AppColors.onSurfaceVariant,    // = Color(0xFFE7BDB7)
    );
  }
}