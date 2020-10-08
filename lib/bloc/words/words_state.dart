part of 'words_bloc.dart';

abstract class WordsState extends Equatable {
  const WordsState();

  @override
  List<Object> get props => [];
}

class WordsLoading extends WordsState {}

class WordsSuccess extends WordsState {
  final List<Word> words;
  final List<Word> selectedList;

  WordsSuccess({this.words = const [], this.selectedList});
  @override
  List<Object> get props => [words, selectedList];
}

class WordsFailure extends WordsState {}
