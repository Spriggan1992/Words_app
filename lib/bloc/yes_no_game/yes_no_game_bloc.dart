import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/models.dart';

import '../blocs.dart';

part 'yes_no_game_event.dart';
part 'yes_no_game_state.dart';

class YesNoGameBloc extends Bloc<YesNoGameEvent, YesNoGameState> {
  final TrainingManagerBloc trainingManagerBloc;
  YesNoGameBloc({this.trainingManagerBloc}) : super(YesNoGameLoading());

  @override
  Stream<YesNoGameState> mapEventToState(
    YesNoGameEvent event,
  ) async* {
    if (event is YesNoGameLoaded) {
      yield* _mapYesNoGameLoadedToState();
    }
    if (event is YesNoGameAnswerCorrect) {
      yield* _mapYesNoGameAnswerCorrectToState();
    }
    if (event is YesNoGameAnswerWrong) {
      yield* _mapYesNoGameAnswerWrongToState();
    }
    if (event is YesNoGameDeleteWords) {
      yield* _mapYesNoGameDeleteWordsToState(event);
    }
  }

  Stream<YesNoGameState> _mapYesNoGameLoadedToState() async* {
    try {
      final trainigManagerBlocData = trainingManagerBloc.state.filteredWords;

      final List<Word> updatedTargetLang = trainigManagerBlocData;
      final List<Word> updatedOwnLang = trainigManagerBlocData;
      yield YesNoGameSuccess(
          targetLang: updatedTargetLang,
          ownLang: updatedOwnLang,
          correct: 0,
          wrong: 0);
    } catch (_) {
      yield YesNoGameFailure();
    }
  }

  Stream<YesNoGameState> _mapYesNoGameAnswerCorrectToState() async* {
    try {
      final data = (state as YesNoGameSuccess);
      yield YesNoGameSuccess(
          targetLang: data.targetLang,
          ownLang: data.ownLang,
          correct: data.correct + 1,
          wrong: data.wrong);
    } catch (_) {
      yield YesNoGameFailure();
    }
  }

  Stream<YesNoGameState> _mapYesNoGameAnswerWrongToState() async* {
    try {
      final data = (state as YesNoGameSuccess);
      yield YesNoGameSuccess(
          targetLang: data.targetLang,
          ownLang: data.ownLang,
          correct: data.correct,
          wrong: data.wrong + 1);
    } catch (_) {
      yield YesNoGameFailure();
    }
  }

  Stream<YesNoGameState> _mapYesNoGameDeleteWordsToState(
      YesNoGameDeleteWords event) async* {
    try {
      final data = (state as YesNoGameSuccess);
      final List<Word> updatedTargetLang =
          data.targetLang.where((word) => word.id != event.word.id).toList();
      final List<Word> updatedOwnLang = [...data.ownLang]..removeLast();
      yield YesNoGameSuccess(
          targetLang: updatedTargetLang,
          ownLang: updatedOwnLang,
          correct: data.correct,
          wrong: data.wrong);
    } catch (_) {
      yield YesNoGameFailure();
    }
  }
}
