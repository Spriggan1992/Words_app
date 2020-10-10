import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/image_data.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/image_repository.dart';

part 'card_creator_event.dart';
part 'card_creator_state.dart';

class CardCreatorBloc extends Bloc<CardCreatorEvent, CardCreatorState> {
  CardCreatorBloc({this.imageRepository}) : super(CardCreatorLoading());

  final ImageRepository imageRepository;
  @override
  Stream<CardCreatorState> mapEventToState(
    CardCreatorEvent event,
  ) async* {
    if (event is CardCreatorLoaded) {
      yield* _mapCardCreatorLoadedToState(event);
    }
    if (event is CardCreatorUpdateImgFromCamera) {
      yield* _mapCardCreatorUpdatedImageFromCameraToState();
    }
    if (event is CardCreatorDownloadImagesFromAPI) {
      yield* _mapCardCreatorDownloadImagesFromAPIInitialToState(event);
    }
    if (event is CardCreatorUpdateImagesFromAPI) {
      yield* _mapCardCreatorUpdatedImageFromApiToState(event);
    }
  }

  /// Method receives String [collectionLang] and pass it to the CardCreatorSuccess state.
  Stream<CardCreatorState> _mapCardCreatorLoadedToState(
      CardCreatorLoaded event) async* {
    try {
      yield CardCreatorSuccess(
          image: event.word.image, collectionLang: event.collectionLaguage);
    } catch (_) {
      yield CardCreatorFailure();
    }
  }

  Stream<CardCreatorState>
      _mapCardCreatorUpdatedImageFromCameraToState() async* {
    try {
      final File croppedFile = await imageRepository.getImageFile();
      yield CardCreatorSuccess(image: croppedFile);
    } catch (_) {
      yield CardCreatorFailure(message: "something went wrong with me");
    }
  }

  Stream<CardCreatorState> _mapCardCreatorDownloadImagesFromAPIInitialToState(
      CardCreatorDownloadImagesFromAPI event) async* {
    try {
      String collectionLang = (state as CardCreatorSuccess).collectionLang;
      List<ImgData> imageData = await imageRepository.getNetworkImg(
          word: event.name, collectionLang: collectionLang);

      yield CardCreatorSuccess(
          imageData: imageData, collectionLang: collectionLang);
    } on NetworkException {
      yield CardCreatorFailure(message: "No such data you looser");
    }
  }

  Stream<CardCreatorState> _mapCardCreatorUpdatedImageFromApiToState(
      CardCreatorUpdateImagesFromAPI event) async* {
    try {
      final File file = await imageRepository.getImageFileFromUrl(event.url);
      yield CardCreatorSuccess(image: file);
    } catch (_) {
      yield CardCreatorFailure(message: "something went wrong with me");
    }
  }
}
