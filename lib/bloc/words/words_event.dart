part of 'words_bloc.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class WordsLoaded extends WordsEvent {
  final String id;

  WordsLoaded(this.id);

  List<Object> get props => [id];
}

class WordsAdded extends WordsEvent {}

class WordsDeleted extends WordsEvent {}

class WordsUpdated extends WordsEvent {}

class WordsToggledAll extends WordsEvent {}
