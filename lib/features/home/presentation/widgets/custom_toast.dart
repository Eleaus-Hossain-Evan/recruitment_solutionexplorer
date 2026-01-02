import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A custom toast widget that matches the Figma design.
/// Pill-shaped with white background, text and close button.
/// Includes smooth slide-up and fade animations.
/// Only dismisses when user taps the close button.
class CustomToast extends HookConsumerWidget {
  const CustomToast({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

  /// Shows the toast at the bottom of the screen with animations.
  /// Toast only dismisses when user taps the close button.
  static void show(
    BuildContext context, {
    required String message,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedToastOverlay(
        message: message,
        onDismiss: () {
          if (overlayEntry.mounted) {
            overlayEntry.remove();
          }
        },
      ),
    );

    overlay.insert(overlayEntry);
  }
}

/// Internal widget that handles the animated toast display.
class _AnimatedToastOverlay extends StatefulWidget {
  const _AnimatedToastOverlay({
    required this.message,
    required this.onDismiss,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  State<_AnimatedToastOverlay> createState() => _AnimatedToastOverlayState();
}

class _AnimatedToastOverlayState extends State<_AnimatedToastOverlay> {
  bool _isExiting = false;

  void _startExitAnimation() {
    setState(() => _isExiting = true);
    // Wait for exit animation to complete before removing
    Future.delayed(const Duration(milliseconds: 300), widget.onDismiss);
  }

  void _handleDismiss() {
    if (!_isExiting) {
      _startExitAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom + 40.h,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child:
              CustomToast(
                    message: widget.message,
                    onDismiss: _handleDismiss,
                  )
                  .animate(target: _isExiting ? 1 : 0)
                  // Entry animation (plays on mount)
                  .animate()
                  .fadeIn(duration: 250.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.5,
                    end: 0,
                    duration: 300.ms,
                    curve: Curves.easeOutCubic,
                  )
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1, 1),
                    duration: 250.ms,
                    curve: Curves.easeOut,
                  )
                  // Exit animation (plays when _isExiting becomes true)
                  .then()
                  .animate(target: _isExiting ? 1 : 0)
                  .fadeOut(duration: 250.ms, curve: Curves.easeIn)
                  .slideY(
                    begin: 0,
                    end: 0.3,
                    duration: 250.ms,
                    curve: Curves.easeInCubic,
                  ),
        ),
      ),
    );
  }
}
