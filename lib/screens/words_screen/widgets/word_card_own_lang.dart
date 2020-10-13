import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

class OwnLang extends StatelessWidget {
  final bool isExpanded;
  final Word word;
  const OwnLang({Key key, this.isExpanded, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: AnimatedPositioned(
        curve: Curves.easeIn,
        left: isExpanded ? defaultSize * 3.7 : defaultSize * 6.0,
        top: defaultSize * 5.3,
        duration: Duration(milliseconds: 300),
        child: Container(
          height: defaultSize * 3,
          width: isExpanded ? defaultSize * 32 : defaultSize * 30,
          child: AutoSizeText(
            word.ownLang ?? '',
            maxLines: 2,
            style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                  TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: defaultSize * 1.6,
                    fontFamily: 'italic',
                    fontStyle: FontStyle.italic,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
