import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/models/models.dart';

part 'bricks_event.dart';
part 'bricks_state.dart';

class BricksBloc extends Bloc<BricksEvent, BricksState> {
  final TrainingManagerBloc _trainingManagerBloc;

  BricksBloc({@required TrainingManagerBloc trainingManagerBloc})
      : _trainingManagerBloc = trainingManagerBloc,
        super(BricksLoading());

  @override
  Stream<BricksState> mapEventToState(
    BricksEvent event,
  ) async* {
    if (event is BricksLoaded) {
      yield* _mapBricksLoadedToState();
    }
  }

  Stream<BricksState> _mapBricksLoadedToState() async* {
    try {
      final words = _trainingManagerBloc.state.filteredWords;
      final answer = await getAnswerWord(words);
      final listBricks = await getListBricks(answer);
      print('words: $words');
      print('listBricks: $listBricks');
      yield BricksSuccess(
          answer: answer,
          listBricks: listBricks,
          initialData: words,
          answerWordArray: [],
          correct: 0,
          wrong: 0);
    } catch (e) {
      print(e);
      yield BricksFailure();
    }
  }

  Future<String> getAnswerWord(List<Word> words) async {
    final answerWord = words.map((item) => item.targetLang.toLowerCase());

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
}
