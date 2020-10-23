import 'package:words_app/repositories/repositories.dart';

abstract class BaseBricksRepository extends BaseRepository {
  Future<List<String>> addLetter(
      {List<String> answersListOfBricks, String letter});
}
