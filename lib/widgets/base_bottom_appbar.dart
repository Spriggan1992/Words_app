import 'package:flutter/material.dart';

import 'package:words_app/config/screenDefiner.dart';

import 'package:words_app/widgets/widgets.dart';

class BaseBottomAppbar extends StatelessWidget {
  const BaseBottomAppbar({
    Key key,
    this.add,
    this.screenDefiner,
    this.goToTrainings,
    this.trainingsWordCounter,
    this.goToCollection,
  }) : super(key: key);

  final Function add;
  final ScreenDefiner screenDefiner;
  final Function goToTrainings;
  final Function goToCollection;
  final String trainingsWordCounter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: AlignmentDirectional.center,
        overflow: Overflow.visible,
        children: [
          Container(
              child: Row(
            children: [
              SizedBox(width: 70),
              _buildHomeBtn(context, screenDefiner),
            ],
          )),
          Positioned(
              top: -15,
              child: screenDefiner == ScreenDefiner.reviewCard
                  ? SizedBox.shrink()
                  : MainButton(onTap: add)),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildTrainingBtn(context, goToTrainings, trainingsWordCounter),
              SizedBox(width: 70),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTrainingBtn(
    BuildContext context,
    Function goToTrainings,
    String trainingsWordCounter,
  ) {
    if (screenDefiner == ScreenDefiner.words ||
        screenDefiner == ScreenDefiner.reviewCard) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          ReusableIconBtn(
              onPress: goToTrainings,
              color: Theme.of(context).accentColor,
              icon: Icons.fitness_center),
          Positioned(
            right: 10.0,
            child: Text(trainingsWordCounter,
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
        ],
      );
    } else
      return ReusableIconBtn(
        color: Theme.of(context).accentColor,
        icon: Icons.fitness_center,
        onPress: goToTrainings,
      );
  }

  Widget _buildHomeBtn(BuildContext context, ScreenDefiner screenDefiner) {
    return ReusableIconBtn(
        color: Theme.of(context).accentColor,
        icon: Icons.home,
        onPress: screenDefiner == ScreenDefiner.collections
            ? null
            : () {
                goToCollection();
              });
  }
}
