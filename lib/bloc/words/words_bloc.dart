import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc() : super(WordsInitial());

  @override
  Stream<WordsState> mapEventToState(
    WordsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
