import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    @required this.size,
    this.child,
    this.color,
  }) : super(key: key);
  final Color color;
  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: size.width * 0.9,
          height: size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Color(0xff382F266D),
                offset: Offset(2.0, 2.0),
                blurRadius: 6.0,
              )
            ],
          ),
          child: child,
        ),
        Container(
          width: size.width * 0.9,
          height: 10,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              )),
        ),
      ],
    );
  }
}
