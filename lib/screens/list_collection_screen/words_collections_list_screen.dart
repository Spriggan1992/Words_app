import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'components/words_collection.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/manager_collection/collection_manager.dart';
import 'package:words_app/screens/create_box_collection_screen/create_box_collection_screen.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:provider/provider.dart';

class WordsCollectionsList extends StatelessWidget {
  static String id = 'list_collection';

  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      // wrapped it with safe area, to get rid of white space under the BottomAppBar
      return SafeArea(
        top: false,
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('WordsCollectionList'),
            appBar: AppBar(),
          ),
          backgroundColor: Colors.white,
          floatingActionButton: ReusableFloatActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => CreateBoxCollections(),
              );
            },
          ),

          //Footer AppBar
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60.0,
              color: kMainColorBlue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // color: Colors.grey[800].withOpacity(0.1),
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 200.0,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: SafeArea(
            child: Container(
              color: Colors.white,
              // decoration: kListCollectionBackground,
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
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
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
