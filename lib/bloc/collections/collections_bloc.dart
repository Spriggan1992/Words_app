import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:words_app/models/collection.dart';
import 'package:words_app/repositories/collections_repository.dart';

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
    } else if (event is CollectionsAdded) {
      yield* _mapCollectionsAddedToState(event);
    } else if (event is CollectionsToggleAll) {
      yield* _mapCollectionsToggleAllToState(event);
    } else if (event is CollectionsDeleted) {
      yield* _mapCollectionsDeletedToState(event);
    }
  }

  Stream<CollectionsState> _mapCollectionsLoadedToState() async* {
    try {
      final collections = await collectionsRepository.fetchAndSetCollection();
      yield CollectionsSuccess(collections);
    } catch (_) {
      yield CollectionsFailure();
    }
  }

  Stream<CollectionsState> _mapCollectionsAddedToState(
      CollectionsAdded event) async* {
    try {
      final collection = await collectionsRepository.addNewCollection(
          event.title, event.language);
      List<Collection> collections =
          List.from((state as CollectionsSuccess).collections)..add(collection);
      yield CollectionsSuccess(collections);
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
