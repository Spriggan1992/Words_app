import 'package:flutter/material.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/screens/games/bricks_game_screen/bricks_game.dart';
import 'package:words_app/screens/games/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FilterGames { bricks, pair, yesNo }

final List<IconData> iconsList = [
  Icons.fitness_center,
  Icons.directions_bike,
  Icons.photo_album,
];

/// Return quntity of filtered words when difficulties is chosen.
///
/// path:'training_manager_screen'
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

bool checkState(TrainingManagerState state, FilterGames selectedGames) {
  if (state.selectedGames == selectedGames &&
      state.selectedDifficulties.isNotEmpty &&
      state.selectedCollections.isNotEmpty &&
      state.filteredWords.isNotEmpty) {
    return true;
  }
  return false;
}

/// Navigate to games depending on which game is selected, collection and difficulty
void checkNavigation(
  TrainingManagerState state,
  BuildContext context,
) {
  if (checkState(state, FilterGames.bricks))
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BricksGame(words: state.filteredWords),
        ));
  if (checkState(state, FilterGames.yesNo))
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => YesNoGame(
          words: state.filteredWords,
        ),
      ),
    );
  context.bloc<YesNoGameBloc>().add(YesNoGameLoaded());
  if (checkState(state, FilterGames.pair))
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PairGame(
            words: state.filteredWords,
          ),
        ));
}
