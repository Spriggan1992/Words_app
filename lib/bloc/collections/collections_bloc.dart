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
    } else if (event is CollectionsUpdated) {
      yield* _mapCollectionsUpdatedToState(event);
    } else if (event is CollectionsDeleted) {
      yield* _mapCollectionsDeletedToState(event);
    } else if (event is CollectionsCurrent) {
      yield* _mapCollectionsGetCurrentToState();
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

  Stream<CollectionsState> _mapCollectionsGetCurrentToState() async* {
    final collections = (state as CollectionsSuccess).collections;
    yield CollectionsSuccess(collections);
  }

  Stream<CollectionsState> _mapCollectionsAddedToState(
      CollectionsAdded event) async* {
    try {} catch (_) {}
  }

  Stream<CollectionsState> _mapCollectionsUpdatedToState(
      CollectionsUpdated event) async* {
    try {} catch (_) {}
  }

  Stream<CollectionsState> _mapCollectionsDeletedToState(
      CollectionsDeleted event) async* {
    try {} catch (_) {}
  }
}
