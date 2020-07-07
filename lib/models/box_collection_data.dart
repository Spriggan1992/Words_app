class CollectionData {
  CollectionData({this.collectionNameTitle, checkTextEdit});

  String collectionNameTitle;
  bool checkTextEditing = true;
  bool checkFrontBack = false;

  void toggleCheckTextEditing() {
    checkTextEditing = !checkTextEditing;
  }

  void toggleCheckFrontBack() {
    checkFrontBack = !checkFrontBack;
  }

  void changeCollectionName(String newName) {
    collectionNameTitle = newName;
  }
}
