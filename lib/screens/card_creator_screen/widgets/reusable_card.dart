import 'package:flutter/material.dart';
import 'package:words_app/config/size_config.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key key,
    this.child,
    this.color,
  }) : super(key: key);
  final Color color;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 95,
          height: SizeConfig.blockSizeVertical * 56,
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
          width: SizeConfig.blockSizeHorizontal * 95,
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
