class CollectionData {
  CollectionData({this.collectionNameTitle, isChecked});

  String collectionNameTitle;
  bool checkTextEdit = true;
  bool checkMenu = false;

  void toggleCheckTextEdit() {
    checkTextEdit = !checkTextEdit;
  }

  void toggleCheckMenu() {
    checkMenu = !checkMenu;
  }

  void changeCollectionName(String newName) {
    collectionNameTitle = newName;
  }

  // void dropMenu (){
  //   return
  // }
}
