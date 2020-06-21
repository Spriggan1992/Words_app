import 'package:flutter/material.dart';

class BoxCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10.0,
        height: 20.0,
        padding: EdgeInsets.only(bottom: 60.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xFF878686),
                blurRadius: 6.0,
                spreadRadius: 2.0,
                offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                color: Colors.white,
              ),
              child: Text('Title', style: TextStyle(fontSize: 25.0)),
            ),
          ],
        ));
  }
}
