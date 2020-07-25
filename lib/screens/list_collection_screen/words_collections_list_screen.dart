import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/list_collection_screen/components/body.dart';

import 'components/btns.dart';

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
        floatingActionButton: ReusableFloatActionButton(onPressed: () {
          showGeneralDialog(
            barrierColor: Color(0xFFb48484).withOpacity(0.9),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    content: Container(
                        height: 300,
                        width: 310,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // Done btn
                                Btns(
                                  padding: 5.0,
                                  backgroundColor: Colors.grey[100],
                                  icon: Icons.done,
                                  color: Colors.green[400],
                                  onPress: null,
                                ),
                                SizedBox(width: 5.0),
                                // Close btn
                                Btns(
                                    padding: 5.0,
                                    backgroundColor: Colors.grey[100],
                                    icon: Icons.close,
                                    color: Colors.red[400],
                                    onPress: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                            Spacer(),
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Collection name',
                                enabledBorder: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                                decoration: InputDecoration(
                              labelText: 'Language',
                              enabledBorder: OutlineInputBorder(),
                            ))
                          ],
                        )),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            // ignore: missing_return
            pageBuilder: (context, animation1, animation2) {},
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
}
