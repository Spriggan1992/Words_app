part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  final List<Word> words;
  final List<Word> filterdList;
  final int filterFavorites;
  final int difficulty;
  final FilterGames filterGames;

  TrainingsSuccess({
    this.words,
    this.filterdList = const [],
    this.filterFavorites,
    this.difficulty = 3,
    this.filterGames = FilterGames.bricks,
  });
  @override
  List<Object> get props =>
      [words, filterdList, filterFavorites, difficulty, filterGames];
}

class TrainingsFailure extends TrainingsState {}
