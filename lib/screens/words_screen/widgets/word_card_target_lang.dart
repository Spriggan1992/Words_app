import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

class TargetLang extends StatelessWidget {
  final bool isExpanded;
  final Word word;
  const TargetLang({Key key, this.isExpanded, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: AnimatedPositioned(
        curve: Curves.easeIn,
        left: isExpanded ? defaultSize * 3.7 : defaultSize * 6.0,
        top: defaultSize * 1.7,
        duration: Duration(milliseconds: 300),
        child: Container(
          height: defaultSize * 3,
          width: isExpanded ? defaultSize * 32 : defaultSize * 30,
          child: AutoSizeText(
            // TODO : difficulty problem
            "${word.targetLang}" ?? '',
            maxLines: 2, //Main word
            style: Theme.of(context).primaryTextTheme.bodyText2.merge(TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: defaultSize * 2,
                )),
          ),
        ),
      ),
    );
  }
}
