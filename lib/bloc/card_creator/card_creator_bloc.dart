import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';
part 'card_creator_event.dart';
part 'card_creator_state.dart';

class CardCreatorBloc extends Bloc<CardCreatorEvent, CardCreatorState> {
  CardCreatorBloc({this.wordsRepository}) : super(CardCreatorLoading());

  final WordsRepository wordsRepository;
  @override
  Stream<CardCreatorState> mapEventToState(
    CardCreatorEvent event,
  ) async* {
    if (event is CardCreatorLoaded) {
      yield* _mapCardCreatorLoadedToState(event);
    }
    if (event is CardCreatorUpdateImage) {
      yield* _mapCardCreatorUpdatedImageToState();
    }
  }

  Stream<CardCreatorState> _mapCardCreatorLoadedToState(
      CardCreatorLoaded event) async* {
    try {
      yield CardCreatorSuccess(image: event.word.image);
    } catch (_) {
      yield CardCreatorFailure();
    }
  }

  Stream<CardCreatorState> _mapCardCreatorUpdatedImageToState() async* {
    try {
      final File croppedFile = await wordsRepository.getImageFile();
      yield CardCreatorSuccess(image: croppedFile);
    } catch (_) {
      yield CardCreatorFailure();
    }
  }
}
