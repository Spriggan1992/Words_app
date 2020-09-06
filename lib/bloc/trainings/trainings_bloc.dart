import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/FuiltersEnums.dart';
import 'package:words_app/models/difficulty.dart';
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
    if (event is TrainingsToggleFilters) {
      yield* _mapTrainingsToggleDifficultiesBtnsToState(event);
    }

    if (event is TrainingsGoToTraining) {
      yield* _mapTrainingsGoToTrainingToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    try {
      final updatedWords = event.words;

      yield TrainingsSuccess(
          words: updatedWords,
          filterFavorites: FilterFavorites.all,
          difficulty: 3,
          filterdList: updatedWords,
          filterGames: FilterGames.bricks);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsToggleDifficultiesBtnsToState(
      TrainingsToggleFilters event) async* {
    final updatedDifficulties = event.difficulty;
    final updatedFavorites = event.favorites;
    final updatedGames = event.games;

    final List<Word> updatedWords =
        List.from((state as TrainingsSuccess).words);
    yield TrainingsSuccess(
        difficulty: updatedDifficulties,
        filterFavorites: updatedFavorites,
        filterGames: updatedGames,
        words: updatedWords);
  }

  Stream<TrainingsState> _mapTrainingsGoToTrainingToState(
      TrainingsGoToTraining event) async* {
    final favoriteFiltered = (state as TrainingsSuccess).filterFavorites;
    final difficultyFiltered = (state as TrainingsSuccess).difficulty;
    final newWords = (state as TrainingsSuccess).words.toList();
    final updatedFavorites = (state as TrainingsSuccess)
        .words
        .where((word) => word.favorite == 1)
        .toList();

    final updatedWords = favoriteFiltered == FilterFavorites.all
        ? newWords
            .where((word) => difficultyFiltered == 3
                ? word is Word
                : word.difficulty == difficultyFiltered)
            .toList()
        : updatedFavorites
            .where((word) => difficultyFiltered == 3
                ? word.favorite == 1
                : word.difficulty == difficultyFiltered)
            .toList();

    for (var i = 0; i < updatedWords.length; i++) {
      // print(updatedWords);
      // print(
      //     'from TrainingsBloc -> difficulty: ${updatedWords[i].difficulty} : index = $i');
    }

    yield TrainingsSuccess(
        words: newWords,
        filterdList: updatedWords,
        filterFavorites: event.favorites,
        difficulty: event.difficulty,
        filterGames: event.games);
  }
}
