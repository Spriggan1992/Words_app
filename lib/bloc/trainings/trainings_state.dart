part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  final List<Word> filteredWords;
  final bool isEmptyCardWord;
  final List<Collection> collections;
  final List<Collection> filteredCollections;
  final FilterGames selectedGames;

  TrainingsSuccess(
      {this.filteredWords = const [],
      this.collections = const [],
      this.filteredCollections = const [],
      this.isEmptyCardWord,
      this.selectedGames = FilterGames.bricks});
  @override
  List<Object> get props => [
        filteredWords,
        collections,
        filteredCollections,
        isEmptyCardWord,
        selectedGames
      ];
}

class TrainingsFailure extends TrainingsState {}
