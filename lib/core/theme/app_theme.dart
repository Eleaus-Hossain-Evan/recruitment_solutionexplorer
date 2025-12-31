import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  // Prevent instantiation
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
    // Custom text selection theme to match Figma design
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: AppColors.selectionHighlight,
      cursorColor: AppColors.primary,
      selectionHandleColor: AppColors.primary,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.buttonText,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 21.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: AppColors.strokeSecondary),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.buttonText,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 21.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: AppColors.strokeSecondary),
        ),
        side: BorderSide(color: AppColors.strokeSecondary),
      ),
    ),
  );
}
