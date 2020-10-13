import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

class SpeechPart extends StatelessWidget {
  final bool isExpanded;
  final Word word;
  const SpeechPart({Key key, this.isExpanded, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: Positioned(
        top: defaultSize * 2.2,
        left: defaultSize * 1.5,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: isExpanded ? defaultSize : defaultSize * 4,
          height: defaultSize * 8,
          child: Text(
            "${word.part.partName}",
            style: TextStyle(
              fontSize: word.part.partName.length > 1
                  ? defaultSize * 1.5
                  : defaultSize * 2.0,
              color: word.part.partColor,
            ),
          ),
        ),
      ),
    );
  }
}
