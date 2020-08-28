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
    }
    if (event is WordsSelected) {
      yield* _mapWordsSelectedToState(event);
    }
    if (event is WordsSelectedAll) {
      yield* _mapWordsSelectedAllToState();
    }
    if (event is WordsDeletedSelectedAll) {
      yield* _mapWordsDeletedSelectedAllToState();
    }
    if (event is WordsDeleted) {
      yield* _mapWordsDeletedToState(event);
    }
    if (event is WordsAddToSelectedData) {
      yield* _mapWordsAddToSelectedDataToState(event);
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

  Stream<WordsState> _mapWordsSelectedToState(WordsSelected event) async* {
    try {
      final words = (state as WordsSuccess).words.map((word) {
        return word.id == event.word.id
            ? word.copyWith(isSelected: !event.word.isSelected)
            : word;
      }).toList();

      // // (state as WordsSuccess).words.where((word) => word.isSelected);
      // final List<Word> selectedData = (state as WordsSuccess).words;
      // List<Word> updateSelectedData = [];
      // selectedData.forEach((item) {
      //   if (updateSelectedData.contains(item)) {
      //     updateSelectedData.remove(item);
      //   }
      //   if (item.isSelected == true) {
      //     updateSelectedData.add(item);
      //   }
      // });
      // final List<Word> selectedData = List.from(
      //     (state as WordsSuccess).words.where((word) => word.isSelected));
      // await Future<void>.delayed(const Duration(milliseconds: 100));
      yield WordsSuccess(words: words);
    } catch (_) {
      yield WordsFailure();
    }
  }

  Stream<WordsState> _mapWordsAddToSelectedDataToState(
      WordsAddToSelectedData event) async* {
    try {
      final List<Word> updatedWords = List.from((state as WordsSuccess).words);

      final List<Word> selectedData = List.from(
          (state as WordsSuccess).words.where((word) => word.isSelected));
      yield WordsSuccess(words: updatedWords, selectedData: selectedData);
    } catch (_) {
      yield WordsFailure();
    }
  }

  Stream<WordsState> _mapWordsSelectedAllToState() async* {
    try {
      final select = (state as WordsSuccess).words.every((word) {
        return word.isSelected;
      });

      final List<Word> updateWords = (state as WordsSuccess)
          .words
          .map((word) => word.copyWith(isSelected: !select))
          .toList();
      final List<Word> selectedData = List.from(
          (state as WordsSuccess).words.where((word) => !word.isSelected));
      yield WordsSuccess(words: updateWords, selectedData: selectedData);
    } catch (_) {
      yield WordsFailure();
    }
  }

  Stream<WordsState> _mapWordsDeletedSelectedAllToState() async* {
    try {
      final List<Word> updateWords =
          List.from((state as WordsSuccess).words.where((word) {
        if (word.isSelected) wordsRepository.removeWord(word);
        return !word.isSelected;
      }));
      // updateWords.removeWhere((word) {
      //   if (word.isSelected) wordsRepository.removeWord(word);
      //   return word.isSelected;
      // });

      yield WordsSuccess(words: updateWords);
    } catch (_) {
      yield WordsFailure();
    }
  }

  Stream<WordsState> _mapWordsDeletedToState(WordsDeleted event) async* {
    try {
      final List<Word> updateWords = List.from((state as WordsSuccess)
          .words
          .where((word) => word.id != event.word.id));
      yield WordsSuccess(words: updateWords);
      wordsRepository.removeWord(event.word);
    } catch (_) {
      yield WordsFailure();
    }
  }
}
