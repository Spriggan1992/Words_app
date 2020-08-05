import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/review_card_screen/components/back_container.dart';
import 'dart:math' as math;

import 'package:words_app/screens/review_card_screen/components/front_container.dart';

class ReviewCard extends StatefulWidget {
  static String id = 'review_card_screen';

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  PageController _pageController;
  int initialPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.85,
      initialPage: initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;
    return Scaffold(
      appBar: BaseAppBar(
        title: Text("Collection's name"),
        actions: <Widget>[],
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
          onPress: () => Navigator.pushNamed(context, null),
        ),
      ),
      body: Container(
        width: screenWidth,
        height: screenHeight * 1.5,
        color: Colors.grey,
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    initialPage = value;
                  });
                },
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                itemCount: wordsData.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double value = 0;
                        if (_pageController.position.haveDimensions) {
                          value = index - _pageController.page;
                          value = (value * 0.06).clamp(-1, 1);
                        }
                        return AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: initialPage == index ? 1 : 0.4,
                          child: Transform.rotate(
                              angle: math.pi * value,
                              child: FlipCard(
                                  direction: FlipDirection.HORIZONTAL,
                                  speed: 300,
                                  front: FrontContainer(
                                    index: index,
                                  ),
                                  back: BackContainer(
                                    index: index,
                                  ))),
                        );
                      });
                })),
      ),
    );
  }
}
