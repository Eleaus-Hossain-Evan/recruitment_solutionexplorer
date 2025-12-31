import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../application/text_assistant_provider.dart';
import '../domain/text_action.dart';
import 'widgets/widgets.dart';

/// Default text content matching the Figma design
const String _defaultTextContent =
    '''Mispellings and grammatical errors can effect your credibility. The same goes for misused commas, and other types of punctuation . Not only will Grammarly underline these issues in red, it will also showed you how to correctly write the sentence.

Underlines that are blue indicate that Grammarly has spotted a sentence that is unnecessarily wordy. You'll find suggestions that can possibly help you revise a wordy sentence in an effortless manner.''';

/// Main home page for the Text Assistant feature.
/// Displays editable text content with selection-triggered action button.
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: _defaultTextContent);
    final focusNode = useFocusNode();

    // State to track if text is selected
    final isTextSelected = useState(false);

    // Listen to selection changes
    useEffect(() {
      void listener() {
        final selection = textController.selection;
        // Show button if selection is not collapsed (i.e., has range)
        isTextSelected.value = !selection.isCollapsed && selection.start != -1;
      }

      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, [textController]);

    ref.listen<SelectionState>(textSelectionProvider, (previous, next) {
      // Handle action selection
      if (next.selectedText != null && next.action != null) {
        _handleActionSelected(
          context,
          next.action!,
          next.customPrompt,
          next.selectedText,
        );

        // Clear state after handling
        Future.microtask(
          () => ref.read(textSelectionProvider.notifier).clearSelection(),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Text content area
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(36.w, 80.h, 50.w, 100.h),
                child: _TextContentArea(
                  controller: textController,
                  focusNode: focusNode,
                ),
              ),
            ),

            // Action button - appears when text is selected
            if (isTextSelected.value)
              Positioned(
                right: 0,
                top: 368
                    .h, // Position from Figma: 412px from top minus status bar
                child: TextActionButton(
                  onTap: () {
                    // Update selected text in state
                    ref
                        .read(textSelectionProvider.notifier)
                        .updateSelection(
                          selectedText: textController.text
                              .substring(
                                textController.selection.start,
                                textController.selection.end,
                              )
                              .trim(),
                        );

                    // Show bottom sheet for action selection
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => WritingAssistantBottomSheet(),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleActionSelected(
    BuildContext context,
    TextAction action,
    String? customPrompt,
    String? selectedText,
  ) {
    final message = customPrompt != null
        ? 'Prompt: "$customPrompt"'
        : '${action.label} Clicked';

    CustomToast.show(context, message: message);
  }
}

/// Text content area with selection highlighting styled like the Figma design.
class _TextContentArea extends StatelessWidget {
  const _TextContentArea({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLines: null,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 22 / 16,
        letterSpacing: 0.08,
        color: AppColors.textPrimary,
      ),
      cursorColor: AppColors.primary,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      // Custom selection highlight color to match Figma
      selectionHeightStyle: BoxHeightStyle.max,
      selectionWidthStyle: BoxWidthStyle.max,
    );
  }
}
