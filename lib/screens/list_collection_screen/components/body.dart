import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/screens/list_collection_screen/components/words_collection.dart';
import 'package:words_app/screens/manager_collection/collection_manager.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColorBackground,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
      child: CustomScrollView(
        slivers: <Widget>[
          // Provider data, here
          Consumer<Collections>(builder: (context, providerData, child) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                var wordsCollectionData =
                    providerData.wordsCollectionData[index];
                return WordsCollection(
                  // Name of Collections. Pass STRING collectionNameTitle from box_collection_data
                  collectionTitleName: wordsCollectionData.title,

                  /* Pass conditional  bool checkTextEditing from box_collection_data for check if
                  checkTextEditing = true {show Text field} if false {show Text('collectionTitleName')}
                  */
                  isCheckedTextEditing: wordsCollectionData.isEditing,

                  /* Pass conditional checkFrontBack containers. Check if bool checkFrontBack = true
                  {show Front container}, if false{show Back container}
                  */
                  isFront: wordsCollectionData.isFront,

                  // Just toggle bool checkFrontBack，thereby switching between Front and Backcontainers
                  chooseFrontBackContainers: () {
                    providerData.switchFrontBack(wordsCollectionData);
                  },

                  /* Here we just toggle isCheckedTextEditing and check if isCheckedTextEditing = true
                {show Text Field} if false {show Text(collectionTitleName)}
                */
                  editingText: () {
                    providerData.editText(wordsCollectionData);
                  },

                  /* Takes value from TextField, when we submitted value it change collectionTitleName */
                  onSubmit: (value) {
                    providerData.handleSubmitEditTitle(
                        value, wordsCollectionData);
                  },

                  // Remove collection from data
                  deleteCollection: () {
                    providerData.deleteCollection(wordsCollectionData);
                  },

                  goToManagerCollections: () {
                    Navigator.pushNamed(context, CollectionManager.id);
                  },
                );
              }, childCount: providerData.wordsCollectionData.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2.5,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
              ),
            );
          })
        ],
      ),
    );
  }
}
