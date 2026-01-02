import 'dart:ui' show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../application/text_assistant_provider.dart' hide TextSelection;
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
                padding: EdgeInsets.fromLTRB(36.w, 48.h, 50.w, 48.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WikipediA',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: AppColors.textPrimary,
                        fontFamily: GoogleFonts.lustria().fontFamily,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    12.verticalSpace,
                    _TextContentArea(),
                  ],
                ),
              ),
            ),

            // Action button - appears when text is selected
            Positioned(
              right: 0,
              top:
                  368.h, // Position from Figma: 412px from top minus status bar
              child: TextActionButton(
                onTap: () async {
                  // Show bottom sheet for action selection
                  final result = await showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.white,
                    isScrollControlled: true,
                    showDragHandle: true,
                    enableDrag: true,
                    builder: (context) => WritingAssistantBottomSheet(),
                  );

                  print('Bottom sheet result: $result');
                  if (result != null && result is (TextAction, String?)) {
                    final (action, customPrompt) = result;
                    ref
                        .read(textSelectionProvider.notifier)
                        .updateSelection(
                          action: action,
                          customPrompt: customPrompt,
                        );
                  }
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
class _TextContentArea extends HookConsumerWidget {
  const _TextContentArea();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: _defaultTextContent);
    final focusNode = useFocusNode();

    void focusNodeListener() {
      if (!focusNode.hasFocus) {
        // Clear selection when focus is lost
        // ref.read(textSelectionProvider.notifier)
        //   ..hideButton()
        //   ..clearSelection();
        // textController.selection = TextSelection.collapsed(offset: -1);
      }
    }

    // Listen to selection changes
    useEffect(() {
      void listener() {
        final selection = textController.selection;
        final hasSelection = !selection.isCollapsed;

        // Update provider to control button visibility
        if (hasSelection) {
          // Update selected text in state
          ref
              .read(textSelectionProvider.notifier)
              .updateSelection(
                selectedText: textController.text
                    .substring(selection.start, selection.end)
                    .trim(),
              );
          ref.read(textSelectionProvider.notifier).showButton();
        } else {
          ref.read(textSelectionProvider.notifier)
            ..clearSelection()
            ..hideButton();
        }
      }

      textController.addListener(listener);
      focusNode.addListener(focusNodeListener);
      return () {
        textController.removeListener(listener);
        focusNode.removeListener(focusNodeListener);
      };
    }, [textController]);

    return TextField(
      controller: textController,
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
      contextMenuBuilder: (context, editableTextState) => SizedBox.shrink(),
    );
  }
}
