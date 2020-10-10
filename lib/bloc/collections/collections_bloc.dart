import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:words_app/models/collection.dart';
import 'package:words_app/repositories/collections/collections_repository.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  CollectionsBloc({this.collectionsRepository}) : super(CollectionsLoading());

  final CollectionsRepository collectionsRepository;

  @override
  Stream<CollectionsState> mapEventToState(
    CollectionsEvent event,
  ) async* {
    if (event is CollectionsLoaded) {
      yield* _mapCollectionsLoadedToState();
    } else if (event is CollectionsToggleAll) {
      yield* _mapCollectionsToggleAllToState(event);
    } else if (event is CollectionsSetToFalse) {
      yield* _mapCollectionsSetToFalseAllToState(event);
    } else if (event is CollectionsUpdated) {
      yield* _mapCollectionsUpdateToState(event);
    } else if (event is CollectionsDeleted) {
      yield* _mapCollectionsDeletedToState(event);
    } else if (event is CollectionsAdded) {
      yield* _mapCollectionsAddedToState(event);
    }
  }

  /// This method is responsible for loading initial words from
  Stream<CollectionsState> _mapCollectionsLoadedToState() async* {
    try {
      List<Collection> collectionList = [];
      var collections = await collectionsRepository.fetchAndSetCollection();
      collections.forEach((collection) async {
        // final count = await collectionsRepository.getWordCount(collection.id);

        collectionList.add(Collection(
            id: collection.id,
            language: collection.language,
            title: collection.title,
            wordCount: collection.wordCount,
            isEditingBtns: collection.isEditingBtns));
      });
      yield CollectionsSuccess(collectionList);
    } catch (_) {
      yield CollectionsFailure();
    }
  }

  Stream<CollectionsState> _mapCollectionsToggleAllToState(
      CollectionsToggleAll event) async* {
    final allToggled = (state as CollectionsSuccess)
        .collections
        .every((collection) => collection.isEditingBtns);
    final updatedCollection = (state as CollectionsSuccess)
        .collections
        .map((collection) => collection.copyWith(isEditingBtns: !allToggled))
        .toList();
    yield CollectionsSuccess(updatedCollection);
  }

  Stream<CollectionsState> _mapCollectionsSetToFalseAllToState(
      CollectionsSetToFalse event) async* {
    final updatedCollection = (state as CollectionsSuccess)
        .collections
        .map((collection) => collection.copyWith(isEditingBtns: false))
        .toList();
    yield CollectionsSuccess(updatedCollection);
  }

  Stream<CollectionsState> _mapCollectionsAddedToState(
      CollectionsAdded event) async* {
    try {
      final collection = await collectionsRepository.addNewCollection(
          collection: event.collection);
      List<Collection> collections =
          List.from((state as CollectionsSuccess).collections)..add(collection);
      yield CollectionsSuccess(collections);
    } catch (_) {
      yield CollectionsFailure();
    }
  }

  Stream<CollectionsState> _mapCollectionsUpdateToState(
      CollectionsUpdated event) async* {
    try {
      final updatedCollections =
          (state as CollectionsSuccess).collections.map((collection) {
        return collection.id == event.id
            ? collection.copyWith(
                id: collection.id,
                isEditingBtns: collection.isEditingBtns,
                title: event.title,
                language: event.language,
              )
            : collection;
      }).toList();
      await collectionsRepository.updateCollection(data: {
        'id': event.id,
        'title': event.title,
        'language': event.language,
      });

      yield CollectionsSuccess(updatedCollections);
    } catch (_) {}
  }

  Stream<CollectionsState> _mapCollectionsDeletedToState(
      CollectionsDeleted event) async* {
    try {
      final updatedCollection = (state as CollectionsSuccess)
          .collections
          .where((collection) => collection.id != event.id)
          .toList();
      yield CollectionsSuccess(updatedCollection);

      collectionsRepository.deleteCollection(event.id);
    } catch (_) {
      yield CollectionsFailure();
    }
  }
}
