import 'dart:async';
import 'dart:math' as math;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';

import 'package:words_app/components/base_appbar.dart';

import 'package:words_app/models/difficulty.dart';

import 'package:words_app/models/word.dart';

import 'package:words_app/screens/review_card_screen/components/word_card.dart';

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
  String selectedChoice = "";

  List<Difficulty> difficultyList = [
    Difficulty(difficulty: 0, name: 'know', color: Colors.green[400]),
    Difficulty(
        difficulty: 1, name: "know a little", color: Colors.yellowAccent),
    Difficulty(difficulty: 2, name: "don't know", color: Colors.redAccent),
  ];

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

  _buildChoiceList() {
    List<Widget> choices = List();
    difficultyList.forEach(
      (item) {
        choices.add(
          Container(
            padding: const EdgeInsets.all(5.0),
            child: ChoiceChip(
              label: Text(item.name),
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: item.color,
              selectedColor: Theme.of(context).accentColor,
              selected: selectedChoice == item.name,
              onSelected: (selected) {
                setState(
                  () {
                    selectedChoice = item.name;
                  },
                );
                context.bloc<WordsBloc>().add(
                      WordsUpdatedWord(
                        word: widget.words[widget.index]
                            .copyWith(difficulty: item.difficulty),
                      ),
                    );
              },
            ),
          ),
        );
      },
    );

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return Scaffold(
      appBar: BaseAppBar(
        title: Text("Collection's name"),
        actions: <Widget>[],
        appBar: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(
                    () {
                      initialPage = value;
                      // print("Difficulty from before bloc : ${difficulty}");
                      context.bloc<WordsBloc>().add(
                            WordsUpdatedWord(
                              word: widget.words[widget.index]
                                  .copyWith(difficulty: 0),
                            ),
                          );
                      selectedChoice = '';
                    },
                  );
                },
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                itemCount: widget.words.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      // print(
                      //     "Difficulty from review card: ${widget.words[index].difficulty}");
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
                                    part: widget.words[index].part.partColor),
                                back: WordCard(
                                    word: widget.words[index],
                                    index: index,
                                    part: widget.words[index].part.partColor),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: defaultSize * 2),
            height: 50,
            width: SizeConfig.blockSizeHorizontal * 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildChoiceList(),
            ),
          )
        ],
      ),
      // bottomNavigationBar: BaseBottomAppBar(
      //   child1: ReusableBottomIconBtn(
      //     icons: Icons.keyboard_arrow_left,
      //     color: kMainColorBackground,
      //     onPress: () => Navigator.pop(context),
      //   ),
      //   child2: ReusableBottomIconBtn(
      //       icons: Icons.fitness_center,
      //       color: kMainColorBackground,
      //       onPress: () => Navigator.pushNamed(context, Matches.id)),
      // ),
    );
  }
}
