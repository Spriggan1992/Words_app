import 'package:flutter/material.dart';
import 'package:words_app/utils/size_config.dart';

class TitleTextHolder extends StatelessWidget {
  const TitleTextHolder({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Container(
        child: Text(title,
            style: TextStyle(
                fontSize: defaultSize * 2,
                color: Theme.of(context).accentColor)));
  }
}
