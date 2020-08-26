import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc({this.wordsRepository}) : super(WordsLoading());

  final WordsRepository wordsRepository;
  Collection collection;
  Stream<WordsState> mapEventToState(
    WordsEvent event,
  ) async* {
    if (event is WordsLoaded) {
      yield* _mapWordsLoadedToState(event);
    } else if (event is WordsToggleEditMode) {
      yield* _mapWordsToggleEditModeToState();
    }
  }

  Stream<WordsState> _mapWordsLoadedToState(WordsLoaded event) async* {
    // print(event.id);
    try {
      final words = await wordsRepository.fetchAndSetWords(event.id);

      // collection = collection.copyWith(
      //   id: event.words.id,
      //   isEditingMode: event.words.isEditingMode,
      //   title: event.words.title,
      //   language: event.words.language,
      //   collection: words,

      // print(words);
      yield WordsSuccess(words: words);
    } catch (_) {
      yield WordsFailure();
    }
  }

  Stream<WordsState> _mapWordsToggleEditModeToState() async* {
    try {
      // final toggle = ((state as WordsSuccess).words.isEditingMode);
      final updatedWords = !(state as WordsSuccess).isEditingMode;

      // print(
      // "Printing _mapWordsToggleEditModeToState ${updatedWords.collection[1].id == null} ");
      yield WordsSuccess(isEditingMode: updatedWords);
    } catch (_) {
      yield WordsFailure();
    }
  }

// Stream<WordsState> _mapWordsAddedToState(
//       ) async* {
//     try {
//       yield WordsAdded();
//     } catch (_) {
//       yield ;
//     }
//   }

}
