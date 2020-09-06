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
    if (event is TrainingsToggleFavoritesBtns) {
      yield* _mapTrainingsToggleFavoritesBtnsToState(event);
    }
    if (event is TrainingsGoToTraining) {
      yield* _mapTrainingsGoToTrainingToState();
    }
    if (event is TrainingsFavoritesFilter) {
      yield* _mapTrainingsFavoritesFilterToState(event);
    }
    if (event is TrainingsDifficultiesFilter) {
      yield* _mapTrainingsDifficultiesFilterToState(event);
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
          filterdList: updatedWords);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsToggleDifficultiesBtnsToState(
      TrainingsToggleFilters event) async* {
    final updatedDifficulties = event.difficulty;
    final updatedFavorites = event.favorites;
    final List<Word> updatedWords =
        List.from((state as TrainingsSuccess).words);
    yield TrainingsSuccess(
        difficulty: updatedDifficulties,
        filterFavorites: updatedFavorites,
        words: updatedWords);
  }

  Stream<TrainingsState> _mapTrainingsToggleFavoritesBtnsToState(
      TrainingsToggleFavoritesBtns event) async* {
    final updatedFavorites = event.favorites;

    yield TrainingsSuccess(filterFavorites: updatedFavorites);
  }

  Stream<TrainingsState> _mapTrainingsGoToTrainingToState() async* {
    final favoriteFiltered = (state as TrainingsSuccess).filterFavorites;
    final difficultyFiltered = (state as TrainingsSuccess).difficulty;
    final newWords = (state as TrainingsSuccess).words.toList();
    final updatedFavorites = (state as TrainingsSuccess)
        .words
        .where((word) => word.favorite == 1)
        .toList();

    // final updatedWords = newWords
    //     .where((word) => difficultyFiltered == 3
    //         ? word is Word
    //         : word.difficulty == difficultyFiltered)
    //     .toList();

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
      print(
          'from TrainingsBloc -> difficulty: ${updatedWords[i].difficulty} : index = $i');
    }

    yield TrainingsSuccess(
      words: newWords,
      filterdList: updatedWords,
    );
  }

  Stream<TrainingsState> _mapTrainingsDifficultiesFilterToState(
      TrainingsDifficultiesFilter event) async* {}

  Stream<TrainingsState> _mapTrainingsFavoritesFilterToState(
      TrainingsFavoritesFilter event) async* {}
}
//   Stream<TrainingsState> _mapTrainingsDifficultiesFilterToState(
//       TrainingsDifficultiesFilter event) async* {
//     final favoriteFiltered = (state as TrainingsSuccess).filterFavorites;
//     final difficultyFiltered = (state as TrainingsSuccess).difficulty;
//     final newWords = (state as TrainingsSuccess).words;
//     final updatedFavorites = (state as TrainingsSuccess)
//         .words
//         .where((word) => word.favorite == 1)
//         .toList();

//     // final updatedWords = newWords
//     //     .where((word) => difficultyFiltered == 3
//     //         ? word is Word
//     //         : word.difficulty == difficultyFiltered)
//     //     .toList();

//     final updatedWords = favoriteFiltered == FilterFavorites.all
//         ? newWords
//             .where((word) => difficultyFiltered == 3
//                 ? word is Word
//                 : word.difficulty == difficultyFiltered)
//             .toList()
//         : newWords
//             .where((word) => difficultyFiltered == 3
//                 ? word.favorite == 1
//                 : word.difficulty == difficultyFiltered)
//             .toList();

//     for (var i = 0; i < updatedWords.length; i++) {
//       print(
//           'from TrainingsBloc -> difficulty: ${updatedWords[i].difficulty} : index = $i');
//     }

//     yield TrainingsSuccess(
//         words: newWords,
//         filterdList: updatedWords,
//         difficulty: event.difficultyFilter,
//         filterFavorites: event.filterFavorites ?? FilterFavorites.all);
//   }

//   Stream<TrainingsState> _mapTrainingsFavoritesFilterToState(
//       TrainingsFavoritesFilter event) async* {
//     final List<Word> newWords = List.from((state as TrainingsSuccess).words);
//     final favoriteFiltered = (state as TrainingsSuccess).filterFavorites;
//     final difficultyFiltered = (state as TrainingsSuccess).difficulty;
//     final updatedFavorites = event.filterFavorites;
//     final updatedDifficulty = event.difficultyFilter;

//     if (difficultyFiltered == 3) {
//       final List<Word> updatedFavoritesList =
//           favoriteFiltered == FilterFavorites.all ? newWords : newWords
//             ..where((word) => word.favorite == 1);
//       yield TrainingsSuccess(
//         words: newWords,
//         filterdList: updatedFavoritesList,
//         filterFavorites: updatedFavorites,
//         difficulty: updatedDifficulty,
//       );
//     } else {
//       final List<Word> updatedFavoritesList =
//           favoriteFiltered == FilterFavorites.all ? newWords : newWords
//             ..where((word) => word.favorite == 1)
//             ..where((word) => word.difficulty == difficultyFiltered);

//       yield TrainingsSuccess(
//         words: newWords,
//         filterdList: updatedFavoritesList,
//         filterFavorites: updatedFavorites,
//         difficulty: updatedDifficulty,
//       );
//     }
//   }
// }
