import 'package:flutter/cupertino.dart';
import 'package:words_app/providers/game_card_data.dart';
import 'package:words_app/utils/db_helper.dart';

class GameCards extends ChangeNotifier {
  List<GameCard> _pairGameList = [];

  List<GameCard> get pairGameList {
    return [..._pairGameList];
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

  void gameStart() {
    while (_pairGameList.isNotEmpty) {}
    notifyListeners();
  }
}

class Card {
  String id;
  String word;
  bool isToggled;
}
