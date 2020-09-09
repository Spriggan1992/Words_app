part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  final List<Word> words;
  final List<Word> filteredListWords;

  final int difficulty;
  final FilterGames filterGames;

  final List<Collection> listCollection;
  final List<Collection> filteredListCollection;

  TrainingsSuccess({
    this.words,
    this.filteredListWords = const [],
    this.difficulty = 3,
    this.filterGames = FilterGames.bricks,
    this.listCollection,
    this.filteredListCollection,
  });
  @override
  List<Object> get props => [
        words,
        filteredListWords,
        difficulty,
        filterGames,
        listCollection,
        filteredListCollection,
      ];
}

class TrainingsFailure extends TrainingsState {}
