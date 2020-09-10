part of 'trainings_bloc.dart';

abstract class TrainingsEvent extends Equatable {
  const TrainingsEvent();

  @override
  List<Object> get props => [];
}

class TrainingsLoaded extends TrainingsEvent {
  final List<Word> words;
  final String collectionId;

  TrainingsLoaded({this.words, this.collectionId});
  List<Object> get props => [words, collectionId];
}

class TrainingsFiltered extends TrainingsEvent {
  final List<int> selectedDifficulties;
  final List<Collection> selectedListCollections;

  // final int difficulty;

  TrainingsFiltered({this.selectedDifficulties, this.selectedListCollections});
  @override
  List<Object> get props => [selectedListCollections, selectedDifficulties];
}

class TrainingsSelectCollections extends TrainingsEvent {
  final List<Collection> collection;

  TrainingsSelectCollections({this.collection});

  @override
  List<Object> get props => [collection];
}
