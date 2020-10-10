import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    @required this.defaultSize,
    @required this.blockSizeHorizontal,
  }) : super(key: key);

  final double defaultSize;
  final double blockSizeHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: defaultSize * 5,
      width: blockSizeHorizontal * 43,
      child: Center(child: Text('word1')),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
//              color: Color(0xff382F266D),
              color: Theme.of(context).primaryColor,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ]),
    );
  }
}
