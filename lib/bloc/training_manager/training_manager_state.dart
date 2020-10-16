part of 'training_manager_bloc.dart';

@immutable
class TrainingManagerState {
  final List<Word> filteredWords;
  final List<Collection> collections;
  final List<Collection> selectedCollections;
  final List<int> selectedDifficulties;
  final FilterGames selectedGames;
  final bool isEmptyCardWord;
  final bool isFailure;
  final String errorMessage;

  const TrainingManagerState({
    this.filteredWords,
    this.collections,
    this.selectedCollections,
    this.selectedDifficulties,
    this.isEmptyCardWord,
    this.selectedGames,
    this.isFailure,
    this.errorMessage,
  });

  factory TrainingManagerState.loading() {
    return TrainingManagerState();
  }

  factory TrainingManagerState.failure({
    List<Word> filteredWords,
    bool isEmptyCardWord,
    List<Collection> collections,
    List<Collection> selectedCollections,
    List<int> selectedDifficulties,
    FilterGames selectedGames,
    String errorMessage,
  }) {
    return TrainingManagerState(
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

  TrainingManagerState update({
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

  TrainingManagerState copyWith({
    List<Word> filteredWords,
    bool isEmptyCardWord,
    List<Collection> collections,
    List<Collection> selectedCollections,
    List<int> selectedDifficulties,
    FilterGames selectedGames,
    bool isFailure,
    String errorMessage,
  }) {
    return TrainingManagerState(
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
