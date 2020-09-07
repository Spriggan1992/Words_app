part of 'trainings_bloc.dart';

abstract class TrainingsEvent extends Equatable {
  const TrainingsEvent();

  @override
  List<Object> get props => [];
}

class TrainingsLoaded extends TrainingsEvent {
  final List<Word> words;

  TrainingsLoaded({this.words});
  List<Object> get props => [words];
}

class TrainingsFilteredDifficulties extends TrainingsEvent {
  final int difficulty;
  final int favorites;
  final FilterGames games;
  TrainingsFilteredDifficulties({this.difficulty, this.games, this.favorites});
  @override
  List<Object> get props => [difficulty, games, favorites];
}

class TrainingsFilteredFavorites extends TrainingsEvent {
  final int difficulty;
  final int favorites;
  final FilterGames games;
  TrainingsFilteredFavorites({this.favorites, this.games, this.difficulty});
  @override
  List<Object> get props => [favorites, games, difficulty];
}
// part of 'trainings_bloc.dart';

// abstract class TrainingsEvent extends Equatable {
//   const TrainingsEvent();

//   @override
//   List<Object> get props => [];
// }

// class TrainingsLoaded extends TrainingsEvent {
//   final List<Word> words;

//   TrainingsLoaded({this.words});
//   List<Object> get props => [words];
// }

// class TrainingsDifficultiesFilter extends TrainingsEvent {
//   final FilterFavorites filterFavorites;
//   final int difficultyFilter;

//   // final FilterFavorites selectedFavorites;

//   TrainingsDifficultiesFilter({this.difficultyFilter, this.filterFavorites});
//   @override
//   List<Object> get props => [difficultyFilter, filterFavorites];
// }

// class TrainingsToggleFilters extends TrainingsEvent {
//   final int difficulty;
//   final FilterFavorites favorites;
//   final FilterGames games;
//   TrainingsToggleFilters({this.favorites, this.difficulty, this.games});
//   @override
//   List<Object> get props => [difficulty, favorites, games];
// }

// class TrainingsGoToTraining extends TrainingsEvent {
//   final int difficulty;
//   final FilterFavorites favorites;
//   final FilterGames games;
//   TrainingsGoToTraining({this.favorites, this.difficulty, this.games});
//   @override
//   List<Object> get props => [difficulty, favorites, games];
// }
