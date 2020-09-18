import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/repositories/bricks_provider.dart';

List<Widget> buildAnswerContainer(
    setState, context, successColorAnimation, errorColorAnimation) {
  final providerData = Provider.of<Bricks>(context, listen: false);
  List<Widget> listWidget = [];
  for (int i = 0; i < providerData.answerWordArray.length; i++) {
    listWidget.add(Visibility(
      child: GestureDetector(
        onTap: providerData.dynamicColor == DynamicColor.wrong
            ? () {}
            : () {
                setState(() {
                  providerData.returnLetters(providerData.answerWordArray[i]);
                });
              },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [kBoxShadow],
              color: providerData.setUpColor(
                  successColorAnimation, errorColorAnimation)),
          alignment: Alignment.center,
          width: 41,
          height: 42,
          child: Text(
            providerData.answerWordArray[i],
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    ));
  }
  return listWidget;
}
