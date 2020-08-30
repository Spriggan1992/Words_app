import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';

part 'card_creator_event.dart';
part 'card_creator_state.dart';

class CardCreatorBloc extends Bloc<CardCreatorEvent, CardCreatorState> {
  CardCreatorBloc({
    this.wordsRepository,
  }) : super(CardCreatorLoading());

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
      final words = await wordsRepository.fetchAndSetWords(event.id);

      yield CardCreatorSuccess(
          word: Word(collectionId: event.id), words: words);
    } catch (_) {
      yield CardCreatorFailure();
    }
  }
  // Stream<CardCreatorState> _mapCardCreatorLoadedToState(
  //     CardCreatorLoaded event) async* {
  //   try {
  //     yield CardCreatorSuccess(word: Word(collectionId: event.id));
  //   } catch (_) {
  //     yield CardCreatorFailure();
  //   }
  // }

  Stream<CardCreatorState> _mapCardCreatorAddedWordToState(
      CardCreatorAddWord event) async* {
    try {
      final eventWord = event.word;
      // final updatedWord = (state as CardCreatorSuccess)
      //     .words
      //     .firstWhere((word) => word.id == event.word.id)
      //     .copyWith(
      //         collectionId: eventWord.collectionId,
      //         id: eventWord.id,
      //         example: eventWord.example,
      //         isSelected: false,
      //         exampleTranslations: eventWord.exampleTranslations,
      //         image: eventWord.image,
      //         ownLang: eventWord.ownLang,
      //         part: eventWord.part,
      //         secondLang: eventWord.secondLang,
      //         targetLang: eventWord.targetLang,
      //         thirdLang: eventWord.thirdLang);
      // final updatedList = (state as CardCreatorSuccess)
      //     .words
      //     .map((word) => word.id == event.word.id ? word = updatedWord : word);

      final updatedWord = (state as CardCreatorSuccess).word.copyWith(
          collectionId: eventWord.collectionId,
          id: eventWord.id,
          example: eventWord.example,
          isSelected: false,
          exampleTranslations: eventWord.exampleTranslations,
          image: eventWord.image,
          ownLang: eventWord.ownLang,
          part: eventWord.part,
          secondLang: eventWord.secondLang,
          targetLang: eventWord.targetLang,
          thirdLang: eventWord.thirdLang);
      await wordsRepository.addNewWord(updatedWord);

      yield CardCreatorSuccess(word: updatedWord);
    } catch (_) {
      yield CardCreatorFailure();
    }
  }

  // Stream<CardCreatorState> _mapCardCreatorEditWordToState(
  //     CardCreatorEditWord event) async* {
  //   try {
  //     final word = event.word;
  //     final updatedWord = (state as CardCreatorSuccess).word.copyWith(
  //         collectionId: word.collectionId,
  //         id: word.id,
  //         example: word.example,
  //         isSelected: false,
  //         exampleTranslations: word.exampleTranslations,
  //         image: word.image,
  //         ownLang: word.ownLang,
  //         part: word.part,
  //         secondLang: word.secondLang,
  //         targetLang: word.targetLang,
  //         thirdLang: word.thirdLang);

  //     yield CardCreatorSuccess(word: updatedWord);
  //   } catch (_) {
  //     yield CardCreatorFailure();
  //   }
  // }
}
