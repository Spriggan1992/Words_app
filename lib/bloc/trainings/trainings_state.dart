part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}



@immutable
class TrainingsSuccess extends TrainingsState {
  final List<Word> filteredWords;
  final List<Collection> collections;
  final List<Collection> selectedCollections;
  final List<int> selectedDifficulties;
  final FilterGames selectedGames;
  final bool isEmptyCardWord;
  final bool isFailure;
  final String errorMessage;

  const TrainingsSuccess({
    this.filteredWords,
    this.collections,
    this.selectedCollections,
    this.selectedDifficulties,
    this.isEmptyCardWord,
    this.selectedGames,
    this.isFailure,
    this.errorMessage,
  });
 factory TrainingsSuccess.failure({
    List<Word> filteredWords,
    bool isEmptyCardWord,
    List<Collection> collections,
    List<Collection> selectedCollections,
    List<int> selectedDifficulties,
    FilterGames selectedGames,
    String errorMessage,
  }) {
    return TrainingsSuccess(
      filteredWords: filteredWords,
      isEmptyCardWord: isEmptyCardWord,
      collections: collections,
      selectedCollections: selectedCollections,
      selectedDifficulties: selectedDifficulties,
      selectedGames: selectedGames,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  TrainingsSuccess update({
    List<Word> filteredWords,
    bool isEmptyCardWord,
    List<Collection> collections,
    List<Collection> selectedCollections,
    List<int> selectedDifficulties,
    FilterGames selectedGames,
    bool isFailure,
    String errorMessage,
  }) {
    return copyWith(
      filteredWords: filteredWords,
      isEmptyCardWord: isEmptyCardWord,
      collections: collections,
      selectedCollections: selectedCollections,
      selectedDifficulties: selectedDifficulties,
      selectedGames: selectedGames,
      isFailure: isFailure,
      errorMessage: errorMessage,
    );
  }

  TrainingsSuccess copyWith({
    List<Word> filteredWords,
    bool isEmptyCardWord,
    List<Collection> collections,
    List<Collection> selectedCollections,
    List<int> selectedDifficulties,
    FilterGames selectedGames,
    bool isFailure,
    String errorMessage,
  }) {
    return TrainingsSuccess(
      filteredWords: filteredWords ?? this.filteredWords,
      isEmptyCardWord: isEmptyCardWord ?? this.isEmptyCardWord,
      collections: collections ?? this.collections,
      selectedCollections: selectedCollections ?? this.selectedCollections,
      selectedDifficulties: selectedDifficulties ?? this.selectedDifficulties,
      selectedGames: selectedGames ?? this.selectedGames,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => '''TrainingsState {
    filteredWords: $filteredWords,
    isEmptyCardWord: $isEmptyCardWord,
    collections: $collections,
    selectedCollections: $selectedCollections,
    selectedDifficulties: $selectedDifficulties,
    selectedGames: $selectedGames,
    isFailure: $isFailure,
    errorMessage: $errorMessage,
  }''';
  
}

class TrainingsFailure extends TrainingsState {}



@immutable
// class TrainingsState {
//   final List<Word> filteredWords;
//   final List<Collection> collections;
//   final List<Collection> selectedCollections;
//   final List<int> selectedDifficulties;
//   final FilterGames selectedGames;
//   final bool isEmptyCardWord;
//   final bool isFailure;
//   final String errorMessage;

//   const TrainingsState({
//     this.filteredWords,
//     this.collections,
//     this.selectedCollections,
//     this.selectedDifficulties,
//     this.isEmptyCardWord,
//     this.selectedGames,
//     this.isFailure,
//     this.errorMessage,
//   });

//   // factory TrainingsState.empty() {
//   //   return TrainingsState(
//   //     filteredWords: null,
//   //     isEmptyCardWord: null,
//   //     collections: null,
//   //     selectedCollections: null,
//   //     selectedDifficulties: null,
//   //     selectedGames: null,
//   //     isSubmitting: false,
//   //     isSuccess: false,
//   //     isFailure: false,
//   //     errorMessage: '',
//   //   );
//   // }

//   factory TrainingsState.loading() {
//     return TrainingsState();
//   }
//   // factory TrainingsState.submitting({
//   //   List<Word> filteredWords,
//   //   bool isEmptyCardWord,
//   //   List<Collection> collections,
//   //   List<Collection> selectedCollections,
//   //   List<int> selectedDifficulties,
//   //   FilterGames selectedGames,

//   // }) {
//   //   return TrainingsState(
//   //     filteredWords: filteredWords,
//   //     isEmptyCardWord: isEmptyCardWord,
//   //     collections: collections,
//   //     selectedCollections: selectedCollections,
//   //     selectedDifficulties: selectedDifficulties,
//   //     selectedGames: selectedGames,
//   //     isFailure: false,
//   //     errorMessage: '',
//   //   );
//   // }

//   // factory TrainingsState.success({
//   //   List<Word> filteredWords,
//   //   bool isEmptyCardWord,
//   //   List<Collection> collections,
//   //   List<Collection> selectedCollections,
//   //   List<int> selectedDifficulties,
//   //   FilterGames selectedGames,
//   // }) {
//   //   return TrainingsState(
//   //     filteredWords: filteredWords,
//   //     isEmptyCardWord: isEmptyCardWord,
//   //     collections: collections,
//   //     selectedCollections: selectedCollections,
//   //     selectedDifficulties: selectedDifficulties,
//   //     selectedGames: selectedGames,
//   //     isSubmitting: false,
//   //     isSuccess: true,
//   //     isFailure: false,
//   //     errorMessage: '',
//   //   );
//   // }

//   factory TrainingsState.failure({
//     List<Word> filteredWords,
//     bool isEmptyCardWord,
//     List<Collection> collections,
//     List<Collection> selectedCollections,
//     List<int> selectedDifficulties,
//     FilterGames selectedGames,
//     String errorMessage,
//   }) {
//     return TrainingsState(
//       filteredWords: filteredWords,
//       isEmptyCardWord: isEmptyCardWord,
//       collections: collections,
//       selectedCollections: selectedCollections,
//       selectedDifficulties: selectedDifficulties,
//       selectedGames: selectedGames,
//       isFailure: true,
//       errorMessage: errorMessage,
//     );
//   }

//   TrainingsState update({
//     List<Word> filteredWords,
//     bool isEmptyCardWord,
//     List<Collection> collections,
//     List<Collection> selectedCollections,
//     List<int> selectedDifficulties,
//     FilterGames selectedGames,
//     bool isFailure,
//     String errorMessage,
//   }) {
//     return copyWith(
//       filteredWords: filteredWords,
//       isEmptyCardWord: isEmptyCardWord,
//       collections: collections,
//       selectedCollections: selectedCollections,
//       selectedDifficulties: selectedDifficulties,
//       selectedGames: selectedGames,
//       isFailure: isFailure,
//       errorMessage: errorMessage,
//     );
//   }

//   TrainingsState copyWith({
//     List<Word> filteredWords,
//     bool isEmptyCardWord,
//     List<Collection> collections,
//     List<Collection> selectedCollections,
//     List<int> selectedDifficulties,
//     FilterGames selectedGames,
//     bool isFailure,
//     String errorMessage,
//   }) {
//     return TrainingsState(
//       filteredWords: filteredWords ?? this.filteredWords,
//       isEmptyCardWord: isEmptyCardWord ?? this.isEmptyCardWord,
//       collections: collections ?? this.collections,
//       selectedCollections: selectedCollections ?? this.selectedCollections,
//       selectedDifficulties: selectedDifficulties ?? this.selectedDifficulties,
//       selectedGames: selectedGames ?? this.selectedGames,
//       isFailure: isFailure ?? this.isFailure,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   String toString() => '''NoteDetailState {
//     filteredWords: $filteredWords,
//     isEmptyCardWord: $isEmptyCardWord,
//     collections: $collections,
//     selectedCollections: $selectedCollections,
//     selectedDifficulties: $selectedDifficulties,
//     selectedGames: $selectedGames,
//     isFailure: $isFailure,
//     errorMessage: $errorMessage,
//   }''';
// }

// // abstract class TrainingsState extends Equatable {
// //   const TrainingsState();

// //   @override
// //   List<Object> get props => [];
// // }

// // class TrainingsLoading extends TrainingsState {}

// // class TrainingsSuccess extends TrainingsState {
// //   final List<Word> filteredWords;
// //   final bool isEmptyCardWord;
// //   final List<Collection> collections;
// //   final List<Collection> filteredCollections;
// //   final FilterGames selectedGames;

// //   TrainingsSuccess(
// //       {this.filteredWords = const [],
// //       this.collections = const [],
// //       this.filteredCollections = const [],
// //       this.isEmptyCardWord,
// //       this.selectedGames = FilterGames.bricks});
// //   @override
// //   List<Object> get props => [
// //         filteredWords,
// //         collections,
// //         filteredCollections,
// //         isEmptyCardWord,
// //         selectedGames
// //       ];
// // }

// // class TrainingsFailure extends TrainingsState {}
