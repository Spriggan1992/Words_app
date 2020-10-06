import 'package:words_app/models/models.dart';

import '../base_repository.dart';

abstract class BaseWordsRepository extends BaseRepository {
  Future<void> addNewWord({Word word});
  Future<List<Word>> fetchAndSetWords({String collectionId});
  Future<void> updateWord({Word word, String wordId});
  Future<bool> toggleIsEditMode(bool value);
  Future<void> removeWord(Word word);
  Future<void> removeSelectedWords();
}
