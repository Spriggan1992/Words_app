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
  final int difficultyFilter;

  TrainingsDifficultiesFilter({this.difficultyFilter});
  List<Object> get props => [difficultyFilter];
}

class TrainingsFavoritesFilter extends TrainingsEvent {
  final FavoritesBtns favourite;

  TrainingsFavoritesFilter({this.favourite});
  List<Object> get props => [favourite];
}
