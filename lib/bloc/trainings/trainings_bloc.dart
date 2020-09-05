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
          filterdList: []);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsDifficultiesFilterToState(
      TrainingsDifficultiesFilter event) async* {
    final filterFavorites = (state as TrainingsSuccess).filterFavorites;
    final updatedDifficulties = event.difficultyFilter;
    final difficultyFilter = (state as TrainingsSuccess).difficulty;

    if (filterFavorites == FilterFavorites.all) {
      final List<Word> newWords = List.from((state as TrainingsSuccess).words);

      final List<Word> updatedFilteredList = List.from(
          (state as TrainingsSuccess).words.where((word) =>
              difficultyFilter == 3
                  ? newWords != null
                  : word.difficulty == difficultyFilter));
      yield TrainingsSuccess(
        words: newWords,
        filterdList: updatedFilteredList,
        difficulty: updatedDifficulties,
      );
      for (var i = 0; i < updatedFilteredList.length; i++) {
        print('diff = ${updatedFilteredList[i].difficulty}; index = $i');
      }
    }
    if (filterFavorites == FilterFavorites.favorites) {
      final List<Word> newWords = List.from((state as TrainingsSuccess).words);

      final List<Word> updatedFilteredListByFavorites = List.from(
          (state as TrainingsSuccess)
              .words
              .where((word) => word.favorite == 1));

      final List<Word> updatedFilteredListByDifficulty = List.from(
          (updatedFilteredListByFavorites)
            ..where((word) => difficultyFilter == 3
                ? word.favorite == 1
                : word.difficulty == difficultyFilter));
      // print(updatedFilteredListByDifficulty);
      for (var i = 0; i < updatedFilteredListByFavorites.length; i++) {
        // print(
        // 'diff = ${updatedFilteredListByFavorites[i].difficulty}; index = $i');
        // print(
        // 'FAVORITES = ${updatedFilteredListByFavorites[i].favorite}; index = $i');
      }

      // print('updatedFilterFavorites: $updatedFilteredList');
      // print('from trainingsBloc $updatedFilteredList');
      // print(
      // 'updatedFilteredListByFavorites : ${updatedFilteredListByFavorites.length}');
      yield TrainingsSuccess(
          words: newWords,
          filterdList: updatedFilteredListByDifficulty,
          difficulty: updatedDifficulties,
          filterFavorites: event.filterFavorites);
    }
  }

  Stream<TrainingsState> _mapTrainingsFavoritesFilterToState(
      TrainingsFavoritesFilter event) async* {
    final newWords = (state as TrainingsSuccess).words;
    final difficultyFilter = (state as TrainingsSuccess).difficulty;
    final favoriteFilter = (state as TrainingsSuccess).filterFavorites;
    if (difficultyFilter == 0) {
      final List<Word> updatedFavoritesList =
          favoriteFilter == FilterFavorites.all
              ? (state as TrainingsSuccess)
                  .words
                  .where((word) => word.difficulty == 0)
                  .toList()
              : (state as TrainingsSuccess)
                  .words
                  .where((word) => word.favorite == 1)
                  .toList()
                  .where((word) => word.difficulty == 0)
                  .toList();
      yield TrainingsSuccess(
          words: newWords,
          filterdList: updatedFavoritesList,
          filterFavorites: event.filterFavorites,
          difficulty: event.difficultyFilter);
    }
    if (difficultyFilter == 1) {
      final List<Word> updatedFavoritesList =
          favoriteFilter == FilterFavorites.all
              ? (state as TrainingsSuccess)
                  .words
                  .where((word) => word.difficulty == 1)
                  .toList()
              : (state as TrainingsSuccess)
                  .words
                  .where((word) => word.favorite == 1)
                  .toList()
                  .where((word) => word.difficulty == 1)
                  .toList();
      yield TrainingsSuccess(
          words: newWords,
          filterdList: updatedFavoritesList,
          filterFavorites: event.filterFavorites,
          difficulty: event.difficultyFilter);
    }
    if (difficultyFilter == 2) {
      final List<Word> updatedFavoritesList =
          favoriteFilter == FilterFavorites.all
              ? (state as TrainingsSuccess)
                  .words
                  .where((word) => word.difficulty == 2)
                  .toList()
              : (state as TrainingsSuccess)
                  .words
                  .where((word) => word.favorite == 1)
                  .toList()
                  .where((word) => word.difficulty == 2)
                  .toList();
      yield TrainingsSuccess(
          words: newWords,
          filterdList: updatedFavoritesList,
          filterFavorites: event.filterFavorites,
          difficulty: event.difficultyFilter);
    }
    if (difficultyFilter == 3) {
      final List<Word> updatedFavoritesList =
          favoriteFilter == FilterFavorites.all
              ? (state as TrainingsSuccess).words.toList()
              : (state as TrainingsSuccess)
                  .words
                  .where((word) => word.favorite == 1)
                  .toList();
      yield TrainingsSuccess(
          words: newWords,
          filterdList: updatedFavoritesList,
          filterFavorites: event.filterFavorites,
          difficulty: event.difficultyFilter);
    }

    // final List<Word> newWords = List.from((state as TrainingsSuccess).words);

    // final List<Word> updatedFavoritesList =
    //     event.filterFavorites == FilterFavorites.all ? newWords : newWords
    //       ..where((word) => word.favorite == 1);

    // yield TrainingsSuccess(
    //   words: newWords,
    //   filterdList: updatedFavoritesList,
    //   filterFavorites: event.filterFavorites,
    //   difficulty: event.difficultyFilter,
    // );
  }
}
