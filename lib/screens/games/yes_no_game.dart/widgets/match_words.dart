import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'widgets.dart';

class MatchWords extends StatelessWidget {
  const MatchWords({
    Key key,
    this.state,
  }) : super(key: key);

  final YesNoGameSuccess state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: matchWords(state, defaultSize),
      ),
    );
  }
}

List matchWords(YesNoGameSuccess state, double defaultSize) {
  var matches = state.ownLang.map(
    (item) {
      // print('ownLang: ${item.id} + ${item.ownLang}');
      return Positioned(
        top: SizeConfig.blockSizeVertical * 47,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.1,
                  offset: Offset(1.5, 1.5),
                  color: Colors.grey,
                  spreadRadius: 0.1)
            ],
            borderRadius: BorderRadius.circular(defaultSize * 0.5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          height: defaultSize * 4.0,
          width: defaultSize * 25.0,
          child: YesNoTextHolder(title: item.ownLang),
        ),
      );
    },
  ).toList();

  return matches;
}
