class WordsData {
  WordsData(
      {this.mainWordTitle,
      this.secondWordTitle,
      this.translationTitle,
      checkWordsTextEdit});

  String mainWordTitle;
  String secondWordTitle;
  String translationTitle;
  bool checkMainWordTitle = true;
  bool checkSecondWordTitle = true;
  bool checkTranslationTitle = true;

  void toggleWordsCheckTextEdit() {
    checkMainWordTitle = !checkMainWordTitle;
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
