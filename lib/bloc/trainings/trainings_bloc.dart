import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/collections/collections_repository.dart';
import 'package:words_app/repositories/words/words_repository.dart';

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
    if (event is TrainingsFiltered) {
      yield* _mapTrainingsFilteredToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    try {
      final updatedIsEmptyCardWord = false;
      final List<Word> updatedWords = List.from(event.words);
      final List<Collection> updatedCollections =
          await collectionsRepository.fetchAndSetCollection();
      final List<Collection> filteredCollections = updatedCollections
          .where((collection) => collection.id == event.collectionId)
          .toList();
      yield TrainingsSuccess(
        filteredCollections: filteredCollections,
        filteredWords: updatedWords,
        collections: updatedCollections,
        isEmptyCardWord: updatedIsEmptyCardWord,
      );
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsFilteredToState(
      TrainingsFiltered event) async* {
    try {
      final List<Collection> updatedFilteredCollections =
          List.from(event.selectedCollections);
      final List<Collection> updatedCollections =
          List.from((state as TrainingsSuccess).collections);

      // Extract Words from FuilteredCollections
      final List<Word> selectedFilteredList = [];
      for (var i = 0; i < event.selectedCollections.length; i++) {
        var fetchedCollections = await wordsRepository
            .fetchAndSetWords(event.selectedCollections[i].id);
        fetchedCollections.forEach((element) {
          selectedFilteredList.add(element);
        });
      }
      // Update Words by difficulties
      final List<Word> updatedFilteredList = [];
      bool updatedIsEmptyCardWord = false;
      for (var i = 0; i < event.selectedDifficulties.length; i++) {
        selectedFilteredList.forEach((word) {
          if (word.difficulty == event.selectedDifficulties[i]) {
            updatedFilteredList.add(word);
            if (word.targetLang == null || word.ownLang == null) {
              updatedIsEmptyCardWord = true;
              updatedFilteredList.remove(word);
            }
          }
          if (event.selectedDifficulties[i] == 3) {
            updatedFilteredList.add(word);
            if (word.targetLang == null ||
                word.ownLang == null && event.selectedDifficulties.isNotEmpty) {
              updatedIsEmptyCardWord = true;
              updatedFilteredList.remove(word);
            } else {
              updatedIsEmptyCardWord = false;
            }
          }
        });
      }
      updatedFilteredList..shuffle();
      yield TrainingsSuccess(
          filteredWords: updatedFilteredList,
          collections: updatedCollections,
          filteredCollections: updatedFilteredCollections,
          isEmptyCardWord: updatedIsEmptyCardWord);
    } catch (_) {
      TrainingsFailure();
    }
  }
}
