import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class TitleTextHolderContainer extends StatelessWidget {
  const TitleTextHolderContainer({
    Key key,
    @required this.defaultSize,
    @required this.wordHolder,
  }) : super(key: key);

  final double defaultSize;
  final String wordHolder;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: defaultSize * 25,
      height: defaultSize * 4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultSize),
        boxShadow: [kBoxShadow],
      ),
      child: Text(
        wordHolder,
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
