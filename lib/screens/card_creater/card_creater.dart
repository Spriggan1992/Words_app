import 'package:flutter/material.dart';

class CardCreater extends StatelessWidget {
  static String id = 'card_creater';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: RaisedButton(
                disabledColor: Colors.white,
                shape: CircleBorder(),
                onPressed: null,
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
