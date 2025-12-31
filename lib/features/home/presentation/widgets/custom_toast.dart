import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A custom toast widget that matches the Figma design.
/// Pill-shaped with white background, text and close button.
class CustomToast extends StatelessWidget {
  const CustomToast({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: AppTextStyles.textMMedium,
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onDismiss,
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 16.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows the toast at the bottom of the screen.
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).padding.bottom + 40.h,
        left: 0,
        right: 0,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: CustomToast(
              message: message,
              onDismiss: () => overlayEntry.remove(),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // // Auto dismiss after duration
    // Future.delayed(duration, () {
    //   if (overlayEntry.mounted) {
    //     overlayEntry.remove();
    //   }
    // });
  }
}
