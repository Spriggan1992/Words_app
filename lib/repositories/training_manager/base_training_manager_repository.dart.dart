import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/models/models.dart';

import '../repositories.dart';

abstract class BaseTrainingManagerRepository extends BaseRepository {
  Future<Map<String, dynamic>> mapWordsToSelectedFilteredList(
      {TrainingManagerState state});
  Future<List<Word>> mapWordsList({TrainingManagerState state});
  Future<String> returnErrorMessage({TrainingManagerState state});
}
