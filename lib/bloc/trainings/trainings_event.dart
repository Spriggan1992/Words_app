part of 'trainings_bloc.dart';

abstract class TrainingsEvent extends Equatable {
  const TrainingsEvent();

  @override
  List<Object> get props => [];
}

class TrainingsLoaded extends TrainingsEvent {
  final List<Word> words;
  final String collectionId;

  TrainingsLoaded({this.words = const [], this.collectionId = ''});

  List<Object> get props => [words, collectionId];
}

// class TrainingsFiltered extends TrainingsEvent {
//   final List<int> selectedDifficulties;
//   final List<Collection> selectedCollections;

//   // final int difficulty;

//   TrainingsFiltered({this.selectedDifficulties, this.selectedCollections});
//   @override
//   List<Object> get props => [selectedCollections, selectedDifficulties];
// }

// class TrainingsUpdatedSelectedGames extends TrainingsEvent {
//   final FilterGames selectedGames;

//   TrainingsUpdatedSelectedGames({this.selectedGames});

//   @override
//   List<Object> get props => [selectedGames];
// }

// class TrainingsAddRemoveCollectionFilter extends TrainingsEvent {
//   final bool isCollection;
//   final Collection collection;

//   TrainingsAddRemoveCollectionFilter({this.isCollection, this.collection});

//   @override
//   List<Object> get props => [isCollection, collection];
// }

class TrainingsSelectedCollections extends TrainingsEvent {
  final bool isCollection;
  final Collection collection;

  TrainingsSelectedCollections({this.isCollection, this.collection});

  @override
  List<Object> get props => [isCollection, collection];
}

class TrainingsFiltered extends TrainingsEvent {}

class TrainingsSelectedGames extends TrainingsEvent {
  final FilterGames selectedGame;

  TrainingsSelectedGames({this.selectedGame});

  @override
  List<Object> get props => [selectedGame];
}

class TrainingsUpdatedDifficulties extends TrainingsEvent {
  final int difficulty;

  TrainingsUpdatedDifficulties({this.difficulty});

  @override
  List<Object> get props => [difficulty];
}

class TrainingsSubmitted extends TrainingsEvent {}
