import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/widgets/widgets.dart';

import 'animation_utils.dart';
import 'widgets/widgets.dart';

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
        providerData.correct = 0;
        providerData.wrong = 0;
        providerData.backAndClearData(context);
        return;
      },
      child: Scaffold(
        appBar: BaseAppBar(
          screenDefiner: ScreenDefiner.bricks,
          appBar: AppBar(),
          title: Text('Bricks'),
          back: () => providerData.backAndClearData(context),
        ),
        body: providerData.initialData.isNotEmpty
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
                        successAnimationController: successAnimationController,
                        errorAnimationController: errorAnimationController,
                        slideTransitionController: slideTransitionController,
                        shakeController: shakeController),

                    // Help and Next btns
                    NextAndGiveUpBtns(
                        slideTransitionController: slideTransitionController),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
