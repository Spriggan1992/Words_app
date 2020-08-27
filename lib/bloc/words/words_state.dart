part of 'words_bloc.dart';

// class IsEditMode extends Equatable {
//   final bool isEditMode;

//   IsEditMode({this.isEditMode = false});

//   IsEditMode copyWith({bool isEditMode}) {
//     return IsEditMode(isEditMode: isEditMode ?? this.isEditMode);
//   }

//   @override
//   List<Object> get props => [isEditMode];
// }

abstract class WordsState extends Equatable {
  const WordsState();

  @override
  List<Object> get props => [];
}

class WordsLoading extends WordsState {}

class WordsSuccess extends WordsState {
  final List<Word> words;
  WordsSuccess({this.words});
 



  List<Object> get props => [words];
}

class WordsFailure extends WordsState {}
