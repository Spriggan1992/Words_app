import 'package:flutter/material.dart';
import 'components/box_collection.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/manager_collection/manager_collection.dart';
import 'package:words_app/screens/create_box_collection_screen/create_box_collection_screen.dart';
import 'package:words_app/models/provier_data.dart';
import 'package:provider/provider.dart';

class ListCollection extends StatelessWidget {
  static String id = 'ListCollection';

  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColorBlue,
          automaticallyImplyLeading: false,
          title: Text('Collections'),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: ReusableFloatActionButton(onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CreateBoxCollections(),
          );
        }),

        //Footer
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: Container(
            color: Colors.white,
            // decoration: kListCollectionBackground,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return BoxCollection(
                        textTitle: providerData
                            .boxCollectionData[index].collectionNameTitle,
                        isCheckedTextEdit:
                            providerData.boxCollectionData[index].checkTextEdit,
                        isCheckedOptionsMenu:
                            providerData.boxCollectionData[index].checkMenu,
                        chooseOptions: () {
                          providerData.chooseOptions(
                              providerData.boxCollectionData[index]);
                        },
                        editText: () {
                          providerData
                              .editText(providerData.boxCollectionData[index]);
                        },
                        deleteCollection: () {
                          providerData.deleteCollection(
                              providerData.boxCollectionData[index]);
                        },
                        goToManagerCollections: () {
                          Navigator.pushNamed(context, ManagerCollection.id);
                        },
                        onSubmite: (value) {
                          providerData.handleSubmitTextCollections(
                              value, providerData.boxCollectionData[index]);
                        });
                  }, childCount: providerData.boxCollectionData.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2.5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
