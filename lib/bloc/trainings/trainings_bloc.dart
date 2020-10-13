import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/screens/training_manager_screen/helper.dart';

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
    if (event is TrainingsUpdatedSelectedGames) {
      yield* _mapTrainingsUpdatedSelectedGamesToState(event);
    }
    if (event is TrainingsAddRemoveCollectionFilter) {
      yield* _mapTrainingsAddRemoveCollectionFilterToState(event);
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
          filteredCollections: filteredCollections ?? [],
          filteredWords: updatedWords ?? [],
          collections: updatedCollections ?? [],
          isEmptyCardWord: updatedIsEmptyCardWord,
          selectedGames: FilterGames.bricks);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsFilteredToState(
      TrainingsFiltered event) async* {
    try {
      final List<Collection> updatedFilteredCollections =
          event.selectedCollections;
      final List<Collection> updatedCollections =
          List.from((state as TrainingsSuccess).collections);
      final updatedSelectedGames = (state as TrainingsSuccess).selectedGames;

      // Extract Words from FuilteredCollections
      final List<Word> selectedFilteredList = [];
      for (var i = 0; i < event.selectedCollections.length; i++) {
        List<Word> fetchedCollections = await wordsRepository.fetchAndSetWords(
            collectionId: event.selectedCollections[i].id);
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
            if (word.targetLang == null ||
                word.ownLang == null ||
                word.targetLang == '' ||
                word.ownLang == '') {
              updatedIsEmptyCardWord = true;
              updatedFilteredList.remove(word);
            }
          }
          if (event.selectedDifficulties[i] == 3) {
            updatedFilteredList.add(word);
            if (word.targetLang == null ||
                word.ownLang == null ||
                word.targetLang == '' ||
                word.ownLang == '' && event.selectedDifficulties.isNotEmpty) {
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
          isEmptyCardWord: updatedIsEmptyCardWord,
          selectedGames: updatedSelectedGames);
    } catch (_) {
      TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsUpdatedSelectedGamesToState(
      TrainingsUpdatedSelectedGames event) async* {
    try {
      final data = (state as TrainingsSuccess);
      yield TrainingsSuccess(
          collections: data.collections,
          filteredCollections: data.filteredCollections,
          filteredWords: data.filteredWords,
          isEmptyCardWord: data.isEmptyCardWord,
          selectedGames: event.selectedGames);
    } catch (_) {
      TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsAddRemoveCollectionFilterToState(
      TrainingsAddRemoveCollectionFilter event) async* {
    try {
      final updatedFilteredList =
          (state as TrainingsSuccess).filteredCollections;
      final data = (state as TrainingsSuccess);

      if (event.isCollection == true) {
        updatedFilteredList.add(event.collection);
      }
      if (event.isCollection == false) {
        updatedFilteredList.remove(event.collection);
      }
      yield TrainingsSuccess(
          collections: data.collections,
          filteredCollections: updatedFilteredList,
          filteredWords: data.filteredWords,
          isEmptyCardWord: data.isEmptyCardWord,
          selectedGames: data.selectedGames);
    } catch (_) {
      TrainingsFailure();
    }
  }
}
