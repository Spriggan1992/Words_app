import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';

import 'widgets.dart';

class Deck extends StatelessWidget {
  const Deck({
    Key key,
    this.correctController,
    this.wrongController,
    this.state,
  }) : super(key: key);

  final AnimationController correctController;
  final AnimationController wrongController;
  final YesNoGameSuccess state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
        child: Stack(
            alignment: Alignment.center,
            children: _deck(
              correctController,
              wrongController,
              state,
              context,
              defaultSize,
            )));
  }

  List<Widget> _deck(
    AnimationController correctController,
    AnimationController wrongController,
    YesNoGameSuccess state,
    BuildContext context,
    double defaultSize,
  ) {
    List<Widget> cardList = List();
    double topPadding = SizeConfig.blockSizeVertical * 10;
    double leftPadding = defaultSize * 10.5;

    for (int i = 0;
        i < (state.targetLang.length < 4 ? state.targetLang.length : 4);
        i++) {
      topPadding -= defaultSize * 0.35;
      leftPadding += defaultSize * 0.25;

      cardList.insert(
        0,
        Positioned(
          top: topPadding,
          left: leftPadding,
          child: Dismissible(
            direction: i == 0 ? DismissDirection.horizontal : null,
            onDismissed: (DismissDirection derection) {
              if (derection == DismissDirection.startToEnd) {
                if (state.targetLang.first.id == state.ownLang.last.id) {
                  context.bloc<YesNoGameBloc>().add(YesNoGameAnswerCorrect());
                  correctController.forward();
                } else {
                  context.bloc<YesNoGameBloc>().add(YesNoGameAnswerWrong());
                  wrongController.forward();
                }
                context
                    .bloc<YesNoGameBloc>()
                    .add(YesNoGameDeleteWords(word: state.targetLang[i]));

                goToResultScreen(state.targetLang, context,
                    ResultScreen(correct: state.correct, wrong: state.wrong));
              }
              if (derection == DismissDirection.endToStart) {
                if (state.targetLang.first.id == state.ownLang.last.id) {
                  context.bloc<YesNoGameBloc>().add(YesNoGameAnswerWrong());
                  wrongController.forward();
                } else {
                  context.bloc<YesNoGameBloc>().add(YesNoGameAnswerCorrect());
                  correctController.forward();
                }
                context
                    .bloc<YesNoGameBloc>()
                    .add(YesNoGameDeleteWords(word: state.targetLang[i]));
              }
            },
            key: UniqueKey(),
            child: Card(
              elevation: 3,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultSize * 0.5),
                      color: Colors.white,
                    ),
                    width: defaultSize * 20,
                    height: defaultSize * 25,
                  ),
                  Positioned(
                    top: defaultSize * 4,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(defaultSize * 0.5),
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      width: defaultSize * 16,
                      height: defaultSize * 3,
                      child: YesNoTextHolder(
                          title: state.targetLang[i].targetLang),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return cardList;
  }
}
