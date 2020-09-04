import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/FuiltersEnums.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/training_manager_screen/components/favorites_btns.dart';

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
      yield TrainingsSuccess(words: updatedWords);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsDifficultiesFilterToState(
      TrainingsDifficultiesFilter event) async* {
    final filterFavorites = (state as TrainingsSuccess).filterFavorites;
    if (filterFavorites == FilterFavorites.all) {
      final List<Word> newWords = List.from((state as TrainingsSuccess).words);

      final List<Word> updatedFilteredList = List.from(
          (state as TrainingsSuccess)
              .words
              .where((word) => word.difficulty == event.difficultyFilter));
      yield TrainingsSuccess(
        words: newWords,
        filterdList: updatedFilteredList,
      );
      for (var i = 0; i < updatedFilteredList.length; i++) {
        print('diff = ${updatedFilteredList[i].difficulty}; index = $i');
      }
    }
    if (filterFavorites == FilterFavorites.favorites) {
      // print('difficulties from bloc${event.difficultyFilter}');

      final List<Word> newWords = List.from((state as TrainingsSuccess).words);

      final List<Word> updatedFilteredListByFavorites = List.from(
          (state as TrainingsSuccess)
              .words
              .where((word) => word.favorite == 1));

      final List<Word> updatedFilteredListByDifficulty =
          List.from((updatedFilteredListByFavorites));
      updatedFilteredListByDifficulty
        ..where((word) => word.difficulty == event.difficultyFilter);
      for (var i = 0; i < updatedFilteredListByFavorites.length; i++) {
        print(
            'diff = ${updatedFilteredListByFavorites[i].difficulty}; index = $i');
      }

      // print('updatedFilterFavorites: $updatedFilteredList');
      // print('from trainingsBloc $updatedFilteredList');
      yield TrainingsSuccess(
        words: newWords,
        filterdList: updatedFilteredListByDifficulty,
      );
    }
  }

  Stream<TrainingsState> _mapTrainingsFavoritesFilterToState(
      TrainingsFavoritesFilter event) async* {
    final List<Word> newWords = List.from((state as TrainingsSuccess).words);

    if (event.filterFavorites == FilterFavorites.all) {
      yield TrainingsSuccess(
          words: newWords,
          filterdList: newWords,
          filterFavorites: FilterFavorites.all);
    }
    if (event.filterFavorites == FilterFavorites.favorites) {
      final List<Word> updatedFavoritesList = List.from(
          (state as TrainingsSuccess).words
            ..where((word) => word.favorite == 1));
      yield TrainingsSuccess(
          words: newWords,
          filterdList: updatedFavoritesList,
          filterFavorites: FilterFavorites.favorites);
    }
  }

  // Stream<TrainingsState> _mapTrainingsDifficultiesFilterToState(
  //     TrainingsDifficultiesFilter event) async* {
  //   final List<Word> newWords = List.from((state as TrainingsSuccess).words);

  //   final List<Word> updatedFilterFavorites =
  //       event.selectedFavorites == FilterFavorites.all
  //           ? List.from((state as TrainingsSuccess).words)
  //           : List.from((state as TrainingsSuccess)
  //               .words
  //               .where((word) => word.favorite == 1));

  //   final List<Word> updatedFilteredList = List.from(updatedFilterFavorites)
  //     ..where((word) => word.difficulty == event.difficultyFilter);

  //   print('updatedFilterFavorites: $updatedFilterFavorites');
  //   print('from trainingsBloc $updatedFilteredList');
  //   yield TrainingsSuccess(
  //     words: newWords,
  //     filterdList: updatedFilteredList,
  //   );
  // }

}
