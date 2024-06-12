part of 'prompt_bloc.dart';

@immutable
sealed class PromptEvent {}

class PromtInitialEvent extends PromptEvent {}

class PromptEnteredEvent extends PromptEvent {
  final String prompt;

  PromptEnteredEvent({required this.prompt});
}
