import 'package:flutter/material.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/games/bricks_game_screen/bricks_game.dart';
import 'package:words_app/screens/games/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/screens.dart';

enum FilterGames { bricks, pair, wrongCorrect }

/// Return amount of filtered words when difficulties is chosen.
///
/// path:'/training_manager_screen'
String countWordsByDifficulty(
  List<Word> listWord,
  int difficulty,
  List<int> selectedDifficulties,
) {
  int counter = 0;
  for (int i = 0; i < listWord.length; i++) {
    if (selectedDifficulties.isEmpty) {
      counter = 0;
    } else {
      if (listWord[i].difficulty == difficulty) {
        counter++;
      } else {
        if (difficulty == 3) {
          counter = listWord.length;
        }
      }
    }
  }
  return counter.toString();
}

/// Navigate to games depending on which game is selected, collection and difficulty
void checkNavigation(
  List<Collection> selectedListCollections,
  TrainingsSuccess state,
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey,
  List<int> selectedDifficulties,
) {
  if (selectedListCollections.isEmpty) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'You have to choose which collection',
          ),
        )));
  } else if (selectedDifficulties.isEmpty) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'You have to choose which words you want to learn',
          ),
        )));
  } else if (state.filteredWords.isEmpty) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            selectedListCollections.length > 1
                ? 'There are no words in your collections'
                : 'There are no words in your collection',
          ),
        )));
  }

  if (state.selectedGames == FilterGames.bricks &&
      selectedDifficulties.isNotEmpty &&
      selectedListCollections.isNotEmpty &&
      state.filteredWords.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BricksGame(words: state.filteredWords),
        ));
  }
  if (state.selectedGames == FilterGames.wrongCorrect &&
      selectedDifficulties.isNotEmpty &&
      selectedListCollections.isNotEmpty &&
      state.filteredWords.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YesNoGame(
            words: state.filteredWords,
          ),
        ));
  }
  if (state.selectedGames == FilterGames.pair &&
      selectedDifficulties.isNotEmpty &&
      selectedListCollections.isNotEmpty &&
      state.filteredWords.isNotEmpty) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PairGame(
            words: state.filteredWords,
          ),
        ));
  }
}
