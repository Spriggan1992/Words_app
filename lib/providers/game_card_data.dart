class GameCard {
  final String id;
  final String targetLang;
  final String ownLang;
  bool isChosen = false;

  GameCard({this.ownLang, this.id, this.targetLang, this.isChosen});

  void choseCard() {
    isChosen = !isChosen;
  }
}
