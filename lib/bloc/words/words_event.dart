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

class WordsToggled extends WordsEvent {
  final Word word;

  WordsToggled({this.word});
  List<Object> get props => [word];
}

class WordsToggledAll extends WordsEvent {}

class WordsDeleted extends WordsEvent {
  final Word word;

  WordsDeleted({this.word});
  List<Object> get props => [word];
}

class WordsDeletedSelectedAll extends WordsEvent {}

class WordsAddSelectedAllToSelectedList extends WordsEvent {}

class WordsAddToSelectedList extends WordsEvent {
  final Word word;

  WordsAddToSelectedList({this.word});
  List<Object> get props => [word];
}

class WordsTurnOffIsEditingMode extends WordsEvent {}

class WordsUpdatedWord extends WordsEvent {
  final Word word;

  WordsUpdatedWord({this.word});
  List<Object> get props => [word];
}

class WordsAdded extends WordsEvent {
  final Word word;

  WordsAdded({this.word});
  List<Object> get props => [word];
}

// HACK:  temp method for populating collection with words
class WordsPopulate extends WordsEvent {
  final String id;

  WordsPopulate({this.id});

  List<Object> get props => [id];
}
