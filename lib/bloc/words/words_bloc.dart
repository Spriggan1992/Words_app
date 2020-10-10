import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words/words_repository.dart';

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
    if (event is WordsToggled) {
      yield* _mapWordsToggeldToState(event);
    }
    if (event is WordsToggledAll) {
      yield* _mapWordsToggledAllToState();
    }
    if (event is WordsDeletedSelectedAll) {
      yield* _mapWordsDeletedSelectedAllToState();
    }
    if (event is WordsDeleted) {
      yield* _mapWordsDeletedToState(event);
    }
    if (event is WordsAddToSelectedList) {
      yield* _mapWordsAddToSelectedListToState(event);
    }
    if (event is WordsAddSelectedAllToSelectedList) {
      yield* _mapWordsAddSelectedAllToSelectedListToState();
    }
    if (event is WordsTurnOffIsEditingMode) {
      yield* _mapWordsTurnOffIsEditingModeToState();
    }
    if (event is WordsUpdatedWord) {
      yield* _mapWordsUpdatedWordToState(event);
    }
    if (event is WordsAdded) {
      yield* _mapWordsAddedToState(event);
    }
    if (event is WordsPopulate) {
      yield* _mapWordsPopulatedToState(event);
    }
    // if (event is WordsAdded) {
    //   yield* _mapWordsUpdatedWordDifficultyToState(event);
    // }
  }

  /// call populate method
  Stream<WordsState> _mapWordsPopulatedToState(WordsPopulate event) async* {
    try {
      List<Word> dummyDataList = await wordsRepository.populateList(event.id);

      // yield WordsSuccess(
      //     words: [...(state as WordsSuccess).words, ...dummyDataList]);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// Fetch data from db through repository
  Stream<WordsState> _mapWordsLoadedToState(WordsLoaded event) async* {
    try {
      final words =
          await wordsRepository.fetchAndSetWords(collectionId: event.id);

      yield WordsSuccess(words: words);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// This method is responsible for toggle  a word, and change color of selected word
  Stream<WordsState> _mapWordsToggeldToState(WordsToggled event) async* {
    try {
      final words = (state as WordsSuccess).words.map((word) {
        return word.id == event.word.id
            ? word.copyWith(isSelected: !event.word.isSelected)
            : word;
      }).toList();

      yield WordsSuccess(words: words);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// This method is responsible for toggle all words, and change color of selected words
  Stream<WordsState> _mapWordsToggledAllToState() async* {
    try {
      final select = (state as WordsSuccess).words.every((word) {
        return word.isSelected;
      });

      final List<Word> updateWords = (state as WordsSuccess)
          .words
          .map((word) => word.copyWith(isSelected: !select))
          .toList();

      yield WordsSuccess(words: updateWords);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// This method is responsible for adding word which has a condition [words.isSelected == true] to separate [selectedList]
  Stream<WordsState> _mapWordsAddToSelectedListToState(
      WordsAddToSelectedList event) async* {
    try {
      final List<Word> updatedWords = List.from((state as WordsSuccess).words);

      final List<Word> updatedSelectedList = List.from(
          (state as WordsSuccess).words.where((word) => word.isSelected));

      yield WordsSuccess(
          words: updatedWords, selectedList: updatedSelectedList);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// This method is responsible for adding all words which has a condition [words.isSelected == true] to separate [selectedList]
  Stream<WordsState> _mapWordsAddSelectedAllToSelectedListToState() async* {
    try {
      final List<Word> updateWords = List.from((state as WordsSuccess).words);

      final List<Word> updatedSelectedList = List.from(
          (state as WordsSuccess).words.where((word) => word.isSelected));

      yield WordsSuccess(words: updateWords, selectedList: updatedSelectedList);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// This method is responsible for deleting   words which has a condition [words.isSelected == true] from UI and DB
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

  /// This method is responsible for deleting [Word] on dismissable swipe, from UI and DB
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

  /// This method is responsible for untoggle all selected words
  Stream<WordsState> _mapWordsTurnOffIsEditingModeToState() async* {
    try {
      final List<Word> updatedSelectedList = [];
      final List<Word> updateWords = List.from((state as WordsSuccess)
          .words
          .map((word) => word.copyWith(isSelected: false)));

      yield WordsSuccess(words: updateWords, selectedList: updatedSelectedList);
    } catch (_) {
      yield WordsFailure();
    }
  }

  /// This method is responsible for editing [Word] on dismissable swipe, edit button
  ///, and save it to UI wordsList  and DB
  Stream<WordsState> _mapWordsUpdatedWordToState(
      WordsUpdatedWord event) async* {
    try {
      final updatedWord = (state as WordsSuccess).words.map((word) {
        if (word.id == event.word.id) {
          wordsRepository.updateWord(word: event.word, wordId: event.word.id);
        }

        return word.id == event.word.id
            ? word.copyWith(
                collectionId: word.collectionId,
                id: event.word.id,
                example: event.word.example,
                isSelected: false,
                exampleTranslations: event.word.exampleTranslations,
                image: event.word.image,
                ownLang: event.word.ownLang,
                part: event.word.part,
                secondLang: event.word.secondLang,
                targetLang: event.word.targetLang,
                thirdLang: event.word.thirdLang,
              )
            : word;
      }).toList();
      yield WordsSuccess(words: updatedWord);
    } catch (_) {
      yield WordsFailure();
    }
  }

  // /// This method is responsible for editing [Word] on dismissable swipe, edit button
  // ///, and save it to UI wordsList  and DB
  // Stream<WordsState> _mapWordsUpdatedWordDifficultyToState(
  //     WordsUpdatedWord event) async* {
  //   try {
  //     final updatedWord = (state as WordsSuccess).words.map((word) {
  //       print("from IF ${event.word.id}");
  //       if (word.id == event.word.id) {
  //         wordsRepository.updateWord(word: event.word);
  //       }

  //       return word.id == event.word.id
  //           ? word.copyWith(
  //               collectionId: word.collectionId,
  //               id: event.word.id,
  //               example: event.word.example,
  //               isSelected: false,
  //               exampleTranslations: event.word.exampleTranslations,
  //               image: event.word.image,
  //               ownLang: event.word.ownLang,
  //               part: event.word.part,
  //               secondLang: event.word.secondLang,
  //               targetLang: event.word.targetLang,
  //               thirdLang: event.word.thirdLang,
  //             )
  //           : word;
  //     }).toList();
  //     yield WordsSuccess(words: updatedWord);
  //   } catch (_) {
  //     yield WordsFailure();
  //   }
  // }

  /// This method is responsible for adding [Word] on preees of bottom Add Word buttton, edit button , to UI and DB
  Stream<WordsState> _mapWordsAddedToState(WordsAdded event) async* {
    if (state is WordsSuccess) {
      final List<Word> updatedWord = List.from((state as WordsSuccess).words)
        ..add(event.word);

      yield WordsSuccess(words: updatedWord);

      await wordsRepository.addNewWord(word: event.word);
    }
  }
}
