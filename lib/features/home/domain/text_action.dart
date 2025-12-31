/// Enum representing the available text actions in the writing assistant
enum TextAction {
  improveWriting('Improve Writing'),
  plagiarismCheck('Plagiarism Check'),
  regenerate('Regenerate'),
  addSummary('Add a summary'),
  customPrompt('Custom Prompt');

  const TextAction(this.label);

  /// The display label for the action
  final String label;
}
