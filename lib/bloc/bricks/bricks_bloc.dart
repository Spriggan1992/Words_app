import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/repositories.dart';

part 'bricks_event.dart';
part 'bricks_state.dart';

class BricksBloc extends Bloc<BricksEvent, BricksState> {
  final TrainingManagerBloc _trainingManagerBloc;
  final BricksRepository _bricksRepository;

  BricksBloc(
      {@required TrainingManagerBloc trainingManagerBloc,
      @required BricksRepository bricksRepository})
      : _trainingManagerBloc = trainingManagerBloc,
        _bricksRepository = bricksRepository,
        super(BricksLoading());

  @override
  Stream<BricksState> mapEventToState(
    BricksEvent event,
  ) async* {
    if (event is BricksLoaded) {
      yield* _mapBricksLoadedToState();
    }
    if (event is BricksAddedLetter) {
      yield* _mapBricksAddedLetterToState(event);
    }
  }

  Stream<BricksState> _mapBricksLoadedToState() async* {
    try {
      final List<Word> words = _trainingManagerBloc.state.filteredWords;
      final String answer = await getAnswerWord(words);
      final List<Brick<String>> listBricks = await getListBricks(answer);
      print('words: $words');
      print('listBricks: $listBricks');
      yield BricksSuccess(
          answer: answer,
          listBricks: listBricks,
          initialData: words,
          answersListOfBricks: [],
          correct: 0,
          wrong: 0);
    } catch (e) {
      print(e);
      yield BricksFailure();
    }
  }

  Future<String> getAnswerWord(List<Word> words) async {
    final answerWord = words.last.targetLang.toLowerCase();
    // final answerWord = words.map((item) => item.targetLang.toLowerCase());
    return answerWord.toString();
  }

  Future<List<Brick<String>>> getListBricks(
    String answer,
  ) async {
    List<String> targetSplitted = answer.toLowerCase().split('');
    List<Brick<String>> updatedListBricks = [];

    targetSplitted.forEach((item) {
      updatedListBricks.add(Brick(targetLangWord: item, isVisible: true));
    });

    return updatedListBricks..shuffle();
  }

  Stream<BricksState> _mapBricksAddedLetterToState(
      BricksAddedLetter event) async* {
    try {
      final List<String> answersListOfBricks =
          (state as BricksSuccess).answersListOfBricks;
      final List<String> updatedAnswersListOfBricks =
          await _bricksRepository.addLetter(
              answersListOfBricks: answersListOfBricks, letter: event.letter);
    } catch (e) {
      print(e);
      yield BricksFailure();
    }
  }
}
