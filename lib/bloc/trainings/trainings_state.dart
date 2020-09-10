part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  final List<Word> words;
  final List<Word> filteredListWords;

  final List<Collection> listCollections;
  final List<Collection> filteredListCollections;

  TrainingsSuccess({
    this.words,
    this.filteredListWords = const [],
    this.listCollections,
    this.filteredListCollections,
  });
  @override
  List<Object> get props => [
        words,
        filteredListWords,
        listCollections,
        filteredListCollections,
      ];
}

class TrainingsFailure extends TrainingsState {}
