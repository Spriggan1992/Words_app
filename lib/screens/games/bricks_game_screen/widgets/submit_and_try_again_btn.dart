import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/repositories/repositories.dart';

class SubmitAndTryAgainBtn extends StatelessWidget {
  const SubmitAndTryAgainBtn({
    Key key,
    this.shakeBtnAnimation,
    this.successAnimationController,
    this.errorAnimationController,
    this.slideTransitionController,
    this.shakeController,
  }) : super(key: key);

  final Animation<double> shakeBtnAnimation;

  final AnimationController successAnimationController;
  final AnimationController errorAnimationController;
  final AnimationController slideTransitionController;
  final AnimationController shakeController;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Bricks>(context, listen: false);
    return AnimatedBuilder(
      animation: shakeBtnAnimation,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.only(
              left: shakeBtnAnimation.value + 20.0,
              right: 20.0 - shakeBtnAnimation.value),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Theme.of(context).accentColor,
            elevation: 5,
            onPressed: () {
              providerData.activateSubmitBtn(
                  successAnimationController,
                  errorAnimationController,
                  slideTransitionController,
                  shakeController,
                  context);
            },
            child: Text(providerData.dynamicColor == DynamicColor.wrong
                ? 'Try Again'
                : 'Submit'),
          ),
        );
      },
    );
  }
}
