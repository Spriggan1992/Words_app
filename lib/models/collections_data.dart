class Collection {
  Collection({this.title, checkTextEdit});

  String title;
  bool checkTextEditing = true;
  bool checkFrontBack = false;

  void toggleCheckTextEditing() {
    checkTextEditing = !checkTextEditing;
  }

  void toggleCheckFrontBack() {
    checkFrontBack = !checkFrontBack;
  }

  void changeCollectionName(String newName) {
    title = newName;
  }
}
