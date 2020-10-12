import 'package:flutter/material.dart';

AnimationController errorAnimationController;
AnimationController successAnimationController;
AnimationController shakeController;
AnimationController slideTransitionController;

Animation<double> shakeBtnAnimation;
Animation errorColorAnimation;
Animation successColorAnimation;
Animation slideTransitionAnimation;

final tweenSequenceError = TweenSequence(<TweenSequenceItem<Color>>[
  TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.red, end: Colors.white), weight: 33),
  TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.white, end: Colors.red), weight: 33),
  TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.red, end: Colors.white), weight: 33),
]);

final tweenSequenceSuccess = TweenSequence(<TweenSequenceItem<Color>>[
  TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.green, end: Colors.white), weight: 33),
  TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.white, end: Colors.green), weight: 33),
  TweenSequenceItem<Color>(
      tween: ColorTween(begin: Colors.green, end: Colors.white), weight: 33),
]);
