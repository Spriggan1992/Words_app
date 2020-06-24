class CollectionData {
  CollectionData({this.collectionNameTitle, isChecked});

  String collectionNameTitle;
  bool isChecked = true;

  void toggleIsChecked() {
    isChecked = !isChecked;
  }

  void changeCollectionName(String newName) {
    collectionNameTitle = newName;
  }
}
