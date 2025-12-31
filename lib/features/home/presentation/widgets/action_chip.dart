import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A chip widget for displaying predefined action options in the bottom sheet.
class AiActionChip extends StatelessWidget {
  const AiActionChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      onSelected: (value) => onTap(),
      avatar: SvgPicture.asset(
        'assets/icons/ai-icon.svg',
        width: 16.w,
        height: 16.w,
      ),
      label: Text(label, style: AppTextStyles.chipText),
      selected: false,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.r),
        side: BorderSide(color: AppColors.strokePrimary),
      ),
    );
  }
}
