import 'package:flutter/material.dart';

/// App color palette based on the Figma design
abstract class AppColors {
  // Background colors
  static const Color background = Color(0xFFF4F6F9);
  static const Color white = Color(0xFFFFFFFF);

  // Primary colors
  static const Color primary = Color(0xFF0167FF);
  static const Color primaryLight = Color(0xFFE6F0FF);

  // Text colors
  static const Color textPrimary = Color(0xFF13171B);
  static const Color textSecondary = Color(0xFF1E1E27);
  static const Color textPlaceholder = Color(0xFF89929F);
  static const Color textBlue = Color(0xFF3485FF);

  // Selection highlight
  static const Color selectionHighlight = Color(0xFFEDF4FF);

  // Border/Stroke colors
  static const Color strokePrimary = Color(0xFFEBEDF0);
  static const Color strokeSecondary = Color(0xFFE6F0FF);
  static const Color inputBorder = Color(0xFFF0F2F5);
  static const Color inputBackground = Color(0xFFF4F6F9);

  // Action button colors
  static const Color actionButtonBorder = Color(0xFF21A3FE);
  static const Color actionButtonShadow = Color(0x1A000000);

  // Bottom sheet
  static const Color bottomSheetHandle = Color(0xFFECEEF1);

  // Send icon color
  static const Color sendIcon = Color(0xFF718AB1);
}
