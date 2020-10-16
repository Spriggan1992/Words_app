import 'package:words_app/models/word.dart';

import 'package:words_app/bloc/training_manager/training_manager_bloc.dart';

import '../repositories.dart';

class TrainingManagerRepository extends BaseTrainingManagerRepository {
  @override
  void dispose() {}

  @override
  Future<List<Word>> mapWordsList(
      {TrainingManagerState state, WordsRepository wordsRepository}) async {
    List<Word> selectedFilteredList = [];
    for (var i = 0; i < state.selectedCollections.length; i++) {
      List<Word> fetchedCollections = await wordsRepository.fetchAndSetWords(
          collectionId: state.selectedCollections[i].id);
      fetchedCollections.forEach((element) {
        selectedFilteredList.add(element);
      });
    }
    return selectedFilteredList;
  }

  @override
  Future<Map<String, dynamic>> mapWordsToSelectedFilteredList(
      {TrainingManagerState state, WordsRepository wordsRepository}) async {
    final List<Word> filteredList =
        await mapWordsList(state: state, wordsRepository: wordsRepository);
    final List<Word> updatedFilteredWordsList = [];
    bool updatedIsEmptyCardWord = false;
    for (var i = 0; i < state.selectedDifficulties.length; i++) {
      filteredList.forEach((word) {
        if (word.difficulty == state.selectedDifficulties[i]) {
          updatedFilteredWordsList.add(word);
          if (word.targetLang == null ||
              word.ownLang == null ||
              word.targetLang == '' ||
              word.ownLang == '') {
            updatedIsEmptyCardWord = true;
            updatedFilteredWordsList.remove(word);
          } else {
            updatedIsEmptyCardWord = false;
          }
        }
      });
    }

    updatedFilteredWordsList..shuffle();
    return {
      'updatedFilteredWordsList': updatedFilteredWordsList,
      'updatedIsEmptyCardWord': updatedIsEmptyCardWord
    };
  }

  @override
  Future<String> returnErrorMessage({TrainingManagerState state}) async {
    String error = '';
    if (state.selectedCollections.isEmpty) {
      return error = 'You have to choose which collection';
    }
    if (state.selectedDifficulties.isEmpty) {
      return error = 'You have to choose which words you want to learn';
    }
    if (state.filteredWords.isEmpty) {
      return error = 'There are no words';
    }
    return error;
  }
}
