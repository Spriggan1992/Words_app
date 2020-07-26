import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/list_collection_screen/components/body.dart';

import 'components/dialog_add_collection.dart';

class WordsCollectionsList extends StatelessWidget {
  static String id = 'list_collection';

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text('WordsCollectionList'),
          appBar: AppBar(),
        ),
        backgroundColor: kMainColorBackground,
        floatingActionButton: ReusableFloatActionButton(onPressed: () {
          buildShowGeneralDialog(
            context,
          );
        }),
        bottomNavigationBar: BaseBottomAppBar(
          child1: Container(),
          child2: Container(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Body(),
        ),
      ),
    );
  }

  Future buildShowGeneralDialog(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Color(0xFFb48484).withOpacity(0.9),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              content: StatefulBuilder(builder: (context, setState) {
                return DialogAddCollection();
              }),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      // ignore: missing_return
      pageBuilder: (context, animation1, animation2) {},
    );
  }
}
