part of 'words_bloc.dart';

abstract class WordsState extends Equatable {
  const WordsState();
  
  @override
  List<Object> get props => [];
}

class WordsLoading extends WordsState {}

class WordsSuccess extends WordsState {
  final List <Word> words;
  WordsSuccess([this.words = const []]);

  List<Object> get props => [words];
  
}

class WordsFailure extends WordsState {}
