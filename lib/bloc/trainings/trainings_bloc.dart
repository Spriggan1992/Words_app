import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/word.dart';

part 'trainings_event.dart';
part 'trainings_state.dart';

class TrainingsBloc extends Bloc<TrainingsEvent, TrainingsState> {
  TrainingsBloc() : super(TrainingsLoading());

  @override
  Stream<TrainingsState> mapEventToState(
    TrainingsEvent event,
  ) async* {
    if (event is TrainingsLoaded) {
      yield* _mapTrainingsLoadedToState(event);
    }
    if (event is TrainingsDifficultiesFilter) {
      yield* _mapTrainingsDifficultiesFilterToState(event);
    }
  }

  Stream<TrainingsState> _mapTrainingsLoadedToState(
      TrainingsLoaded event) async* {
    try {
      final updatedWords = event.words;
      yield TrainingsSuccess(words: updatedWords);
    } catch (_) {
      yield TrainingsFailure();
    }
  }

  Stream<TrainingsState> _mapTrainingsDifficultiesFilterToState(
      TrainingsDifficultiesFilter event) async* {
    if (event.difficultyFilter == 0) {
      try {
        final List<Word> updatedWords = (state as TrainingsSuccess)
            .words
            .where((word) => word.difficulty == 0);
        yield TrainingsSuccess(words: updatedWords);
      } catch (_) {
        yield TrainingsFailure();
      }
    }
  }
}
