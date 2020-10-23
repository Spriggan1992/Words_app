import 'package:words_app/repositories/repositories.dart';

class BricksRepository extends BaseBricksRepository {
  @override
  Future<List<String>> addLetter(
      {List<String> answersListOfBricks, String letter}) async {
    List<String> newAnswersListOfBricks = [...answersListOfBricks];
    newAnswersListOfBricks.add(letter);
    return newAnswersListOfBricks;
  }

  @override
  void dispose() {}
}
