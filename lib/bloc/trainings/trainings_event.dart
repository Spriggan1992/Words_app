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
