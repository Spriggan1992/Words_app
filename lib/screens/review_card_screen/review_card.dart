import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/screens/review_card_screen/widgets/word_widgets.dart';
import 'package:words_app/screens/screens.dart';

import 'package:words_app/widgets/base_appbar.dart';

import 'package:words_app/models/difficulty.dart';
import 'package:words_app/widgets/widgets.dart';

import '../../bloc/words/words_bloc.dart';
import '../../widgets/base_appbar.dart';
import '../../models/difficulty.dart';
import '../../models/word.dart';
import '../../utils/size_config.dart';

class ReviewCard extends StatefulWidget {
  static String id = 'review_card_screen';
  ReviewCard({this.index, this.words, this.collectionId, this.collectionTitle});
  final int index;
  final List<Word> words;
  final String collectionId;
  final String collectionTitle;

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

  /// Initial page from index
  int page;
  List<Difficulty> difficultyList = DifficultyList().difficultyList;

  @override
  void initState() {
    super.initState();
    getCurrInd();
    _pageController =
        PageController(viewportFraction: 0.8, initialPage: initialPage);

    page = widget.index;
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
    Timer(Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          widget.collectionTitle,
        ),
        actions: <Widget>[],
        appBar: AppBar(),
      ),
      bottomSheet: BaseBottomAppbar(
          screenDefiner: ScreenDefiner.reviewCard,
          trainingsWordCounter: "${widget.words?.length ?? 0}",
          goToTrainings: () {
            context.bloc<TrainingsBloc>().add(TrainingsLoaded(
                words: widget.words, collectionId: widget.collectionId));
            Navigator.pushNamed(
              context,
              TrainingManager.id,
            );
          }),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(
                    () {
                      initialPage = value;
                      page = _pageController.page.round();
                      selectedChoice = '';
                    },
                  );
                },
                controller: _pageController,
                itemCount: widget.words.length,
                itemBuilder: (context, index) {
                  bool active = index == page;
                  // final double top = active ? defaultSize * 1 : defaultSize * 4;
                  // final double bottom =
                  //     active ? defaultSize * 1 : defaultSize * 1;
                  return FlipCard(
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
                      part: widget.words[index].part.partColor,
                      active: active,
                    ),
                    back: WordCard(
                      word: widget.words[index],
                      index: index,
                      part: widget.words[index].part.partColor,
                      active: active,
                    ),
                  );
                  // return AnimatedContainer(
                  //   duration: Duration(milliseconds: 1000),
                  //   // curve: Curves.easeInOut,
                  //   curve: Curves.easeOutQuint,
                  //   margin: EdgeInsets.only(top: top, bottom: bottom),

                  //   child: FlipCard(
                  //     onFlip: () {
                  //       setState(() {
                  //         toggleIsFront();
                  //       });
                  //     },
                  //     direction: FlipDirection.HORIZONTAL,
                  //     speed: 400,
                  //     front: WordCard(
                  //       word: widget.words[index],
                  //       side: 'front',
                  //       index: index,
                  //       part: widget.words[index].part.partColor,
                  //     ),
                  //     back: WordCard(
                  //       word: widget.words[index],
                  //       index: index,
                  //       part: widget.words[index].part.partColor,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: defaultSize * 6),
            height: defaultSize * 5,
            width: SizeConfig.blockSizeHorizontal * 78,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...List.generate(
                  difficultyList.length,
                  (index) => Container(
                    padding: const EdgeInsets.all(5.0),
                    child: ChoiceChip(
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: defaultSize * 0.7),
                      elevation: 5,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultSize * 0.6,
                        vertical: defaultSize,
                      ),
                      label: Text(difficultyList[index].name),
                      labelStyle:
                          Theme.of(context).primaryTextTheme.bodyText2.merge(
                                TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      backgroundColor: difficultyList[index].color,
                      selected: selectedChoice == difficultyList[index].name,
                      onSelected: (selected) {
                        setState(
                          () {
                            selectedChoice = difficultyList[index].name;
                          },
                        );
                        context.bloc<WordsBloc>().add(
                              WordsUpdatedWord(
                                word: widget.words[page].copyWith(
                                    difficulty:
                                        difficultyList[index].difficulty),
                              ),
                            );
                        context.bloc<WordsBloc>().add(WordsLoaded());
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
