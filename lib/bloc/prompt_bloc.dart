import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';



import 'package:flutter/material.dart';

import '../repositories/prompt_repository.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  final File file = File(
      r"C:\Users\DELL\OneDrive\Desktop\flutter\aa1\assets\images\file.png");

  PromptBloc() : super(PromptInitial()) {
    on<PromtInitialEvent>(promtInitialEvent);
    on<PromptEnteredEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());
    Uint8List? bytes = await PromtRepo.GenerateImage(event.prompt);
    if (bytes != null) {
      emit(PromptGeneratingImageSuccessState(bytes));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promtInitialEvent(
      PromtInitialEvent event, Emitter<PromptState> emit) async {
    Uint8List bytes = await file.readAsBytes();
    emit(
      PromptGeneratingImageSuccessState(bytes),
    );
  }
}
