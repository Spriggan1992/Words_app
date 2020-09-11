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
  final List<Collection> selectedCollections;

  // final int difficulty;

  TrainingsFiltered({this.selectedDifficulties, this.selectedCollections});
  @override
  List<Object> get props => [selectedCollections, selectedDifficulties];
}

class TrainingsSelectCollections extends TrainingsEvent {
  final List<Collection> collections;

  TrainingsSelectCollections({this.collections});

  @override
  List<Object> get props => [collections];
}
