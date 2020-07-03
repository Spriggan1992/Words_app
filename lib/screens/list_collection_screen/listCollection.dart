import 'package:flutter/material.dart';
import 'package:words_app/components/box_collection.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/manager_collection/manager_collection.dart';
import 'package:words_app/screens/create_box_collection_screen/create_box_collection_screen.dart';
import 'package:words_app/modals/box_collection_data.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';

class ListCollection extends StatefulWidget {
  static String id = 'ListCollection';

  @override
  _ListCollectionState createState() => _ListCollectionState();
}

class _ListCollectionState extends State<ListCollection> {
  List<CollectionData> boxCollectionData = [
    CollectionData(collectionNameTitle: "Hellow World")
  ];

  void showPopupMenu() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        PopupMenuItem(
          child: Text("View"),
        ),
        PopupMenuItem(
          child: Text("Edit"),
        ),
        PopupMenuItem(
          child: Text("Delete"),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ReusableFloatActionButton(onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => CreateBoxCollections((textTitleCollection) {
                  setState(() {
                    boxCollectionData.add(CollectionData(
                        collectionNameTitle: textTitleCollection));
                    Navigator.pop(context);
                  });
                }));
      }),

      //Footer
      bottomNavigationBar: BottomAppBar(
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
                      textTitle: boxCollectionData[index].collectionNameTitle,
                      isCheckedTextEdit: boxCollectionData[index].checkTextEdit,
                      isCheckedOptionsMenu:
                          boxCollectionData[index].checkDropMenu,
                      chooseOptions: () {
                        setState(() {
                          boxCollectionData[index].toggleCheckDropMenu();
                        });
                      },
                      editText: () {
                        setState(() {
                          boxCollectionData[index].toggleCheckTextEdit();
                          boxCollectionData[index].toggleCheckDropMenu();
                        });
                      },
                      deleteCollection: () {
                        setState(() {
                          boxCollectionData.remove(boxCollectionData[index]);
                        });
                      },
                      onTap: () {
                        // setState(() {
                        //   boxCollectionData[index].toggleCheckTextEdit();
                        // });
                      },
                      onSubmite: (value) {
                        setState(() {
                          boxCollectionData[index].changeCollectionName(value);
                          boxCollectionData[index].toggleCheckTextEdit();
                        });
                      });
                }, childCount: boxCollectionData.length),
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
  }
}
