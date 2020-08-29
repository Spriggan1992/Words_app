import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/word.dart';

part 'card_creator_event.dart';
part 'card_creator_state.dart';

class CardCreatorBloc extends Bloc<CardCreatorEvent, CardCreatorState> {
  CardCreatorBloc() : super(CardCreatorLoading());

  @override
  Stream<CardCreatorState> mapEventToState(
    CardCreatorEvent event,
  ) async* {
    if (event is CardCreatorLoaded) {
      yield* _mapCardCreatorLoadedToState(event);
    }
    // if (event is CardCreatorAddWord) {
    //   yield* _mapCardCreatorAddedWordToState();
    // }
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

  // Stream<CardCreatorState> _mapCardCreatorAddedWordToState(
  //     CardCreatorLoaded event) async* {
  //   try {
  //     yield CardCreatorSuccess(word: Word(collectionId: event.id));
  //   } catch (_) {
  //     yield CardCreatorFailure();
  //   }
  // }
}
