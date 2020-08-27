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
  final bool isEditMode;
  WordsSuccess({this.words, this.isEditMode});
  // final List <Word> words;

  WordsSuccess copyWith({List<Word> words, bool isEditMode}) {
    return WordsSuccess(
        words: words ?? this.words, isEditMode: isEditMode ?? this.isEditMode);
  }

  List<Object> get props => [words, isEditMode];
}

class WordsFailure extends WordsState {}
