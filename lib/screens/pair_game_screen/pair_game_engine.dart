import 'package:words_app/models/game_card.dart';
import 'package:words_app/repositories/pair_game_card_provider.dart';

class GameEngine {
  bool isFinished = false;
  final List<GameCard> gameCards;
  GameEngine({this.gameCards});

  List<MyCard> cards = [];

  List<void> printCards() {
//    print(cards[0].targetLang);
  }

  //TODO: method to draw number of cards from [cards];
  List<MyCard> getNumberOfCards() {
    GameCard gameCard;
    cards = [];
    for (int i = 0; i <= 1; i++) {
//      if (gameCards.isEmpty) {
//        return cards;
//      }
      print(gameCards.length);
      gameCard = getOneCard(0);

      cards.add(MyCard(id: gameCard.id, word: gameCard.targetLang));
      cards.add(MyCard(id: gameCard.id, word: gameCard.ownLang));
      print(gameCards.length);
    }
    print(cards.length);
    return cards;
  }

  GameCard getOneCard(int index) {
    GameCard gameCard = gameCards.removeAt(index);
    return gameCard;
  }

  //TODO: method to end the game
}
