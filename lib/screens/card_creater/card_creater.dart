import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_main_button.dart';

class CardCreater extends StatelessWidget {
  static String id = 'card_creater';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      child: IconButton(icon: Icon(Icons.add), onPressed: null),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Fields(title: 'First Word'),
                      Fields(title: 'Second Word'),
                      Fields(title: 'Tranclstion'),
                    ],
                  ),
                ),
                ReusableLogingRegestrationButtons(
                    titleText: 'Add',
                    onPressed: null,
                    titleColor: Colors.black,
                    backgroundColor: Colors.grey),
              ],
            )),
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
              width: 50,
              child: Text(title),
            ),
          ),
          Container(
            width: 230,
            child: TextField(
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
