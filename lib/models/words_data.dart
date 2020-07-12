class WordsData {
  WordsData({
    this.word1,
    this.word2,
    this.translation,
    this.mainWordTitlePicture,
    this.secondWordTitlePicture,
    this.translationTitlePicture,
    this.id,
    this.wordCardPicture,
  });

  int id;
  String wordCardPicture;
  String word1;
  String word2;
  String translation;
  bool checkMainWordTitle = true;
  bool checkSecondWordTitle = true;
  bool checkTranslationTitle = true;
  bool checkExampleTitle = true;
  bool checkShowPicture = true;
  String mainWordTitlePicture;
  String secondWordTitlePicture;
  String translationTitlePicture;

  void choosePictureInProvider(int id) {
    if (id == 1) {
      wordCardPicture = mainWordTitlePicture;
    }
    if (id == 2) {
      wordCardPicture = secondWordTitlePicture;
    }
    if (id == 3) {
      wordCardPicture = translationTitlePicture;
    }
  }

  void toggleMainWords() {
    checkMainWordTitle = !checkMainWordTitle;
  }

  void toggleSecondWords() {
    checkSecondWordTitle = !checkSecondWordTitle;
  }

  void toggleTranslations() {
    checkTranslationTitle = !checkTranslationTitle;
  }

  void toggleShowPicture() {
    checkShowPicture = !checkShowPicture;
  }

  void changeMainWordTitle(String newName) {
    word1 = newName;
  }

  void changeSecondWordTitle(String newName) {
    word2 = newName;
  }

  void changeTranslationTitle(String newName) {
    translation = newName;
  }
}
