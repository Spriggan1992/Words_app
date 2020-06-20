import 'package:flutter/material.dart';

class ListCollection extends StatelessWidget {
  static String id = 'ListCollection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          children: <Widget>[
            Container(
              color: Colors.black,
              width: 10.0,
              height: 10.0,
            ),
            Container(
              color: Colors.black,
              width: 10.0,
              height: 10.0,
            ),
            Container(
              color: Colors.black,
              width: 10.0,
              height: 10.0,
            ),
            Container(
              color: Colors.black,
              width: 10.0,
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
