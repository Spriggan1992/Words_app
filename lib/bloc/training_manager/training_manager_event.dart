part of 'training_manager_bloc.dart';

abstract class TrainingManagerEvent extends Equatable {
  const TrainingManagerEvent();

  @override
  List<Object> get props => [];
}

class TrainingManagerLoaded extends TrainingManagerEvent {
  final List<Word> words;
  final String collectionId;

  TrainingManagerLoaded({this.words = const [], this.collectionId = ''});

  List<Object> get props => [words, collectionId];
}

class TrainingManagerSelectedCollections extends TrainingManagerEvent {
  final bool isCollection;
  final Collection collection;

  TrainingManagerSelectedCollections({this.isCollection, this.collection});

  @override
  List<Object> get props => [isCollection, collection];
}

class TrainingManagerFiltered extends TrainingManagerEvent {}

class TrainingManagerSelectedGames extends TrainingManagerEvent {
  final FilterGames selectedGame;

  TrainingManagerSelectedGames({this.selectedGame});

  @override
  List<Object> get props => [selectedGame];
}

class TrainingManagerUpdatedDifficulties extends TrainingManagerEvent {
  final int difficulty;

  TrainingManagerUpdatedDifficulties({this.difficulty});

  @override
  List<Object> get props => [difficulty];
}

class TrainingManagerSubmitted extends TrainingManagerEvent {}
