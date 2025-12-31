import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';

/// Floating action button that appears when text is selected.
/// Positioned at center-right of the screen.
class TextActionButton extends StatelessWidget {
  const TextActionButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 61.w,
        height: 51.h,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(46),
            bottomLeft: Radius.circular(46),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 4.w, top: 4.h),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.actionButtonBorder,
                width: 1.1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.actionButtonShadow,
                  blurRadius: 5.5,
                  offset: Offset(0, 2.75),
                ),
              ],
            ),
            padding: EdgeInsets.all(1.375.w),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/ai-prompt.svg',
                width: 22.w,
                height: 22.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
