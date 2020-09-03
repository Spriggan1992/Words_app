import 'difficulty.dart';
import 'enums.dart';

class TrainingManagerModel {
  final Games games;
  final List<Difficulty> difficulty;
  final FilterFavorites favorites;
  final dynamic chooseColection;

  TrainingManagerModel(
      {this.games, this.difficulty, this.favorites, this.chooseColection});
}

class TrainingManager {
  List<TrainingManagerModel> trainingManager = [
    TrainingManagerModel(
        games: Games.bricks,
        difficulty: DifficultyList().difficultyList,
        favorites: FilterFavorites.favorites,
        chooseColection: null)
  ];
}
