part of 'words_bloc.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class WordsLoaded extends WordsEvent {
  final String id;
  final bool isEdit;

  WordsLoaded({this.id, this.isEdit});

  List<Object> get props => [id, isEdit];
}

class WordsAdded extends WordsEvent {}

class WordsDeleted extends WordsEvent {}

class WordsSelected extends WordsEvent {
  final Word word;

  WordsSelected({this.word});
  List<Object> get props => [word];
}

class WordsSelectedAll extends WordsEvent {}

class WordsDeletedSelectedAll extends WordsEvent {}
