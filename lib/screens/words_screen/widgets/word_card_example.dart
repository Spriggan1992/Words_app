import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';

class Example extends StatelessWidget {
  final AnimationController expandController;
  final Word word;
  const Example({Key key, this.expandController, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: Positioned(
        left: defaultSize * 3.7,
        top: defaultSize * 12,
        child: ScaleTransition(
          scale: CurvedAnimation(
              parent: expandController, curve: Curves.fastOutSlowIn),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultSize * 0.5),
              color: Colors.white,
            ),
            width: defaultSize * 32,
            height: defaultSize * 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${word.example}\n${word.exampleTranslations}',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
