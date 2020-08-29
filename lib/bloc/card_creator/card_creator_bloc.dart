import 'dart:async';

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
    if (event is CardCreatorAddWord) {
      yield* _mapCardCreatorAddedWordToState(event);
    }
    // if (event is CardCreatorEditWord) {
    //   yield* _mapCardCreatorEditWordToState(event);
    // }
  }

  Stream<CardCreatorState> _mapCardCreatorLoadedToState(
      CardCreatorLoaded event) async* {
    try {
      yield CardCreatorSuccess(word: Word(collectionId: event.id));
    } catch (_) {
      yield CardCreatorFailure();
    }
  }

  Stream<CardCreatorState> _mapCardCreatorAddedWordToState(
      CardCreatorAddWord event) async* {
    try {
      final word = event.word;

      final updatedWord = (state as CardCreatorSuccess).word.copyWith(
          collectionId: word.collectionId,
          id: word.id,
          example: word.example,
          isSelected: false,
          exampleTranslations: word.exampleTranslations,
          image: word.image,
          ownLang: word.ownLang,
          part: word.part,
          secondLang: word.secondLang,
          targetLang: word.targetLang,
          thirdLang: word.thirdLang);
      await wordsRepository.addNewWord(updatedWord);
      yield CardCreatorSuccess(word: updatedWord);
    } catch (_) {
      yield CardCreatorFailure();
    }
  }
}
