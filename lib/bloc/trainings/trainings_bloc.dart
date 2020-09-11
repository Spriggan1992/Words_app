import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/collection.dart';
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
    if (event is TrainingsFiltered) {
      yield* _mapTrainingsFilteredToState(event);
    }
    // if (event is TrainingsSelectCollections) {
    //   yield* _mapTrainingsSelectCollectionsToState(event);
    // }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    try {
      final updatedWords = event.words;

      final List<Collection> updatedListCollection =
          await collectionsRepository.fetchAndSetCollection();
      final List<Collection> filteredListCollections = updatedListCollection
          .where((collection) => collection.id == event.collectionId)
          .toList();

      print('id = $filteredListCollections');
      yield TrainingsSuccess(
        filteredListCollections: filteredListCollections,
        words: updatedWords,
        filteredListWords: updatedWords,
        listCollections: updatedListCollection,
      );
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsFilteredToState(
      TrainingsFiltered event) async* {
    final List<Collection> updatedFilteredListCollections =
        List.from(event.selectedListCollections);
    final List<Collection> updatedListCollections =
        List.from((state as TrainingsSuccess).listCollections);

    final List<Word> selectedFilteredList = [];
    for (var i = 0; i < event.selectedListCollections.length; i++) {
      var a = await wordsRepository
          .fetchAndSetWords(event.selectedListCollections[i].id);
      a.forEach((element) {
        selectedFilteredList.add(element);
      });
    }
    final List<Word> updatedFilteredList = [];
    for (var i = 0; i < event.selectedDifficulties.length; i++) {
      selectedFilteredList.forEach((word) {
        if (word.difficulty == event.selectedDifficulties[i]) {
          updatedFilteredList.add(word);
          print('word difficulty = ${word.difficulty} $i');
        }
        if (event.selectedDifficulties[i] == 3) {
          print('word difficulty = ${word.difficulty} $i');
          updatedFilteredList.add(word);
        }
      });
    }

    yield TrainingsSuccess(
      filteredListWords: updatedFilteredList,
      listCollections: updatedListCollections,
      filteredListCollections: updatedFilteredListCollections,
    );
  }
}
