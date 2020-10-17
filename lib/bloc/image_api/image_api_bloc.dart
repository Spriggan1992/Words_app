import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';

import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/image_repository.dart';

part 'image_api_event.dart';
part 'image_api_state.dart';

class ImageApiBloc extends Bloc<ImageApiEvent, ImageApiState> {
  final ImageRepository _imageRepository;
  final String search;
  // final CardCreatorState _cardCreatorState;
  ImageApiBloc(ImageRepository imageRepository,
      CardCreatorState cardCreatorState, this.search)
      : _imageRepository = imageRepository,
        // _cardCreatorState = cardCreatorState,
        super(ImageApiState.empty());

  @override
  Stream<ImageApiState> mapEventToState(
    ImageApiEvent event,
  ) async* {
    if (event is ImageApiLoaded) {
      yield* _mapCardCreatorLoadedToState(event);
    } else if (event is ImageApiSearchUpdated) {
      yield* _mapImageApiSearchUpdatedToState(event);
    } else if (event is ImageApiDownloadImagesFromAPI) {
      yield* _mapImageApiDownloadImagesFromAPIInitialToState(event);
    } else if (event is ImageApiUpdateImagesFromAPI) {
      yield* _mapImageApiUpdatedImageFromApiToState(event);
    }
  }

  /// Method receives String [collectionLang] and pass it to the CardCreatorSuccess state.
  Stream<ImageApiState> _mapCardCreatorLoadedToState(
      ImageApiLoaded event) async* {
    yield state.update(search: search);
  }

  Stream<ImageApiState> _mapImageApiSearchUpdatedToState(
      ImageApiSearchUpdated event) async* {
    print(event.search);
    if (state.search == null) {
      final search = event.search;
      yield state.update(search: search);
    } else {
      yield state.update(search: event.search);
    }
  }

  Stream<ImageApiState> _mapImageApiDownloadImagesFromAPIInitialToState(
      ImageApiDownloadImagesFromAPI event) async* {
    try {
      List<ImgData> imageData = await _imageRepository.getNetworkImg(
          word: state.search, collectionLang: 'en');
      yield state.update(imageData: imageData);
    } on NetworkException {
      yield ImageApiState.failure(
          search: '',
          errorMessage:
              'something went Wrong in _mapImageApiDownloadImagesFromAPIInitialToState');
    }
  }

  Stream<ImageApiState> _mapImageApiUpdatedImageFromApiToState(
      ImageApiUpdateImagesFromAPI event) async* {
    try {
      final File file = await _imageRepository.getImageFileFromUrl(event.url);
      yield state.update(image: file);
    } catch (_) {
      yield ImageApiState.failure(
          search: state.search,
          errorMessage: '_mapImageApiUpdatedImageFromApiToState');
    }
  }
}
