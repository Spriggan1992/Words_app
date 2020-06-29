class CollectionData {
  CollectionData({this.collectionNameTitle, isChecked});

  String collectionNameTitle;
  bool checkTextEdit = true;
  bool checkDropMenu = false;

  void toggleCheckTextEdit() {
    checkTextEdit = !checkTextEdit;
  }

  void toggleCheckDropMenu() {
    checkDropMenu = !checkDropMenu;
  }

  void changeCollectionName(String newName) {
    collectionNameTitle = newName;
  }

  // void dropMenu (){
  //   return
  // }
}
