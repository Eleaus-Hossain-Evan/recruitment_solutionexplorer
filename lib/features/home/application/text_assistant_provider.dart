import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/text_action.dart';

part 'text_assistant_provider.g.dart';

/// State class for tracking text selection
@immutable
class SelectionState extends Equatable {
  final String? selectedText;
  // enum
  final TextAction? action;
  final String? customPrompt;
  final bool isVisible;
  const SelectionState({
    this.selectedText,
    this.action,
    this.customPrompt,
    this.isVisible = false,
  });

  SelectionState copyWith({
    ValueGetter<String?>? selectedText,
    ValueGetter<TextAction?>? action,
    ValueGetter<String?>? customPrompt,
    bool? isVisible,
  }) {
    return SelectionState(
      selectedText: selectedText != null ? selectedText() : this.selectedText,
      action: action != null ? action() : this.action,
      customPrompt: customPrompt != null ? customPrompt() : this.customPrompt,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  String toString() =>
      'SelectionState(selectedText: $selectedText, action: $action, customPrompt: $customPrompt, isVisible: $isVisible)';

  @override
  List<Object?> get props => [selectedText, action, customPrompt, isVisible];
}

/// Notifier for managing text selection state
@Riverpod(keepAlive: true)
class TextSelection extends _$TextSelection {
  @override
  SelectionState build() => const SelectionState();

  void updateSelection({
    String? selectedText,
    TextAction? action,
    String? customPrompt,
  }) {
    state = state.copyWith(
      // Only update if a new value is explicitly provided
      selectedText: selectedText != null ? () => selectedText : null,
      action: action != null ? () => action : null,
      customPrompt: customPrompt != null ? () => customPrompt : null,
    );
  }

  void clearSelection() {
    state = const SelectionState();
  }

  /// Show the text action button
  void showButton() {
    state = state.copyWith(isVisible: true);
  }

  /// Hide the text action button
  void hideButton() {
    state = state.copyWith(isVisible: false);
  }
}
