import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    try {
      final words = await wordsRepository.fetchAndSetWords(event.id);
      yield WordsSuccess(words: words);
    } catch (_) {
      yield WordsFailure();
    }
  }

  Stream<WordsState> _mapWordsToggleEditModeToState() async* {
    try {
      final data = (state as WordsSuccess).isEditMode;
      final words = (state as WordsSuccess).words;
      final isEditing =
          (state as WordsSuccess).copyWith(words: words, isEditMode: !data);
      yield WordsSuccess();

      print(isEditing);
    } catch (_) {
      yield WordsFailure();
    }
  }
}
