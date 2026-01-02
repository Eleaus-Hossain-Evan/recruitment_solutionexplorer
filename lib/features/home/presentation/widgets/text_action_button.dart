import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/text_assistant_provider.dart';

/// Floating action button that appears when text is selected.
/// Animates in from right when shown, animates out to right when hidden.
class TextActionButton extends HookConsumerWidget {
  const TextActionButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = useState(false);

    // Listen to provider changes
    ref.listen<SelectionState>(textSelectionProvider, (previous, next) {
      if (isVisible.value != next.isVisible) {
        isVisible.value = next.isVisible;
      }
    });

    return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 61,
            height: 52,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(46),
                bottomLeft: Radius.circular(46),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x406378BA),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
            child: Container(
              width: 44,
              height: 44,
              // margin: const EdgeInsets.only(left: 4, top: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                // border: Border.all(
                //   color: const Color(0xFF21A3FE),
                //   width: 1.1,
                // ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 5.5,
                    offset: Offset(0, 2.75),
                  ),
                ],
              ),
              // alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                children: [
                  Center(
                    child: Image.asset('assets/images/gradient-circle.png')
                        .animate(target: isVisible.value ? 0 : 1)
                        // Entry animation (plays when isVisible becomes true)
                        .animate()
                        .fadeIn(duration: 250.ms, curve: Curves.easeOut)
                        .slideX(
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
                        .rotate(
                          begin: 0,
                          end: 3.14159265359, // 360 degrees
                          duration: 300.ms,
                          curve: Curves.easeOut,
                        )
                        // Exit animation (plays when isVisible becomes false)
                        .then()
                        .animate(target: isVisible.value ? 0 : 1)
                        .fadeOut(duration: 250.ms, curve: Curves.easeIn)
                        .slideX(
                          begin: 0,
                          end: 0.3,
                          duration: 250.ms,
                          curve: Curves.easeInCubic,
                        )
                        .rotate(
                          begin: 0,
                          end: -3.14159265359, // -360 degrees (reverse)
                          duration: 250.ms,
                          curve: Curves.easeInCubic,
                        ),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/icons/ai-prompt.svg',
                      width: 22,
                      height: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(target: isVisible.value ? 0 : 1)
        // Entry animation (plays when isVisible becomes true)
        .animate()
        .fadeIn(duration: 250.ms, curve: Curves.easeOut)
        .slideX(
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
        // Exit animation (plays when isVisible becomes false)
        .then()
        .animate(target: isVisible.value ? 0 : 1)
        .fadeOut(duration: 250.ms, curve: Curves.easeIn)
        .slideX(
          begin: 0,
          end: 0.3,
          duration: 250.ms,
          curve: Curves.easeInCubic,
        );
  }
}
