import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/repositories/words_repository.dart';

import 'package:words_app/utils/size_config.dart';

class BackContainer extends StatelessWidget {
  const BackContainer({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    final wordsData =
        Provider.of<WordsRepository>(context, listen: false).wordsData;

    return Container(
        padding: EdgeInsets.only(
          right: SizeConfig.defaultSize * 2,
          left: SizeConfig.defaultSize * 2,
          top: SizeConfig.defaultSize * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 75,
              height: SizeConfig.blockSizeVertical * 50,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
                color: kAppBarsColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // TextHolder(title: wordsData[index].targetLang),
                      // TextHolder(title: wordsData[index].secondLang),
                      // TextHolder(title: 'third word'),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Container(
              height: SizeConfig.blockSizeVertical * 20,
              decoration: innerShadow,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Venäjällä on kylmä talvi.',
                        style: TextStyle(fontSize: 20)),
                    Text('Winter is cold in Russia.',
                        style: TextStyle(fontSize: 20)),
                    Text('俄罗斯的冬天很冷。', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
