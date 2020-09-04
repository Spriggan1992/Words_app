part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  final List<Word> words;
  final List<Word> filterdList;
  final FilterFavorites filterFavorites;
  final int difficulty;

  TrainingsSuccess({
    this.words,
    this.filterdList = const [],
    this.filterFavorites = FilterFavorites.all,
    this.difficulty = 3,
  });
  @override
  List<Object> get props => [words, filterdList, filterFavorites, difficulty];
}

class TrainingsFailure extends TrainingsState {}
