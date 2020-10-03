import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/collections/collections_repository.dart';

part 'collection_detail_event.dart';
part 'collection_detail_state.dart';

class CollectionDetailBloc
    extends Bloc<CollectionDetailEvent, CollectionDetailsState> {
  final CollectionsRepository _collectionsRepository;

  CollectionDetailBloc({@required CollectionsRepository collectionsRepository})
      : _collectionsRepository = collectionsRepository,
        super(CollectionDetailsState.empty());

  @override
  Stream<CollectionDetailsState> mapEventToState(
    CollectionDetailEvent event,
  ) async* {
    if (event is CollectionLoaded) {
      yield* _mapCollectionLoadedToState(event);
    } else if (event is CollectionTitleUpdated) {
      yield* _mapCollectionTitleUpdatedToState(event);
    } else if (event is CollectionLanguageUpdated) {
      yield* _mapCollectionLanguageUpdatedToState(event);
    } else if (event is CollectionDetailAdded) {
      yield* _mapCollectionAddedToState();
    }
  }

  Stream<CollectionDetailsState> _mapCollectionLoadedToState(
      CollectionLoaded event) async* {
    yield state.update(collection: event.collection);
  }

  Stream<CollectionDetailsState> _mapCollectionTitleUpdatedToState(
      CollectionTitleUpdated event) async* {
    if (state.collection == null) {
      final Collection collection = Collection(
        title: event.title,
        language: '',
      );
      yield state.update(collection: collection);
    } else {
      yield state.update(
          collection: state.collection.copyWith(title: event.title));
    }
  }

  Stream<CollectionDetailsState> _mapCollectionLanguageUpdatedToState(
      CollectionLanguageUpdated event) async* {
    if (state.collection == null) {
      final Collection collection = Collection(
        title: '',
        language: event.language,
      );
      yield state.update(collection: collection);
    } else {
      yield state.update(
          collection: state.collection.copyWith(language: event.language));
    }
  }

  Stream<CollectionDetailsState> _mapCollectionAddedToState() async* {
    // yield NoteDetailState.submitting(note: state.note);
    try {
      await _collectionsRepository.addNewCollection(
          collection: state.collection);
      yield CollectionDetailsState.success(collection: state.collection);
    } catch (e) {
      yield CollectionDetailsState.failure(
          collection: state.collection,
          errorMessage: 'New collection could not be added');
    }
    // after showing the error we want to show something so  we call state.update()
    yield state.update(
      isSubmiting: false,
      isFailure: false,
      isSuccess: false,
      errorMessage: '',
    );
  }
}
