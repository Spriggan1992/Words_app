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

class TrainingsDifficultiesFilter extends TrainingsEvent {
  final FilterFavorites filterFavorites;
  final int difficultyFilter;
  // final FilterFavorites selectedFavorites;

  TrainingsDifficultiesFilter({this.difficultyFilter, this.filterFavorites});
  @override
  List<Object> get props => [difficultyFilter, filterFavorites];
}

class TrainingsFavoritesFilter extends TrainingsEvent {
  final FilterFavorites filterFavorites;
  final int difficultyFilter;

  TrainingsFavoritesFilter({this.filterFavorites, this.difficultyFilter});
  @override
  List<Object> get props => [filterFavorites, difficultyFilter];
}

class TrainingsToggleFilters extends TrainingsEvent {
  final int difficulty;
  final FilterFavorites favorites;

  TrainingsToggleFilters({this.favorites, this.difficulty});
  @override
  List<Object> get props => [difficulty, favorites];
}

class TrainingsToggleFavoritesBtns extends TrainingsEvent {
  final FilterFavorites favorites;

  TrainingsToggleFavoritesBtns({this.favorites});
  @override
  List<Object> get props => [favorites];
}

class TrainingsGoToTraining extends TrainingsEvent {
  TrainingsGoToTraining();
  @override
  List<Object> get props => [];
}
