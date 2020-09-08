import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/fuiltersEnums.dart';
import 'package:words_app/models/word.dart';

part 'trainings_event.dart';
part 'trainings_state.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  TrainingsBloc() : super(TrainingsLoading());

  @override
  Stream<TrainingsState> mapEventToState(
    TrainingsEvent event,
  ) async* {
    if (event is TrainingsLoaded) {
      yield* _mapTrainingsLoadedToState(event);
    }
    if (event is TrainingsFilteredDifficulties) {
      yield* _mapTrainingsFilteredDifficultiesToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    try {
      final updatedWords = event.words;

      yield TrainingsSuccess(
          words: updatedWords,
          difficulty: 3,
          filterdList: updatedWords,
          filterGames: FilterGames.bricks);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsFilteredDifficultiesToState(
      TrainingsFilteredDifficulties event) async* {
    try {
      final List<Word> updatedWords =
          List.from((state as TrainingsSuccess).words);
      final updatedDifficulties = event.difficulty;
      final updatedGames = event.games ?? FilterGames.bricks;

      final List<Word> updatedFilteredList = (state as TrainingsSuccess)
          .words
          .toList()
          .where((word) => event.difficulty == 3
              ? word is Word
              : word.difficulty == event.difficulty)
          .toList();

      yield TrainingsSuccess(
          difficulty: updatedDifficulties,
          filterdList: updatedFilteredList,
          filterGames: updatedGames,
          words: updatedWords);
    } catch (_) {
      TrainingsFailure();
    }
  }
}
