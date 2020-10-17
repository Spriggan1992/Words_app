import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

class SecondLang extends StatelessWidget {
  final bool isExpanded;
  final Word word;
  final Animation animation;
  const SecondLang({Key key, this.isExpanded, this.word, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Positioned(
      left: defaultSize * 3.7,
      top: defaultSize * 7.3,
      child: ScaleTransition(
        scale: animation,
        child: Container(
          width: isExpanded ? defaultSize * 32 : defaultSize * 30,
          height: defaultSize * 4,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              word.secondLang ?? '',
              style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                    TextStyle(
                      color: Colors.black54,
                      fontSize: defaultSize * 1.5,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
