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
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          // Provider data, here
          Consumer<Collections>(builder: (context, providerData, child) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                String handleSubmiteTitle;
                String handleSubmitLanguage;
                var wordsCollectionData =
                    providerData.wordsCollectionData[index];

                return WordsCollection(
                  index: index,
                  /* Takes value from TextField, and stored it in handleSubmiteText */
                  onSubmitTitleField: (value) {
                    handleSubmiteTitle = value;
                  },
                  onSubmitLanguageField: (value) {
                    handleSubmitLanguage = value;
                  },
                  // Save form
                  onSaveForm: () {
                    providerData.handleSubmitEditTitle(
                        handleSubmiteTitle, wordsCollectionData);

                    providerData.handleSubmitEditLangugeTitle(
                        handleSubmitLanguage, wordsCollectionData);

                    print(handleSubmitLanguage);
                    Navigator.pop(context);
                  },

                  // Remove collection from data
                  deleteCollection: () {
                    providerData.deleteCollection(wordsCollectionData);
                    Navigator.pop(context);
                  },

                  goToManagerCollections: () {
                    Navigator.pushNamed(context, CollectionManager.id);
                  },
                );
              }, childCount: providerData.wordsCollectionData.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 3,
              ),
            );
          })
        ],
      ),
    );
  }
}
