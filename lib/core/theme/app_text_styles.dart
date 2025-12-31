import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// App text styles based on the Figma design
abstract class AppTextStyles {
  // Plus Jakarta Sans - Medium - 16px (Text L/Medium)
  static TextStyle get textLMedium => GoogleFonts.plusJakartaSans(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 22 / 16,
    letterSpacing: 0.08,
    color: AppColors.textPrimary,
  );

  // Plus Jakarta Sans - Medium - 14px (Text M/Medium)
  static TextStyle get textMMedium => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.07,
    color: AppColors.textPrimary,
  );

  // Plus Jakarta Sans - Medium - 14px for chips
  static TextStyle get chipText => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // Plus Jakarta Sans - Medium - 14px for buttons
  static TextStyle get buttonText => GoogleFonts.plusJakartaSans(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.white,
  );

  // Urbanist - SemiBold - 16px (for status bar)
  static TextStyle get urbanistSemiBold => GoogleFonts.urbanist(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: 0.2,
    color: AppColors.textPrimary,
  );

  // Text with blue highlight (selected text)
  static TextStyle get textHighlighted =>
      textLMedium.copyWith(color: AppColors.textBlue);

  // Placeholder text style
  static TextStyle get placeholder =>
      textMMedium.copyWith(color: AppColors.textPlaceholder);
}
