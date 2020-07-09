class WordsData {
  WordsData({
    this.mainWordTitle,
    this.secondWordTitle,
    this.translationTitle,
    this.mainWordTitlePicture,
    this.secondWordTitlePicture,
    this.translationTitlePicture,
    this.id,
    this.wordCardPicture,
  });

  int id;
  String wordCardPicture;
  String mainWordTitle;
  String secondWordTitle;
  String translationTitle;
  bool checkMainWordTitle = true;
  bool checkSecondWordTitle = true;
  bool checkTranslationTitle = true;
  bool checkExampleTitle = true;
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
