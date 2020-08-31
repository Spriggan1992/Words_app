import 'dart:async';
import 'dart:math' as math;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/part.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';
import 'package:words_app/screens/review_card_screen/components/back_container.dart';
import 'package:words_app/screens/review_card_screen/components/word_card.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/utils/size_config.dart';

class ReviewCard extends StatefulWidget {
  static String id = 'review_card_screen';
  ReviewCard({this.index, this.words});
  final int index;
  final List<Word> words;

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  /// Initial index of page;
  int initialPage;

  /// If `true` show front - examples text
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    getCurrInd();
    _pageController =
        PageController(viewportFraction: 0.87, initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Set up [isFront] `true` or `false`
  void toggleIsFront() {
    isFront = !isFront;
    setState(() {});
  }

  /// Pass throught [initialPage] what we get from [screens/manager_collection/components/word_card.dart]
  void getCurrInd() {
    initialPage = widget.index;
    Timer(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("FROM REVIEW CARD: ${widget.words[widget.index].ownLang}");

    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    final wordsData =
        Provider.of<WordsRepository>(context, listen: false).words;

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
            onPress: () => Navigator.pushNamed(context, Matches.id)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      initialPage = value;
                    });
                  },
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  itemCount: widget.words.length,
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
                            duration: Duration(milliseconds: 500),
                            opacity: initialPage == index ? 1 : 0.1,
                            child: Transform.rotate(
                              angle: math.pi * value,
                              child: Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.center,
                                children: <Widget>[
                                  FlipCard(
                                    onFlip: () {
                                      setState(() {
                                        toggleIsFront();
                                      });
                                    },
                                    direction: FlipDirection.HORIZONTAL,
                                    speed: 400,
                                    front: WordCard(
                                        word: widget.words[index],
                                        side: 'front',
                                        index: index,
                                        part:
                                            widget.words[index].part.partColor),
                                    back: WordCard(
                                        word: widget.words[index],
                                        index: index,
                                        part:
                                            widget.words[index].part.partColor),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
