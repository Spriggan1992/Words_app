import 'package:flutter/material.dart';
import 'package:words_app/components/box_collection.dart';
import 'package:words_app/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/create_box_collection_screen.dart';
import 'package:words_app/modals/box_collection_data.dart';

const bool a = true;

class ListCollection extends StatefulWidget {
  static String id = 'ListCollection';

  @override
  _ListCollectionState createState() => _ListCollectionState();
}

class _ListCollectionState extends State<ListCollection> {
  List boxCollectionData = [CollectionData(collectionNameTitle: 'WWWW')];

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
          color: Color(0xFF262d31),
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
                      onPressed: null,
                      child: Text('Treining',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.white)),
                    ),
                    FlatButton(
                      onPressed: null,
                      child: Text('Treining',
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
                    deleteColection: () {
                      setState(() {
                        boxCollectionData.remove(boxCollectionData[index]);
                      });
                    },
                  );
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

// boxCollectionData[index];
//

// List<Widget> boxCollectionData = [
//     BoxCollection(textTitle: 'Words dsadsa'),
//     BoxCollection(textTitle: 'Second words dsadsadas'),
