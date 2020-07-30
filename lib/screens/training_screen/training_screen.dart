import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:provider/provider.dart';
import "dart:math";

class Training extends StatelessWidget {
  static String id = 'training_screen';
  @override
  Widget build(BuildContext context) {
    final dataWords = Provider.of<Words>(context).wordsData;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    List<Widget> randomWidget = [];
    randomWidget.shuffle();
    return Scaffold(
      appBar: BaseAppBar(
        title: Text('Training'),
        appBar: AppBar(),
      ),
      bottomNavigationBar: BaseBottomAppBar(
        child1: ReusableBottomIconBtn(
          icons: Icons.keyboard_arrow_left,
          color: kMainColorBackground,
          onPress: () => Navigator.pop(context),
        ),
        child2: Container(),
      ),
      body: Center(
        child: Container(
            child: Stack(
          alignment: Alignment.center,
          children: deck(dataWords),
        )),
      ),
    );
  }
}

List<Widget> deck(List<Word> dataWords) {
  List<Widget> cardList = new List();
  int count = 0;
  double padding = 80.0;
  List<Word> randomData = dataWords;
  randomData.shuffle();
  for (int i = 0; i < randomData.length; i++) {
    if (count >= 1) {
      padding += 4;
    } else if (count >= 2) {
      padding += 3;
    } else if (count >= 4) {
      padding += 1;
    } else {
      padding += 0;
    }
    cardList.add(
      Positioned(
        top: padding,
        child: Dismissible(
          key: UniqueKey(),
          child: Card(
            elevation: 10,
            child: Container(
                width: 200,
                height: 200,
                color: Colors.grey,
                child: Text(dataWords[i].targetLang)),
          ),
        ),
      ),
    );
    count++;
  }

  return cardList;
}
