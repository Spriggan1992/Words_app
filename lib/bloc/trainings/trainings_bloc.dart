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
      : super(TrainingsLoading());

  @override
  Stream<TrainingsState> mapEventToState(
    TrainingsEvent event,
  ) async* {
    if (event is TrainingsLoaded) {
      yield* _mapTrainingsLoadedToState(event);
    }
    if (event is TrainingsSelectedCollections) {
      yield* _mapTrainingsSelectedCollectionsToState(event);
    }
    if (event is TrainingsFiltered) {
      yield* _mapTrainingsFilteredToState();
    }
    if (event is TrainingsSelectedGames) {
      yield* _mapTrainingsSelectedGamesToState(event);
    }
    if (event is TrainingsSubmitted) {
      yield* _mapTrainingsSubmittedToState();
    }
    if (event is TrainingsUpdatedDifficulties) {
      yield* _mapTrainingsUpdatedDifficultiesToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    final trainigState = (state as TrainingsSuccess);
    final List<Collection> updatedCollections =
        await collectionsRepository.fetchAndSetCollection();
    final List<Collection> selectedCollections = updatedCollections
        .where((collection) => collection.id == event.collectionId)
        .toList();
    yield trainigState.update(
      selectedDifficulties: [],
      isEmptyCardWord: false,
      filteredWords: event.words,
      selectedCollections: selectedCollections ?? [],
      selectedGames: FilterGames.bricks,
      collections: updatedCollections ?? [],
      isFailure: false,
    );
    // yield TrainingsSuccess(
    //     filteredCollections: filteredCollections ?? [],
    //     filteredWords: updatedWords ?? [],
    //     collections: updatedCollections ?? [],
    //     isEmptyCardWord: updatedIsEmptyCardWord,
    //     selectedGames: FilterGames.bricks);
  }

  Stream<TrainingsState> _mapTrainingsSelectedCollectionsToState(
      TrainingsSelectedCollections event) async* {
    List<Collection> updatedSelectedCollections = [
      ...state.selectedCollections
    ];
    event.isCollection
        ? updatedSelectedCollections.add(event.collection)
        : updatedSelectedCollections.remove(event.collection);

    yield state.update(
      selectedCollections: updatedSelectedCollections,
    );
  }

  Stream<TrainingsState> _mapTrainingsFilteredToState() async* {
    final Map<String, dynamic> data = await _mapWordsToSelectedFilteredList();
    final List<Word> updatedFilteredWordsList =
        data['updatedFilteredWordsList'];
    final bool updatedIsEmptyCardWord = data['updatedIsEmptyCardWord'];
    yield state.update(
      filteredWords: updatedFilteredWordsList,
      isEmptyCardWord: updatedIsEmptyCardWord,
    );
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
    // try {
    // if (state.selectedDifficulties.isNotEmpty &&
    //     state.selectedCollections.isNotEmpty &&
    //     state.filteredWords.isNotEmpty) {
    //   yield TrainingsState.success(
    //     collections: state.collections,
    //     filteredWords: state.filteredWords,
    //     isEmptyCardWord: state.isEmptyCardWord,
    //     selectedCollections: state.selectedCollections,
    //     selectedDifficulties: state.selectedDifficulties,
    //     selectedGames: state.selectedGames,
    //   );
    // } else {
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
    yield state.update(isFailure: false, errorMessage: '');
  }

  Stream<TrainingsState> _mapTrainingsUpdatedDifficultiesToState(
      TrainingsUpdatedDifficulties event) async* {
    final List<int> updetedSelectedDifficulties = [
      ...state.selectedDifficulties
    ];
    updetedSelectedDifficulties.contains(event.difficulty)
        ? updetedSelectedDifficulties.remove(event.difficulty)
        : updetedSelectedDifficulties.add(event.difficulty);
    yield state.update(selectedDifficulties: updetedSelectedDifficulties);
  }

  Future<String> returnErrorMessage() async {
    String error = '';
    if (state.selectedCollections.isEmpty) {
      return error = 'You have to choose which collection';
    }
    if (state.selectedDifficulties.isEmpty) {
      return error = 'You have to choose which words you want to learn';
    }
    if (state.filteredWords.isEmpty) {
      return error = 'There are no words';
    }
    return error;
  }
}
