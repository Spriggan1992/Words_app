import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';

class TextHolder extends StatelessWidget {
  const TextHolder({
    Key key,
    @required this.titles,
  }) : super(key: key);

  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          2,
          (index) => Text(
            titles[index].toString(),
            style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                  TextStyle(
                    fontSize: defaultSize * 3,
                  ),
                ),
          ),
        )
      ],
    );
  }
}
