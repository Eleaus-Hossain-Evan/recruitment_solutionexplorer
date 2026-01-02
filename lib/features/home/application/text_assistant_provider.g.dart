// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_assistant_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for managing text selection state

@ProviderFor(TextSelection)
final textSelectionProvider = TextSelectionProvider._();

/// Notifier for managing text selection state
final class TextSelectionProvider
    extends $NotifierProvider<TextSelection, SelectionState> {
  /// Notifier for managing text selection state
  TextSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'textSelectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$textSelectionHash();

  @$internal
  @override
  TextSelection create() => TextSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectionState>(value),
    );
  }
}

String _$textSelectionHash() => r'9344399885fc35b06766adcbe21047118b7bb989';

/// Notifier for managing text selection state

abstract class _$TextSelection extends $Notifier<SelectionState> {
  SelectionState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SelectionState, SelectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectionState, SelectionState>,
              SelectionState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
