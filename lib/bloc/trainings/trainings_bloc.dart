import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/screens/training_manager_screen/helper.dart';

part 'trainings_event.dart';
part 'trainings_state.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  final WordsRepository wordsRepository;
  final CollectionsRepository collectionsRepository;

  TrainingsBloc({this.wordsRepository, this.collectionsRepository})
      : super(TrainingsState());

  @override
  Stream<TrainingsState> mapEventToState(
    TrainingsEvent event,
  ) async* {
    if (event is TrainingsLoaded) {
      yield* _mapTrainingsLoadedToState(event);
    }
    // if (event is TrainingsFiltered) {
    //   yield* _mapTrainingsFilteredToState(event);
    // }
    // if (event is TrainingsUpdatedSelectedGames) {
    //   yield* _mapTrainingsUpdatedSelectedGamesToState(event);
    // }
    // if (event is TrainingsAddRemoveCollectionFilter) {
    //   yield* _mapTrainingsAddRemoveCollectionFilterToState(event);
    // }
    if (event is TrainingsSelectedCollections) {
      yield* _mapTrainingsSelectedCollectionsToState(event);
    }
    if (event is TrainingsSelectedDifficulties) {
      yield* _mapTrainingsSelectedDifficultiesToState(event);
    }
    if (event is TrainingsSelectedDifficulties) {
      yield* _mapTrainingsSelectedDifficultiesToState(event);
    }
    if (event is TrainingsSelectedGames) {
      yield* _mapTrainingsSelectedGamesToState(event);
    }
    if (event is TrainingsSubmitted) {
      yield* _mapTrainingsSubmittedToState();
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    final List<Collection> updatedCollections =
        await collectionsRepository.fetchAndSetCollection();
    final List<Collection> selectedCollections = updatedCollections
        .where((collection) => collection.id == event.collectionId)
        .toList();
    yield state.update(
      selectedDifficulties: [],
      isEmptyCardWord: false,
      filteredWords: event.words,
      selectedCollections: selectedCollections,
      selectedGames: FilterGames.bricks,
      collections: updatedCollections ?? [],
    );
    // yield TrainingsSuccess(
    //     filteredCollections: filteredCollections ?? [],
    //     filteredWords: updatedWords ?? [],
    //     collections: updatedCollections ?? [],
    //     isEmptyCardWord: updatedIsEmptyCardWord,
    //     selectedGames: FilterGames.bricks);
  }

  // Stream<TrainingsState> _mapTrainingsFilteredToState(
  //     TrainingsFiltered event) async* {
  //   final List<Word> selectedFilteredList = [];
  //   for (var i = 0; i < event.selectedCollections.length; i++) {
  //     List<Word> fetchedCollections = await wordsRepository.fetchAndSetWords(
  //         collectionId: event.selectedCollections[i].id);
  //     fetchedCollections.forEach((element) {
  //       selectedFilteredList.add(element);
  //     });
  //   }
  //   // Update Words by difficulties
  //   final List<Word> updatedFilteredList = [];
  //   bool updatedIsEmptyCardWord = false;
  //   for (var i = 0; i < event.selectedDifficulties.length; i++) {
  //     selectedFilteredList.forEach((word) {
  //       if (word.difficulty == event.selectedDifficulties[i]) {
  //         updatedFilteredList.add(word);
  //         if (word.targetLang == null ||
  //             word.ownLang == null ||
  //             word.targetLang == '' ||
  //             word.ownLang == '') {
  //           updatedIsEmptyCardWord = true;
  //           updatedFilteredList.remove(word);
  //         }
  //       }
  //       if (event.selectedDifficulties[i] == 3) {
  //         updatedFilteredList.add(word);
  //         if (word.targetLang == null ||
  //             word.ownLang == null ||
  //             word.targetLang == '' ||
  //             word.ownLang == '' && event.selectedDifficulties.isNotEmpty) {
  //           updatedIsEmptyCardWord = true;
  //           updatedFilteredList.remove(word);
  //         } else {
  //           updatedIsEmptyCardWord = false;
  //         }
  //       }
  //     });
  //   }
  //   updatedFilteredList..shuffle();
  //   yield state.update(
  //     filteredWords: updatedFilteredList,
  //     selectedCollections: event.selectedCollections,
  //     isEmptyCardWord: updatedIsEmptyCardWord,
  //   );
  // }

  // Stream<TrainingsState> _mapTrainingsUpdatedSelectedGamesToState(
  //     TrainingsUpdatedSelectedGames event) async* {
  //   try {
  //     final data = (state as TrainingsSuccess);
  //     yield TrainingsSuccess(
  //         collections: data.collections,
  //         selectedCollections: data.selectedCollections,
  //         filteredWords: data.filteredWords,
  //         isEmptyCardWord: data.isEmptyCardWord,
  //         selectedGames: event.selectedGames);
  //   } catch (_) {
  //     TrainingsFailure();
  //   }
  // }

  // Stream<TrainingsState> _mapTrainingsAddRemoveCollectionFilterToState(
  //     TrainingsAddRemoveCollectionFilter event) async* {
  //   try {
  //     final updatedFilteredList =
  //         (state as TrainingsSuccess).selectedCollections;
  //     final data = (state as TrainingsSuccess);

  //     if (event.isCollection == true) {
  //       updatedFilteredList.add(event.collection);
  //     }
  //     if (event.isCollection == false) {
  //       updatedFilteredList.remove(event.collection);
  //     }
  //     yield TrainingsSuccess(
  //         collections: data.collections,
  //         selectedCollections: updatedFilteredList,
  //         filteredWords: data.filteredWords,
  //         isEmptyCardWord: data.isEmptyCardWord,
  //         selectedGames: data.selectedGames);
  //   } catch (_) {
  //     TrainingsFailure();
  //   }
  // }

  Stream<TrainingsState> _mapTrainingsSelectedCollectionsToState(
      TrainingsSelectedCollections event) async* {
    List<Collection> updatedSelectedCollections = [];
    event.isCollection
        ? updatedSelectedCollections.add(event.collection)
        : updatedSelectedCollections.remove(event.collection);

    yield TrainingsState.success(
      collections: state.collections,
      filteredWords: state.filteredWords,
      isEmptyCardWord: state.isEmptyCardWord,
      selectedCollections: updatedSelectedCollections,
      selectedDifficulties: state.selectedDifficulties,
      selectedGames: state.selectedGames,
    );
  }

  Stream<TrainingsState> _mapTrainingsSelectedDifficultiesToState(
      TrainingsSelectedDifficulties event) async* {
    // final List<int> difficulties =
    //     await addAndRemoveDifficulty(event.difficulty);

    yield state.update(selectedDifficulties: event.difficulties);
    final Map<String, dynamic> data = await _mapWordsToSelectedFilteredList();
    final List<Word> updatedFilteredWordsList =
        data['updatedFilteredWordsList'];
    final bool updatedIsEmptyCardWord = data['updatedIsEmptyCardWord'];
    yield state.update(
        filteredWords: updatedFilteredWordsList,
        isEmptyCardWord: updatedIsEmptyCardWord);
  }

  Future<List<int>> addAndRemoveDifficulty(int difficulty) async {
    final List<int> difficulties = [];
    if (difficulties.contains(difficulty)) {
      difficulties.remove(difficulty);
    } else {
      difficulties.add(difficulty);
    }
    print('addAndRemoveDifficulty: $difficulties');
    // if (state.selectedDifficulties.contains(3)) {
    //   difficulties.remove(3);
    // } else {
    //   difficulties.clear();
    //   difficulties.add(3);
    // }
    // if (state.selectedDifficulties.contains(difficulty)) {
    //   difficulties.remove(difficulty);
    // } else {
    //   difficulties.add(difficulty);
    // }
    return difficulties;
  }

  Future<List<Word>> _mapWordsList() async {
    List<Word> selectedFilteredList = [];
    for (var i = 0; i < state.selectedCollections.length; i++) {
      List<Word> fetchedCollections = await wordsRepository.fetchAndSetWords(
          collectionId: state.selectedCollections[i].id);
      fetchedCollections.forEach((element) {
        selectedFilteredList.add(element);
      });
    }
    return selectedFilteredList;
  }

  Stream<TrainingsState> _mapTrainingsSelectedGamesToState(
      TrainingsSelectedGames event) async* {
    yield state.update(selectedGames: event.selectedGame);
  }

  Future<Map<String, dynamic>> _mapWordsToSelectedFilteredList() async {
    final List<Word> filteredList = await _mapWordsList();
    final List<Word> updatedFilteredWordsList = [];
    bool updatedIsEmptyCardWord = false;
    for (var i = 0; i < state.selectedDifficulties.length; i++) {
      filteredList.forEach((word) {
        if (word.difficulty == state.selectedDifficulties[i]) {
          updatedFilteredWordsList.add(word);
          if (word.targetLang == null ||
              word.ownLang == null ||
              word.targetLang == '' ||
              word.ownLang == '') {
            updatedIsEmptyCardWord = true;
            updatedFilteredWordsList.remove(word);
          }
        }
        if (state.selectedDifficulties[i] == 3) {
          updatedFilteredWordsList.add(word);
          if (word.targetLang == null ||
              word.ownLang == null ||
              word.targetLang == '' ||
              word.ownLang == '' && state.selectedDifficulties.isNotEmpty) {
            updatedIsEmptyCardWord = true;
            updatedFilteredWordsList.remove(word);
          } else {
            updatedIsEmptyCardWord = false;
          }
        }
      });
    }
    updatedFilteredWordsList..shuffle();
    return {
      'updatedFilteredWordsList': updatedFilteredWordsList,
      'updatedIsEmptyCardWord': updatedIsEmptyCardWord
    };
  }

  Stream<TrainingsState> _mapTrainingsSubmittedToState() async* {
    try {
      if (state.selectedDifficulties.isNotEmpty &&
          state.selectedCollections.isNotEmpty) {
        yield TrainingsState.success();
      }
    } catch (_) {
      String error = await returnErrorMessage();
      yield TrainingsState.failure(
        collections: state.collections,
        filteredWords: state.filteredWords,
        isEmptyCardWord: state.isEmptyCardWord,
        selectedCollections: state.selectedCollections,
        selectedDifficulties: state.selectedDifficulties,
        selectedGames: state.selectedGames,
        errorMessage: error,
      );
    }
  }

  Future<String> returnErrorMessage() async {
    String error;
    if (state.selectedCollections.isEmpty) {
      error = 'You have to choose which collection';
    } else if (state.selectedDifficulties.isEmpty) {
      error = 'You have to choose which words you want to learn';
    } else if (state.filteredWords.isEmpty) {
      error = 'There are no words in your collections';
    }
    return error;
  }
}
