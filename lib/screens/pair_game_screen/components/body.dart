import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_card.dart';
import 'package:words_app/constants/constants.dart';

import 'game_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.defaultSize,
    @required this.blockSizeVertical,
    @required this.blockSizeHorizontal,
  }) : super(key: key);

  final double defaultSize;
  final double blockSizeVertical;
  final double blockSizeHorizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: defaultSize * 1.6, vertical: defaultSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: blockSizeHorizontal * 95,
            height: blockSizeVertical * 56,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                spacing: defaultSize * 1.5,
                runSpacing: defaultSize,
                verticalDirection: VerticalDirection.down,
                alignment: WrapAlignment.center,
//                children: buildWrap(),
                children: [],
              ),
            ),
          ),
          SizedBox(
            height: defaultSize * 2,
          ),
          Expanded(
            child: Container(
              decoration: innerShadow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'All: 8',
                    style: TextStyle(fontSize: defaultSize * 2.4),
                  ),
                  Text(
                    'Correct: 8',
                    style: TextStyle(fontSize: defaultSize * 2.4),
                  ),
                  Text(
                    'Wrong: 8',
                    style: TextStyle(fontSize: defaultSize * 2.4),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Chip> buildWrap({var data}) {
    return List.generate(
      data.length,
      (index) => Chip(
        padding: EdgeInsets.all(10),
        label: Text(
          data.word,
          style: TextStyle(
            fontSize: defaultSize * 2.4,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
    );
  }
}
