import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/screens/screens.dart';

class NextAndGiveUpBtns extends StatefulWidget {
  const NextAndGiveUpBtns({
    Key key,
    this.slideTransitionController,
  }) : super(key: key);

  final AnimationController slideTransitionController;

  @override
  _NextAndGiveUpBtnsState createState() => _NextAndGiveUpBtnsState();
}

class _NextAndGiveUpBtnsState extends State<NextAndGiveUpBtns> {
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: providerData.dynamicColor == DynamicColor.wrong
                    ? () {}
                    : () {
                        setState(() {
                          providerData.giveUp();
                        });
                      },
                child: Text('GIVE UP',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    providerData
                        .runSlideAnimation(widget.slideTransitionController);
                  });

                  Future.delayed(const Duration(milliseconds: 230), () {
                    setState(() {
                      providerData.loadNextWord();
                      goToResultScreen(
                          providerData.initialData,
                          context,
                          ResultScreen(
                              correct: providerData.correct,
                              wrong: providerData.wrong));
                    });
                  });

                  providerData.dynamicColor = DynamicColor.normal;
                },
                child: Text('NEXT',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ));
  }
}
