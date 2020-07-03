import 'package:flutter/material.dart';
import 'components/box_collection.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/manager_collection/manager_collection.dart';
import 'package:words_app/screens/create_box_collection_screen/create_box_collection_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/models/provier_data.dart';
import 'package:provider/provider.dart';

class ListCollection extends StatelessWidget {
  static String id = 'ListCollection';

  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return Scaffold(
        backgroundColor: Color(0xFFade4ff),
        floatingActionButton: ReusableFloatActionButton(onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CreateBoxCollections(),
          );
        }),

        //Footer
        bottomNavigationBar: BottomAppBar(
          // color: Color(0xFFade4ff),

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
                  child: PageView(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, CollectionManager.id),
                        child: Text('Treining',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                      ),
                      FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, LoginScreen.id),
                        child: Text('Loging',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                      ),
                      FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, RegistrationScreen.id),
                        child: Text('Registration',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: SafeArea(
          child: Container(
            decoration: kListCollectionBackground,
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
                          Navigator.pushNamed(context, CollectionManager.id);
                        },
                        onSubmite: (value) {
                          providerData.handleSubmitText(
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
