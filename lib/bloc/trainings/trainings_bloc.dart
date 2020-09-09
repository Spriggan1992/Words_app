import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/models/fuiltersEnums.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/collections_repository.dart';
import 'package:words_app/repositories/words_repository.dart';

part 'trainings_event.dart';
part 'trainings_state.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  TrainingsBloc({this.wordsRepository, this.collectionsRepository})
      : super(TrainingsLoading());
  final WordsRepository wordsRepository;
  final CollectionsRepository collectionsRepository;
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
    if (event is TrainingsSelectCollections) {
      yield* _mapTrainingsSelectCollectionsToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    try {
      final updatedWords = event.words;
      final List<Collection> updatedListCollection =
          await collectionsRepository.fetchAndSetCollection();
      final List<bool> selectedList =
          List.generate(updatedListCollection.length, (index) => false);
      yield TrainingsSuccess(
        words: updatedWords,
        difficulty: 3,
        filteredListWords: updatedWords,
        filterGames: FilterGames.bricks,
        listCollection: updatedListCollection,
      );
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
          filteredListWords: updatedFilteredList,
          filterGames: updatedGames,
          words: updatedWords);
    } catch (_) {
      TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsSelectCollectionsToState(
      TrainingsSelectCollections event) async* {
    final List<Collection> updateList =
        List.from((state as TrainingsSuccess).listCollection);
    final List<Collection> updatedFilteredCollection =
        event.collection.map((collection) => collection).toList();
    print(updatedFilteredCollection);
    yield TrainingsSuccess(
        listCollection: updateList,
        filteredListCollection: updatedFilteredCollection);
    // }
  }
}
