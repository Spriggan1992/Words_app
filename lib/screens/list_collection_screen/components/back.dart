// Back side of WordsCollection
import 'package:flutter/material.dart';

import 'words_collection.dart';

class Back extends StatelessWidget {
  const Back({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final WordsCollection widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      key: ValueKey(2),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xFF878686),
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: Offset(1, 3))
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFF8B6b6), // Color Back container
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: widget.editingText, //Editing text
            child: Container(
              child: Icon(Icons.edit),
            ),
          ),
          GestureDetector(
            onTap: widget.deleteCollection,
            child: Container(
              child: Icon(Icons.delete_outline),
            ),
          ),
        ],
      ),
    );
  }
}
