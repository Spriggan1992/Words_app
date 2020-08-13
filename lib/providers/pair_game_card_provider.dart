import 'package:flutter/material.dart';
import 'package:words_app/providers/game_card_data.dart';
import 'package:words_app/utils/db_helper.dart';

class GameCards extends ChangeNotifier {
  List<GameCard> _pairGameList = [];
  List<MyCard> _cards = [];

  List<GameCard> get pairGameList {
    return [..._pairGameList];
  }

  List<MyCard> get cards {
    return [..._cards];
  }

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

  void getNumberOfCards() {
    GameCard gameCard;
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

  GameCard getOneCard(int index) {
    GameCard gameCard = _pairGameList.removeAt(index);
//    print(_cards.length);
    return gameCard;
  }

  void toggleCard(int index) {
    _cards[index].toggleMyCard();
    notifyListeners();
  }
}

class MyCard {
  String id;
  String word;
  bool isToggled = false;

  MyCard({this.id, this.word});

  void toggleMyCard() {
    isToggled = !isToggled;
  }
}
