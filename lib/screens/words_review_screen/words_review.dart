import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

import 'components/back_container.dart';
import 'components/front_container.dart';

class WordsReview extends StatelessWidget {
  static String id = 'words_review_screen';
  const WordsReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;
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
          onPress: () => Navigator.pushNamed(context, Training.id),
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
