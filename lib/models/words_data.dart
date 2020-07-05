class WordsData {
  WordsData({
    this.mainWordTitle,
    this.secondWordTitle,
    this.translationTitle,
    checkMainWordTitle,
    checkSecondWordTitle,
  });

  String mainWordTitle;
  String secondWordTitle;
  String translationTitle;
  bool checkMainWordTitle = true;
  bool checkSecondWordTitle = true;
  bool checkTranslationTitle = true;

  void toggleMainWords() {
    checkMainWordTitle = !checkMainWordTitle;
  }

  void toggleSecondWords() {
    checkSecondWordTitle = !checkSecondWordTitle;
  }

  void toggleTranslations() {
    checkTranslationTitle = !checkTranslationTitle;
  }

  void changeMainWordTitle(String newName) {
    mainWordTitle = newName;
  }

  void changeSecondWordTitle(String newName) {
    secondWordTitle = newName;
  }

  void changeTranslationTitle(String newName) {
    translationTitle = newName;
  }
}
