class WordsData {
  WordsData({
    this.word1,
    this.word2,
    this.translation,
    this.id,
    this.image,
  });

  int id;
  String image;
  String word1;
  String word2;
  String translation;
  bool checkMainWordTitle = true;
  bool checkSecondWordTitle = true;
  bool checkTranslationTitle = true;
  bool checkExampleTitle = true;
  bool checkShowPicture = true;

  void selectImages(int id) {
    image = 'images/$id.jpeg';
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
