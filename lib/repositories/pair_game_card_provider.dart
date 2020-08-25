import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:words_app/models/game_card.dart';

import 'package:words_app/utils/db_helper.dart';

class GameCards extends ChangeNotifier {
  List<GameCard> _pairGameList = [];
  List<MyCard> _cards = [];
  int toggleCount = 0;
  List<MyCard> chosenPair = [];
  int allDone = 0;

  List<GameCard> get pairGameList {
    return [..._pairGameList];
  }

  List<MyCard> get cards {
    return [..._cards];
  }

  /// method fetching data drom DB suing [collectionId]
  Future<void> fetchWordsFromDB(String collectionId) async {
    final dataList =
        await DBHelper.getData('words', collectionId: collectionId);

    _pairGameList = dataList.map((item) {
      GameCard gameCard = GameCard(
        id: item['id'],
        targetLang: item['targetLang'],
        ownLang: item['ownLang'],
      );
      return gameCard;
    }).toList();
    // prepare data for game, shuffle it a little bit
    _pairGameList.shuffle();
    notifyListeners();
  }

  void getCards() {
    GameCard gameCard;
    toggleCount = 0;
    _cards = [];
    for (int i = 0; i <= 3; i++) {
      try {
        gameCard = getOneCard(0);
        _cards.add(MyCard(id: gameCard.id, word: gameCard.targetLang));
        _cards.add(MyCard(id: gameCard.id, word: gameCard.ownLang));
      } catch (e) {
        print(e);
      }
    }
    notifyListeners();
  }

  void gameLoop() {}

  void toggleCard(int index) {
    chosenPair.add(_cards[index]);
    _cards[index].toggleMyCard();
    _cards[index].color = Colors.grey;
    if (chosenPair.length == 2) {
      if (chosenPair[0].id == chosenPair[1].id) {
        chosenPair[0].color = Colors.green;
        chosenPair[1].color = Colors.green;

        _cards.remove(chosenPair[0]);
        _cards.remove(chosenPair[1]);

        chosenPair = [];
        allDone = allDone + 2;
      }
    }

    if (_cards.isEmpty) {
      getCards();
      allDone = 0;
    }
    notifyListeners();
  }

  ///method removes item at given index from [_pairGameList] and return one GameCard
  GameCard getOneCard(int index) {
    GameCard gameCard = _pairGameList.removeAt(index);
    return gameCard;
  }
}
