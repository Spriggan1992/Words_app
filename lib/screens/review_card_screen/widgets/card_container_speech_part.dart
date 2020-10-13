import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';

class SpeechPart extends StatelessWidget {
  const SpeechPart({
    Key key,
    @required this.defaultSize,
    @required this.part,
  }) : super(key: key);

  final double defaultSize;
  final Color part;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -1,
      child: Container(
        width: SizeConfig.blockSizeHorizontal * 65.6,
        height: defaultSize * 1.2,
        decoration: BoxDecoration(
          color: part,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultSize * 1),
            topRight: Radius.circular(defaultSize * 1),
          ),
        ),
      ),
    );
  }
}
