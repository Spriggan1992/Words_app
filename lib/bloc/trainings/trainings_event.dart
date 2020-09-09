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
  final FilterGames games;
  TrainingsFilteredDifficulties({this.difficulty, this.games});
  @override
  List<Object> get props => [difficulty, games];
}

class TrainingsFilteredFavorites extends TrainingsEvent {
  final int difficulty;
  final int favorites;
  final FilterGames games;
  TrainingsFilteredFavorites({this.favorites, this.games, this.difficulty});
  @override
  List<Object> get props => [favorites, games, difficulty];
}

class TrainingsSelectCollections extends TrainingsEvent {
  final List<Collection> collection;

  TrainingsSelectCollections({this.collection});

  @override
  List<Object> get props => [collection];
}
