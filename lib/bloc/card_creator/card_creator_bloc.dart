import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/models/image_data.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/repositories/image_repository.dart';

part 'card_creator_event.dart';
part 'card_creator_state.dart';

class CardCreatorBloc extends Bloc<CardCreatorEvent, CardCreatorState> {
  CardCreatorBloc({ImageRepository imageRepository, String collectionId})
      : _imageRepository = imageRepository,
        _collectionId = collectionId,
        super(CardCreatorState.empty());
  final String _collectionId;
  final ImageRepository _imageRepository;
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
    } else if (event is CardCreatorTargetExampleUpdate) {
      yield* _mapCardCreatorTargetExampleUpdatedToState(event);
    } else if (event is CardCreatorPartUpdate) {
      yield* _mapCardCreatorPartUpdatedToState(event);
    }

    // if (event is CardCreatorUpdateImgFromCamera) {
    //   yield* _mapCardCreatorUpdatedImageFromCameraToState();
    // }
    // if (event is CardCreatorDownloadImagesFromAPI) {
    //   yield* _mapCardCreatorDownloadImagesFromAPIInitialToState(event);
    // }
    // if (event is CardCreatorUpdateImagesFromAPI) {
    //   yield* _mapCardCreatorUpdatedImageFromApiToState(event);
    // }
  }

  /// Method receives String [collectionLang] and pass it to the CardCreatorSuccess state.
  Stream<CardCreatorState> _mapCardCreatorLoadedToState(
      CardCreatorLoaded event) async* {
    yield state.update(
      word: event.word,
    );
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

  Stream<CardCreatorState> _mapCardCreatorTargetLanguageUpdatedToState(
      CardCreatorTargetLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        ownLang: event.targetLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          ownLang: event.targetLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorSecondLanguageUpdatedToState(
      CardCreatorSecondLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        ownLang: event.secondLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          ownLang: event.secondLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorThirdLanguageUpdatedToState(
      CardCreatorThirdLanguageUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        ownLang: event.thirdLanguage,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          ownLang: event.thirdLanguage,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorOwnExampleUpdatedToState(
      CardCreatorOwnExapleUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        ownLang: event.ownExample,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          ownLang: event.ownExample,
        ),
      );
    }
  }

  Stream<CardCreatorState> _mapCardCreatorTargetExampleUpdatedToState(
      CardCreatorTargetExampleUpdate event) async* {
    if (state.word == null) {
      final Word word = Word(
        collectionId: _collectionId,
        ownLang: event.targetExample,
      );
      yield state.update(word: word);
    } else {
      yield state.update(
        word: state.word.copyWith(
          ownLang: event.targetExample,
        ),
      );
    }
  }

  // Stream<CardCreatorState>
  //     _mapCardCreatorUpdatedImageFromCameraToState() async* {
  //   try {
  //     final File croppedFile = await imageRepository.getImageFile();
  //     yield CardCreatorSuccess(image: croppedFile);
  //   } catch (_) {
  //     yield CardCreatorFailure(message: "something went wrong with me");
  //   }
  // }

  // Stream<CardCreatorState> _mapCardCreatorDownloadImagesFromAPIInitialToState(
  //     CardCreatorDownloadImagesFromAPI event) async* {
  //   try {
  //     String collectionLang = (state as CardCreatorSuccess).collectionLang;
  //     List<ImgData> imageData = await imageRepository.getNetworkImg(
  //         word: event.name, collectionLang: collectionLang);

  //     yield CardCreatorSuccess(
  //         imageData: imageData, collectionLang: collectionLang);
  //   } on NetworkException {
  //     yield CardCreatorFailure(message: "No such data you looser");
  //   }
  // }

  // Stream<CardCreatorState> _mapCardCreatorUpdatedImageFromApiToState(
  //     CardCreatorUpdateImagesFromAPI event) async* {
  //   try {
  //     final File file = await imageRepository.getImageFileFromUrl(event.url);
  //     // final File croppedFile = await imageRepository.getImageFile();
  //     yield CardCreatorSuccess(image: file);
  //   } catch (_) {
  //     yield CardCreatorFailure(message: "something went wrong with me");
  //   }
  // }
}
