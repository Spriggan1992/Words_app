import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/word.dart';
import '../../../repositories/bricks_provider.dart';
import 'components/answer_container.dart';
import 'components/card_container.dart';
import 'components/next_and_give_up_btns.dart';
import 'components/submit_and_try_again_btn.dart';
import 'components/target_word_container.dart';
import 'animation_utils.dart';

class BricksGame extends StatefulWidget {
  static String id = 'bricks_game';
  final List<Word> words;

  const BricksGame({Key key, this.words}) : super(key: key);

  @override
  _BricksGameState createState() => _BricksGameState();
}

class _BricksGameState extends State<BricksGame> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    loadData();

    errorAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    errorColorAnimation = tweenSequenceError.animate(errorAnimationController)
      ..addListener(() {
        setState(() {});
      });
    successAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    successColorAnimation =
        tweenSequenceSuccess.animate(successAnimationController)
          ..addListener(() {
            setState(() {});
          });

    shakeController =
        AnimationController(duration: Duration(milliseconds: 100), vsync: this);
    shakeBtnAnimation = Tween(begin: 0.0, end: 20.0)
        .chain(CurveTween(curve: Curves.bounceIn))
        .animate(shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              shakeController.reverse();
            }
          });
    slideTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    slideTransitionAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(2.0, 0.0))
            .animate(slideTransitionController)
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  slideTransitionController.reverse();
                }
              });
  }

  @override
  void dispose() {
    errorAnimationController.dispose();
    shakeController.dispose();
    slideTransitionController.dispose();
    successAnimationController.dispose();
    super.dispose();
  }

  void loadData() {
    final providerData = Provider.of<Bricks>(context, listen: false);
    providerData.setUpInitialData(widget.words);
    providerData.extractAndAssingData();
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Bricks>(context);
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: SafeArea(
            child: providerData.initialData.isNotEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // CardContainer
                        CardContainer(
                            slideTransitionAnimation: slideTransitionAnimation),

                        // AnswerContainer
                        AnswerContainer(
                            successColorAnimation: successColorAnimation,
                            errorColorAnimation: errorColorAnimation),

                        // TargetWordContainer
                        TargetWordContainer(),

                        // SubmitBtn
                        SubmitAndTryAgainBtn(
                            shakeBtnAnimation: shakeBtnAnimation,
                            successAnimationController:
                                successAnimationController,
                            errorAnimationController: errorAnimationController,
                            slideTransitionController:
                                slideTransitionController,
                            shakeController: shakeController),

                        // Help and Next btns
                        NextAndGiveUpBtns(
                            slideTransitionController:
                                slideTransitionController),
                      ],
                    ),
                  )
                : Center(child: Text('You run out of words'))),
      ),
    );
  }

  Future<bool> onBackPressed() {
    final providerData = Provider.of<Bricks>(context, listen: false);
    return showGeneralDialog(
        barrierColor: Color(0xff906c7a).withOpacity(0.9),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                    opacity: a1.value,
                    child: new AlertDialog(
                      title: new Text('Are you sure?'),
                      content: new Text('Do you want to finish your traning?'),
                      actions: <Widget>[
                        new GestureDetector(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Text("NO"),
                        ),
                        SizedBox(height: 16),
                        new GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop(true);
                              providerData.initialData.clear();
                              providerData.cleanData();
                              providerData.resetWords();
                              providerData.answerWordArray.clear();
                              providerData.dynamicColor = DynamicColor.normal;
                            });
                          },
                          child: Text("YES"),
                        ),
                      ],
                    ),
                  ) ??
                  false);
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return;
        });
  }
}
