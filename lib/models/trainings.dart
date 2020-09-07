import 'difficulty.dart';
import 'fuiltersEnums.dart';

class TrainingManagerModel {
  final FilterGames games;
  final List<Difficulty> difficulty;
  final FilterFavorites favorites;
  final dynamic chooseColection;

  TrainingManagerModel(
      {this.games, this.difficulty, this.favorites, this.chooseColection});
}

class TrainingManager {
  List<TrainingManagerModel> trainingManager = [
    TrainingManagerModel(
        games: FilterGames.bricks,
        difficulty: DifficultyList().difficultyList,
        favorites: FilterFavorites.favorites,
        chooseColection: null)
  ];
}
