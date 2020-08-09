import 'package:flutter/material.dart';
import 'package:words_app/utils/size_config.dart';

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
    double defaultSize = SizeConfig.defaultSize;
    return Stack(
      children: <Widget>[
        Container(
//          width: defaultSize * 35.4,
//          height: defaultSize * 39.5,
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
          width: defaultSize * 35.4,
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
