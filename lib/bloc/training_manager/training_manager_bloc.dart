import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/screens/training_manager_screen/helper.dart';

part 'training_manager_event.dart';
part 'training_manager_state.dart';

class TrainingManagerBloc
    extends Bloc<TrainingManagerEvent, TrainingManagerState> {
  final WordsRepository wordsRepository;
  final CollectionsRepository collectionsRepository;
  final TrainingManagerRepository trainingManagerRepository;

  TrainingManagerBloc(
      {this.wordsRepository,
      this.collectionsRepository,
      this.trainingManagerRepository})
      : super(TrainingManagerState());

  @override
  Stream<TrainingManagerState> mapEventToState(
    TrainingManagerEvent event,
  ) async* {
    if (event is TrainingManagerLoaded) {
      yield* _mapTrainingManagerLoadedToState(event);
    }
    if (event is TrainingManagerSelectedCollections) {
      yield* _mapTrainingManagerSelectedCollectionsToState(event);
    }
    if (event is TrainingManagerFiltered) {
      yield* _mapTrainingManagerFilteredToState();
    }
    if (event is TrainingManagerSelectedGames) {
      yield* _mapTrainingManagerSelectedGamesToState(event);
    }
    if (event is TrainingManagerSubmitted) {
      yield* _mapTrainingManagerSubmittedToState();
    }
    if (event is TrainingManagerUpdatedDifficulties) {
      yield* _mapTrainingManagerUpdatedDifficultiesToState(event);
    }
  }

  Stream<TrainingManagerState> _mapTrainingManagerLoadedToState(
      TrainingManagerLoaded event) async* {
    final List<Collection> updatedCollections =
        await collectionsRepository.fetchAndSetCollection();
    final List<Collection> selectedCollections = updatedCollections
        .where((collection) => collection.id == event.collectionId)
        .toList();
    yield state.update(
      selectedDifficulties: [],
      isEmptyCardWord: false,
      filteredWords: event.words,
      selectedCollections: selectedCollections ?? [],
      selectedGames: FilterGames.bricks,
      collections: updatedCollections ?? [],
      isFailure: false,
    );
  }

  Stream<TrainingManagerState> _mapTrainingManagerSelectedCollectionsToState(
      TrainingManagerSelectedCollections event) async* {
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

  Stream<TrainingManagerState> _mapTrainingManagerFilteredToState() async* {
    final Map<String, dynamic> data =
        await trainingManagerRepository.mapWordsToSelectedFilteredList(
            state: state, wordsRepository: wordsRepository);
    final List<Word> updatedFilteredWordsList =
        data['updatedFilteredWordsList'];
    final bool updatedIsEmptyCardWord = data['updatedIsEmptyCardWord'];
    yield state.update(
      filteredWords: updatedFilteredWordsList,
      isEmptyCardWord: updatedIsEmptyCardWord,
    );
  }

  Stream<TrainingManagerState> _mapTrainingManagerSelectedGamesToState(
      TrainingManagerSelectedGames event) async* {
    yield state.update(selectedGames: event.selectedGame);
  }

  Stream<TrainingManagerState> _mapTrainingManagerSubmittedToState() async* {
    try {
      String error =
          await trainingManagerRepository.returnErrorMessage(state: state);
      yield TrainingManagerState.failure(
        collections: state.collections,
        filteredWords: state.filteredWords,
        isEmptyCardWord: state.isEmptyCardWord,
        selectedCollections: state.selectedCollections,
        selectedDifficulties: state.selectedDifficulties,
        selectedGames: state.selectedGames,
        errorMessage: error,
      );
      yield state.update(isFailure: false, errorMessage: '');
    } catch (e) {
      print(e);
    }
  }

  Stream<TrainingManagerState> _mapTrainingManagerUpdatedDifficultiesToState(
      TrainingManagerUpdatedDifficulties event) async* {
    final List<int> updetedSelectedDifficulties = [
      ...state.selectedDifficulties
    ];
    updetedSelectedDifficulties.contains(event.difficulty)
        ? updetedSelectedDifficulties.remove(event.difficulty)
        : updetedSelectedDifficulties.add(event.difficulty);
    yield state.update(selectedDifficulties: updetedSelectedDifficulties);
  }
}
