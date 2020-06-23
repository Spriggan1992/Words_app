import 'package:flutter/material.dart';

class BoxCollection extends StatefulWidget {
  BoxCollection({this.textTitle, this.deleteColection});

  final String textTitle;
  final Function deleteColection;

  @override
  _BoxCollectionState createState() => _BoxCollectionState();
}

class _BoxCollectionState extends State<BoxCollection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.deleteColection,
      child: Container(
          width: 10.0,
          height: 20.0,
          padding: EdgeInsets.only(bottom: 60.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF878686),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(1, 0.5))
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
                  color: Color(0xFF498ba6),
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.textTitle,
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
