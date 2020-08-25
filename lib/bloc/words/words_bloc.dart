import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc({this.wordsRepository}) : super(WordsLoading());

  final WordsRepository wordsRepository;

  Stream<WordsState> mapEventToState(
    WordsEvent event,
  ) async* {
    if (event is WordsLoaded) {
      yield* _mapWordsLoadedToState(event);
    }
    //   else if (event is WordsAdded) {
    //     yield* _mapWordsAddedToState();
    //  }
  }

  Stream<WordsState> _mapWordsLoadedToState(WordsLoaded event) async* {
    // print(event.id);
    try {
      final words = await wordsRepository.fetchAndSetWords(event.id);
      print(words);
      yield WordsSuccess(words);
    } catch (_) {
      yield WordsFailure();
    }
  }

// Stream<WordsState> _mapWordsAddedToState(
//       ) async* {
//     try {
//       yield WordsAdded();
//     } catch (_) {
//       yield ;
//     }
//   }

}
