import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  ShakeAnimation({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  _ShakeAnimationState createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation rotateAnimation;

  static final tweenSequence = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 92)
  ]);

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    rotateAnimation = tweenSequence.animate(_controller);

    super.initState();
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotateAnimation,
      builder: (context, child) {
        return Transform.rotate(angle: rotateAnimation.value, child: child);
      },
      child: widget.child,
    );
  }
}
