import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class BaseBottomAppBar extends StatelessWidget {
  const BaseBottomAppBar({
    this.child1,
    this.child2,
    Key key,
  }) : super(key: key);
  final Widget child1;
  final Widget child2;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 60.0,
        color: Theme.of(context).bottomAppBarColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[child1, child2],
        ),
      ),
    );
  }
}
