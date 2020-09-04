part of 'trainings_bloc.dart';

abstract class TrainingsState extends Equatable {
  const TrainingsState();

  @override
  List<Object> get props => [];
}

class TrainingsLoading extends TrainingsState {}

class TrainingsSuccess extends TrainingsState {
  // final Games games;
  final List<Word> words;
  final List<Word> filterdList;
  final FilterFavorites filterFavorites;

  TrainingsSuccess({
    this.words,
    this.filterdList = const [],
    this.filterFavorites = FilterFavorites.all,
  });
  @override
  List<Object> get props => [words, filterdList, filterFavorites];
}

class TrainingsFailure extends TrainingsState {}
