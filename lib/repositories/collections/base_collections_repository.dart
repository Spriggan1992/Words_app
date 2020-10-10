import 'package:words_app/models/collection.dart';
import 'package:words_app/repositories/base_repository.dart';

abstract class BaseCollectionsRepository extends BaseRepository {
  Future<Collection> addNewCollection({Collection collection});

  Future<Collection> deleteCollection({Collection collection});

  Future<void> updateCollection({Map<String, Object> data});
}
