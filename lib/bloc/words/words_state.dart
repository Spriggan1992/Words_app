part of 'words_bloc.dart';

abstract class WordsState extends Equatable {
  const WordsState();
  
  @override
  List<Object> get props => [];
}

class WordsInitial extends WordsState {}
