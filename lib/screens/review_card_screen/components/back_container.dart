import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/review_card_screen/components/text_holder.dart';

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
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;

    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Container(
              width: screenWidth * 0.7,
              height: screenHeight * 0.8,
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
                      TextHolder(title: wordsData[index].targetLang),
                      TextHolder(title: wordsData[index].secondLang),
                      TextHolder(title: 'third word'),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
