import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/config/size_config.dart';
import 'package:words_app/repositories/repositories.dart';

import 'widgets.dart';

class AnswerContainer extends StatefulWidget {
  AnswerContainer(
      {Key key, this.successColorAnimation, this.errorColorAnimation})
      : super(key: key);
  final Animation<dynamic> successColorAnimation;
  final Animation<dynamic> errorColorAnimation;
  @override
  _AnswerContainerState createState() => _AnswerContainerState();
}

class _AnswerContainerState extends State<AnswerContainer> {
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context);

    return SingleChildScrollView(
      child: Container(
        height: defaultSize * 15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: defaultSize * 20),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 2,
                  spacing: 2,
                  direction: Axis.horizontal,
                  children: providerData.answerWordArray.map((item) {
                    return Visibility(
                      child: GestureDetector(
                        onTap: providerData.dynamicColor == DynamicColor.wrong
                            ? () {}
                            : () {
                                setState(() {
                                  providerData.returnLetters(item);
                                });
                              },
                        child: BrickContainer(
                          letter: item,
                          color: providerData.setUpColor(
                              widget.successColorAnimation,
                              widget.errorColorAnimation),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
