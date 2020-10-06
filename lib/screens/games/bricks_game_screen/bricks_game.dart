import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/repositories/bricks_provider.dart';
import 'package:words_app/screens/result_screen/result_screen.dart';
import 'package:words_app/screens/training_manager_screen/training_manager_screen.dart';

import 'widgets/answer_container.dart';
import 'widgets/card_container.dart';
import 'widgets/next_and_give_up_btns.dart';
import 'widgets/submit_and_try_again_btn.dart';
import 'widgets/target_word_container.dart';
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

  void loadData() async {
    final providerData = Provider.of<Bricks>(context, listen: false);

    await providerData.setUpInitialData(widget.words);
    providerData.extractAndAssingData();
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Bricks>(context);
    return WillPopScope(
      onWillPop: () async {
        onBackPressed(
          context,
          () {
            setState(() {
              Navigator.pushNamedAndRemoveUntil(context, TrainingManager.id,
                  ModalRoute.withName(TrainingManager.id));
              providerData.initialData.clear();
              providerData.cleanData();
              providerData.resetWords();
              providerData.answerWordArray.clear();
              providerData.dynamicColor = DynamicColor.normal;
            });
          },
        );
        providerData.correct = 0;
        providerData.wrong = 0;
      },
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
                : SizedBox.shrink()),
      ),
    );
  }
}
