import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/create_box_collection_screen/create_box_collection_screen.dart';
import 'package:words_app/screens/list_collection_screen/components/body.dart';

class WordsCollectionsList extends StatelessWidget {
  static String id = 'list_collection';

  Widget build(BuildContext context) {
    // wrapped it with safe area, to get rid of white space under the BottomAppBar
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text('WordsCollectionList'),
          appBar: AppBar(),
        ),
        backgroundColor: kMainColorBackground,
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CreateBoxCollections(),
            );
          },
        ),
        //Footer AppBar
        // In this screen Bottom AppBar just take empty container, cause child1 and child2 cannot be emty(==null);
        bottomNavigationBar: BaseBottomAppBar(
          child1: Container(),
          child2: Container(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Body(),
      ),
    );
  }
}
