// import 'package:words_app/models/game_card.dart';

// class GameEngine {
//   bool isFinished = false;
//   final List<GameCard> gameCards;
//   GameEngine({this.gameCards});

//   List<MyCard> cards = [];

//   /// method  draws number of cards from [cards];
//   List<MyCard> getNumberOfCards() {
//     GameCard gameCard;
//     cards = [];
//     for (int i = 0; i <= 1; i++) {
// //      if (gameCards.isEmpty) {
// //        return cards;
// //      }

//       gameCard = getOneCard(0);

//       cards.add(MyCard(id: gameCard.id, word: gameCard.targetLang));
//       cards.add(MyCard(id: gameCard.id, word: gameCard.ownLang));
//     }

//     return cards;
//   }

//   GameCard getOneCard(int index) {
//     GameCard gameCard = gameCards.removeAt(index);
//     return gameCard;
//   }
// }
