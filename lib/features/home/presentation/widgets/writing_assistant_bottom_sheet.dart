import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../application/text_assistant_provider.dart';
import '../../domain/text_action.dart';
import 'action_chip.dart' show AiActionChip;

/// Bottom sheet widget for displaying writing assistant options.
class WritingAssistantBottomSheet extends HookConsumerWidget {
  const WritingAssistantBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: .min,
        children: [
          SizedBox(height: 12.h),
          // Custom prompt input
          _PromptInput(),
          SizedBox(height: 12.h),
          // Action chips
          _ActionChips(),
          SizedBox(height: 16.h),
          // Action buttons
          _ActionButtons(),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}

class _ActionButtons extends HookConsumerWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: 8.w,
      children: [
        // Insert button (primary)
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            // Handle insert action
            ref.read(textSelectionProvider.notifier).clearSelection();
          },
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(120.w, 36.h)),
          ),
          child: Text('Insert'),
        ),

        // Replace button (secondary)
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
            // Handle replace action
            ref.read(textSelectionProvider.notifier).clearSelection();
          },
          style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(120.w, 36.h)),
          ),
          child: Text('Replace'),
        ),
      ],
    );
  }
}

class _PromptInput extends HookConsumerWidget {
  const _PromptInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    return Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(27.r),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.textMMedium,
              decoration: InputDecoration(
                hintText: 'Write a promt here...',
                hintStyle: AppTextStyles.placeholder,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  // onActionSelected(TextAction.customPrompt, value.trim());
                  // ref
                  //     .read(textSelectionProvider.notifier)
                  //     .updateSelection(
                  //       customPrompt: value.trim(),
                  //       action: TextAction.customPrompt,
                  //     );

                  Navigator.pop(context, (
                    TextAction.customPrompt,
                    value.trim(),
                  ));
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                // // onActionSelected(TextAction.customPrompt, text);
                // ref
                //     .read(textSelectionProvider.notifier)
                //     .updateSelection(
                //       customPrompt: text,
                //       action: TextAction.customPrompt,
                //     );

                Navigator.pop(context, (
                  TextAction.customPrompt,
                  text,
                ));
              }
            },
            child: SvgPicture.asset(
              'assets/icons/send.svg',
              width: 20.w,
              height: 20.w,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChips extends HookConsumerWidget {
  const _ActionChips();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = TextAction.values.where(
      (action) => action != TextAction.customPrompt,
    );
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: actions.map((action) {
        return AiActionChip(
          label: action.label,
          onTap: () {
            // ref
            //     .read(textSelectionProvider.notifier)
            //     .updateSelection(
            //       action: action,
            //     );
            Navigator.pop(context, (action, null));
          },
        );
      }).toList(),
      // children: [
      //   // First row - fixed width chips
      //   AiActionChip(
      //     label: 'Improve Writting',
      //     onTap: () {
      //       ref
      //           .read(textSelectionProvider.notifier)
      //           .updateSelection(
      //             action: TextAction.improveWriting,
      //           );
      //       Navigator.pop(context, ());
      //     },
      //   ),
      //   AiActionChip(
      //     label: 'Plagiarism Check',
      //     onTap: () {
      //       ref
      //           .read(textSelectionProvider.notifier)
      //           .updateSelection(
      //             action: TextAction.plagiarismCheck,
      //           );
      //       Navigator.pop(context);
      //     },
      //   ),
      //   // Second row
      //   AiActionChip(
      //     label: 'Regererate',
      //     onTap: () {
      //       ref
      //           .read(textSelectionProvider.notifier)
      //           .updateSelection(
      //             action: TextAction.regenerate,
      //           );
      //       Navigator.pop(context);
      //     },
      //   ),
      //   AiActionChip(
      //     label: 'Add a summary',
      //     onTap: () {
      //       ref
      //           .read(textSelectionProvider.notifier)
      //           .updateSelection(
      //             action: TextAction.addSummary,
      //           );
      //       Navigator.pop(context);
      //     },
      //   ),
      //   // Third row
      //   AiActionChip(
      //     label: 'Add a summary',
      //     onTap: () {
      //       ref
      //           .read(textSelectionProvider.notifier)
      //           .updateSelection(
      //             action: TextAction.addSummary,
      //           );
      //       Navigator.pop(context);
      //     },
      //   ),
      //   AiActionChip(
      //     label: 'Add a summary',
      //     onTap: () {
      //       ref
      //           .read(textSelectionProvider.notifier)
      //           .updateSelection(
      //             action: TextAction.addSummary,
      //           );
      //     },
      //   ),
      // ],
    );
  }
}
