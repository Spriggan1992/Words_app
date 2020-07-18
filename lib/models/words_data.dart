class WordsData {
  WordsData({
    this.word1,
    this.word2,
    this.translation,
    this.id,
    this.image,
    this.isEditingWord1 = true,
    this.isEditingWord2 = true,
    this.isEditingTranslationTitle = true,
    this.isCheckEdit = false,
  });
  bool isCheckEdit;
  int id;
  String image;
  String word1;
  String word2;
  String translation;
  bool isEditingWord1;
  bool isEditingWord2;
  bool isEditingTranslationTitle;
  bool isEditingExampleTitle = true;
  bool isEditingShowImg = true;

  void isChecked() {
    isCheckEdit = !isCheckEdit;
  }

  void selectImages(int id) {
    image = 'images/$id.jpeg';
  }

  void toggleWord1() {
    isEditingWord1 = !isEditingWord1;
  }

  void toggleWord2() {
    isEditingWord2 = !isEditingWord2;
  }

  void toggleTranslation() {
    isEditingTranslationTitle = !isEditingTranslationTitle;
  }

  void toggleShowImg() {
    isEditingShowImg = !isEditingShowImg;
  }

  void changeWord1Title(String newName) {
    // if (newName.isEmpty) {
    //   word1 = ' ';
    // } else
    word1 = newName;
  }

  void changeWord2Title(String newName) {
    word2 = newName;
  }

  void changeTranslationTitle(String newName) {
    translation = newName;
  }
}
