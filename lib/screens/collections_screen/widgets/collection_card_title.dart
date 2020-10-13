import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';

class CollectionCardTitle extends StatelessWidget {
  final String title;

  const CollectionCardTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: defaultSize * 1),
        alignment: Alignment.center,
        height: defaultSize * 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultSize * 1),
            topRight: Radius.circular(defaultSize * 1),
          ),
        ),
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.all(defaultSize * 1),
            child: Text(
              title ?? '',
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyText2
                  .merge(TextStyle(fontSize: defaultSize * 4)),
            ),
          ),
        ),
      ),
    );
  }
}
