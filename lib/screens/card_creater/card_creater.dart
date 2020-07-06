import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/constnts/constants.dart';

class CardCreater extends StatelessWidget {
  static String id = 'card_creater';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kSecondColorPink,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 60.0,
          color: kMainColorBlue,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: 90,
                  height: 55,
                  padding: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  )),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 200,
                        color: Colors.grey[300],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child:
                            IconButton(icon: Icon(Icons.add), onPressed: null),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Fields(title: 'First Word'),
                        Fields(title: 'Second Word'),
                        Fields(title: 'Translation'),
                      ],
                    ),
                  ),
                  // SizedBox(height: 80.0),
                  ReusableLogingRegestrationButtons(
                      titleText: 'Add',
                      onPressed: null,
                      titleColor: kMainColorBlue,
                      backgroundColor: Colors.white),
                ],
              )),
        ),
      ),
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 30,
              child: Text(title),
            ),
          ),
          Container(
            width: 220,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(top: 5, right: 10)),
            ),
          ),
        ],
      ),
    );
  }
}
