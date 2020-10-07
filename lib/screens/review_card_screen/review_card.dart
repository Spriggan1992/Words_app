import 'dart:async';
import 'dart:math' as math;

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';

import 'package:words_app/widgets/base_appbar.dart';
import 'package:words_app/constants/constants.dart';

import 'package:words_app/models/difficulty.dart';

import '../../bloc/words/words_bloc.dart';
import '../../widgets/base_appbar.dart';
import '../../models/difficulty.dart';
import '../../models/word_model.dart';
import '../../utils/size_config.dart';
import 'components/word_card.dart';

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
          "Collection's name",
        ),
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
            margin: EdgeInsets.only(bottom: defaultSize * 2),
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
// import 'dart:async';
// import 'dart:math' as math;

// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:words_app/bloc/words/words_bloc.dart';

// import 'package:words_app/widgets/base_appbar.dart';
// import 'package:words_app/constants/constants.dart';

// import 'package:words_app/models/difficulty.dart';

// import '../../bloc/words/words_bloc.dart';
// import '../../widgets/base_appbar.dart';
// import '../../models/difficulty.dart';
// import '../../models/word_model.dart';
// import '../../utils/size_config.dart';
// import 'components/word_card.dart';

// class ReviewCard extends StatefulWidget {
//   static String id = 'review_card_screen';
//   ReviewCard({this.index, this.words});
//   final int index;
//   final List<Word> words;

//   @override
//   _ReviewCardState createState() => _ReviewCardState();
// }

// class _ReviewCardState extends State<ReviewCard>
//     with SingleTickerProviderStateMixin {
//   PageController _pageController;

//   /// Initial index of page;
//   int initialPage;

//   /// If `true` show front - examples text
//   bool isFront = true;
//   String selectedChoice = "";

//   /// Initial page from index
//   int page;
//   List<Difficulty> difficultyList = DifficultyList().difficultyList;

//   @override
//   void initState() {
//     super.initState();
//     getCurrInd();
//     _pageController =
//         PageController(viewportFraction: 0.87, initialPage: initialPage);

//     page = widget.index;
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   /// Set up [isFront] `true` or `false`
//   void toggleIsFront() {
//     isFront = !isFront;
//     setState(() {});
//   }

//   /// Pass throught [initialPage] what we get from [screens/manager_collection/components/word_card.dart]
//   void getCurrInd() {
//     initialPage = widget.index;
//     Timer(Duration(milliseconds: 500), () {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     double defaultSize = SizeConfig.defaultSize;

//     return Scaffold(
//       appBar: BaseAppBar(
//         title: Text(
//           "Collection's name",
//         ),
//         actions: <Widget>[],
//         appBar: AppBar(),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               child: PageView.builder(
//                 onPageChanged: (value) {
//                   setState(
//                     () {
//                       initialPage = value;
//                       page = _pageController.page.round();
//                       selectedChoice = '';
//                     },
//                   );
//                 },
//                 controller: _pageController,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: widget.words.length,
//                 itemBuilder: (context, index) {
//                   return AnimatedBuilder(
//                     animation: _pageController,
//                     builder: (context, child) {
//                       double value = 0;
//                       if (_pageController.position.haveDimensions) {
//                         value = index - _pageController.page;
//                         value = (value * 0.04).clamp(-1, 1);
//                       }

//                       return AnimatedOpacity(
//                         duration: Duration(milliseconds: 600),
//                         // opacity: initialPage == index ? 1 : 0.5,
//                         opacity: 1,
//                         child: Transform.rotate(
//                           angle: math.pi * value,
//                           child: Stack(
//                             fit: StackFit.expand,
//                             alignment: Alignment.center,
//                             children: <Widget>[
//                               FlipCard(
//                                 onFlip: () {
//                                   setState(() {
//                                     toggleIsFront();
//                                   });
//                                 },
//                                 direction: FlipDirection.HORIZONTAL,
//                                 speed: 400,
//                                 front: WordCard(
//                                   word: widget.words[index],
//                                   side: 'front',
//                                   index: index,
//                                   part: widget.words[index].part.partColor,
//                                 ),
//                                 back: WordCard(
//                                   word: widget.words[index],
//                                   index: index,
//                                   part: widget.words[index].part.partColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(bottom: defaultSize * 2),
//             height: defaultSize * 5,
//             width: SizeConfig.blockSizeHorizontal * 78,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ...List.generate(
//                   difficultyList.length,
//                   (index) => Container(
//                     padding: const EdgeInsets.all(5.0),
//                     child: ChoiceChip(
//                       labelPadding:
//                           EdgeInsets.symmetric(horizontal: defaultSize * 0.7),
//                       elevation: 5,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: defaultSize * 0.6,
//                         vertical: defaultSize,
//                       ),
//                       label: Text(difficultyList[index].name),
//                       labelStyle:
//                           Theme.of(context).primaryTextTheme.bodyText2.merge(
//                                 TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       backgroundColor: difficultyList[index].color,
//                       selected: selectedChoice == difficultyList[index].name,
//                       onSelected: (selected) {
//                         setState(
//                           () {
//                             selectedChoice = difficultyList[index].name;
//                           },
//                         );
//                         context.bloc<WordsBloc>().add(
//                               WordsUpdatedWord(
//                                 word: widget.words[page].copyWith(
//                                     difficulty:
//                                         difficultyList[index].difficulty),
//                               ),
//                             );
//                         context.bloc<WordsBloc>().add(WordsLoaded());
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
