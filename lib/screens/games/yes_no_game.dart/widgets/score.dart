import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'widgets.dart';

class Score extends StatelessWidget {
  const Score({
    Key key,
    this.state,
  }) : super(key: key);

  final YesNoGameSuccess state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: defaultSize * 2),
        height: defaultSize * 7,
        width: SizeConfig.blockSizeHorizontal * 90,
        decoration: innerShadow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(3, (index) {
              return YesNoTextHolder(
                  title: [state.wrong, ' : ', state.correct][index].toString(),
                  fontSize: defaultSize * 3,
                  color: [
                    Theme.of(context).accentColor,
                    Colors.black,
                    Colors.green
                  ][index]);
            }),
          ],
        ),
      ),
    );
  }
}
