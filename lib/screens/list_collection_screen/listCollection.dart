import 'package:flutter/material.dart';
import 'package:words_app/components/box_collection.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/collections_manager/collections_manager.dart';
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
    // CollectionData(collectionNameTitle: "Hellow World")
  ];

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
          height: 120.0,
          color: kMainColorBlue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.grey[800].withOpacity(0.1),
                alignment: Alignment.center,
                height: 50.0,
                width: 200.0,
                child: ListView(
                  itemExtent: 200,
                  scrollDirection: Axis.horizontal,
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
          padding: EdgeInsets.all(20.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return BoxCollection(
                      textTitle: boxCollectionData[index].collectionNameTitle,
                      isChecked: boxCollectionData[index].isChecked,
                      deleteColection: () {
                        setState(() {
                          boxCollectionData.remove(boxCollectionData[index]);
                        });
                      },
                      onTap: () {
                        setState(() {
                          boxCollectionData[index].toggleIsChecked();
                        });
                      },
                      onSubmite: (value) {
                        setState(() {
                          boxCollectionData[index].changeCollectionName(value);
                          boxCollectionData[index].toggleIsChecked();
                        });
                      });
                }, childCount: boxCollectionData.length),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
