import 'package:flip_card/flip_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

import '../review_card_screen/components/front_container.dart';
import '../review_card_screen/components/back_container.dart';

class WordsReview extends StatelessWidget {
  static String id = 'words_review_screen';
  const WordsReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;

    void sendDataToTrainingScreen(context) {
      List<Word> dataWords = [...wordsData];
      dataWords.shuffle();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Matches(dataWord: dataWords)));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: Text('Collection Name'),
        appBar: AppBar(),
      ),
      bottomNavigationBar: BaseBottomAppBar(
        child1: ReusableBottomIconBtn(
          icons: Icons.keyboard_arrow_left,
          color: kMainColorBackground,
          onPress: () => Navigator.pop(context),
        ),
        child2: ReusableBottomIconBtn(
          icons: Icons.fitness_center,
          color: kMainColorBackground,
          onPress: () {
            sendDataToTrainingScreen(context);
            // Navigator.pushNamed(context, Training.id);
          },
          // onPress: () => Navigator.pushNamed(context, Training.id),
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: wordsData.length,
        itemBuilder: (context, index) {
          return FlipCard(
              direction: FlipDirection.HORIZONTAL,
              speed: 300,
              front: FrontContainer(
                index: index,
              ),
              back: BackContainer(
                index: index,
              ));
        },
      ),
    );
  }
}
