import 'package:flutter/material.dart';
import 'package:words_app/config/size_config.dart';

class YesNoBtns extends StatelessWidget {
  const YesNoBtns({
    Key key,
    @required this.animationController,
    this.title,
    this.icon,
    this.top,
    this.left,
  }) : super(key: key);

  final Animation<Color> animationController;
  final String title;
  final IconData icon;
  final double top;
  final double left;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Positioned(
      top: top,
      left: left,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              icon,
              color: animationController.value,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: defaultSize * 2, color: animationController.value),
            ),
          ],
        ),
      ),
    );
  }
}
