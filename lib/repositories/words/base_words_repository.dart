import 'package:words_app/models/models.dart';

import '../base_repository.dart';

abstract class BaseWordsRepository extends BaseRepository {
  Future<Word> addNewWord({Word word});
}
