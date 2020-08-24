import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';

import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/repositories/collections_provider.dart';

import 'components/body.dart';
import 'components/dialog_add_collection.dart';

/// [CollectionsScreen] responsible for showing all collections  created by user
/// it is separated into components for better modularity
class CollectionsScreen extends StatelessWidget {
  static String id = 'list_collection';

  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text('words_collection'),
          appBar: AppBar(),
        ),
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () {
            buildShowGeneralDialog(
              context,
            );
          },
        ),
        bottomNavigationBar: BaseBottomAppBar(
          child1: Container(),
          child2: Container(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: FutureBuilder(
          future: Provider.of<Collections>(context, listen: false)
              .fetchAndSetCollection(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Body(),
                    ),
        ),
      ),
    );
  }

  Future buildShowGeneralDialog(BuildContext context) {
    return showGeneralDialog(
      barrierColor: Color(0xff906c7a),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Color(0xffEAE2DA),
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
