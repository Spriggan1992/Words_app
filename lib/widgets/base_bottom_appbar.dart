import 'package:flutter/material.dart';
import 'package:words_app/widgets/widgets.dart';

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
      // shape: CircularNotchedRectangle(),
      // clipBehavior: Clip.antiAlias,
      child: Container(
        height: 80,

        // color: Theme.of(context).bottomAppBarColor,
        color: Colors.white,
        // color: Colors.transparent,
        child: Row(
          // alignment: Alignment.bottomLeft,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableBottomIconBtn(
              color: Theme.of(context).accentColor,
              icons: Icons.arrow_back_ios,
              onPress: () {},
            ),
            ReusableBottomIconBtn(
              color: Theme.of(context).accentColor,
              icons: Icons.arrow_back_ios,
              onPress: () {},
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ReusableFloatActionButton(),
            ),
            ReusableBottomIconBtn(
              color: Colors.black,
              icons: Icons.home,
              onPress: () {},
            ),
            ReusableBottomIconBtn(
              color: Theme.of(context).accentColor,
              icons: Icons.fitness_center,
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
