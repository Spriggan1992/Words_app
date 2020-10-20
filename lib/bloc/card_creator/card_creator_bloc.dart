import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/models/image_data.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/image_repository.dart';
import 'package:words_app/repositories/repositories.dart';

part 'card_creator_event.dart';
part 'card_creator_state.dart';

class CardCreatorBloc extends Bloc<CardCreatorEvent, CardCreatorState> {
  CardCreatorBloc(
      {ImageRepository imageRepository,
      String collectionId,
      WordsRepository wordsRepository})
      : _imageRepository = imageRepository,
        _collectionId = collectionId,
        _wordsRepository = wordsRepository,
        super(CardCreatorState.empty());
  final String _collectionId;
  final ImageRepository _imageRepository;
  final WordsRepository _wordsRepository;
  @override
  Stream<CardCreatorState> mapEventToState(
    CardCreatorEvent event,
  ) async* {
    if (event is CardCreatorLoaded) {
      yield* _mapCardCreatorLoadedToState(event);
    } else if (event is CardCreatorOwnLanguageUpdate) {
      yield* _mapCardCreatorOwnLanguageUpdatedToState(event);
    } else if (event is CardCreatorTargetLanguageUpdate) {
      yield* _mapCardCreatorTargetLanguageUpdatedToState(event);
    } else if (event is CardCreatorSecondLanguageUpdate) {
      yield* _mapCardCreatorSecondLanguageUpdatedToState(event);
    } else if (event is CardCreatorThirdLanguageUpdate) {
      yield* _mapCardCreatorThirdLanguageUpdatedToState(event);
    } else if (event is CardCreatorOwnExapleUpdate) {
      yield* _mapCardCreatorOwnExampleUpdatedToState(event);
    } else if (event is CardCreatorExampleUpdate) {
      yield* _mapCardCreatorExampleUpdatedToState(event);
    } else if (event is CardCreatorPartUpdate) {
      yield* _mapCardCreatorPartUpdatedToState(event);
    } else if (event is CardCreatorUpdateImgFromCamera) {
      yield* _mapCardCreatorUpdatedImageFromCameraToState();
    } else if (event is CardCreatorUpdateImgFromApi) {
      yield* _mapCardCreatorUpdatedImageFromApiToState(event);
    } else if (event is CardCreatorAdded) {
      yield* _mapCardCreatorAdedToState();
    }
  }

  /// Method receives String [collectionLang] and pass it to the CardCreatorSuccess state.
  Stream<CardCreatorState> _mapCardCreatorLoadedToState(
      CardCreatorLoaded event) async* {
    yield state.update(
      word: event.word,
    );
  }

  Stream<CardCreatorState> _mapCardCreatorTargetLanguageUpdatedToState(
      CardCreatorTargetLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        targetLang: event.targetLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          targetLang: event.targetLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorExampleUpdatedToState(
      CardCreatorExampleUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        example: event.example,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          example: event.example,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorOwnLanguageUpdatedToState(
      CardCreatorOwnLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        ownLang: event.ownLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          ownLang: event.ownLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorPartUpdatedToState(
      CardCreatorPartUpdate event) async* {
    print(event.part);
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        part: event.part,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          part: event.part,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorSecondLanguageUpdatedToState(
      CardCreatorSecondLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        secondLang: event.secondLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          secondLang: event.secondLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorThirdLanguageUpdatedToState(
      CardCreatorThirdLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        thirdLang: event.thirdLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          thirdLang: event.thirdLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorOwnExampleUpdatedToState(
      CardCreatorOwnExapleUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        exampleTranslations: event.exampleTranslation,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          exampleTranslations: event.exampleTranslation,
        ),
      );
    }
  }

  Stream<CardCreatorState>
      _mapCardCreatorUpdatedImageFromCameraToState() async* {
    try {
      final File croppedFile = await _imageRepository.getImageFile();
      if (state.word == null) {
        final Word word = Word(
          collectionId: _collectionId,
          image: croppedFile,
        );
        yield state.update(word: word);
      } else {
        yield state.update(
          word: state.word.copyWith(
            image: croppedFile,
          ),
        );
      }
    } catch (_) {
      yield CardCreatorState.failure(
          word: state.word,
          errorMessage:
              'There was an error in  _mapCardCreatorUpdatedImageFromCameraToState');
      yield state.update(
        isSubmiting: false,
        isFailure: false,
        isSuccess: false,
        errorMessage: "",
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorUpdatedImageFromApiToState(
      CardCreatorUpdateImgFromApi event) async* {
    try {
      final File file = await _imageRepository.getImageFileFromUrl(event.url);
      if (state.word == null) {
        final Word word = Word(
          collectionId: _collectionId,
          image: file,
        );
        yield state.update(word: word);
      } else {
        yield state.update(
          word: state.word.copyWith(
            image: file,
          ),
        );
      }
    } catch (_) {
      yield CardCreatorState.failure(
          word: state.word,
          errorMessage:
              'There was an error in  _mapCardCreatorUpdatedImageFromApiToState');
      yield state.update(
        isSubmiting: false,
        isFailure: false,
        isSuccess: false,
        errorMessage: "",
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorAdedToState() async* {
    if (state.word == null) {
      // final Word word = Word(
      //   collectionId: _collectionId,
      //   part: Part.empty(),
      // );
      await _wordsRepository.addNewWord(
          word: Word(collectionId: state.collectionId));
    } else {
      await _wordsRepository.addNewWord(word: state.word);
    }

    yield state.update(
      isFailure: false,
      isSubmiting: false,
      isSuccess: false,
      word: null,
    );
  }
}
