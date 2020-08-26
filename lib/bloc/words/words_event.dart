part of 'words_bloc.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class WordsLoaded extends WordsEvent {
  final Collection words;

  WordsLoaded(this.words);

  List<Object> get props => [words];
}

class WordsAdded extends WordsEvent {}

class WordsDeleted extends WordsEvent {}

class WordsUpdated extends WordsEvent {}

class WordsToggledAll extends WordsEvent {}
