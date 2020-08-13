import 'dart:async';
import 'dart:math' as math;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/part_data.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/review_card_screen/components/back_container.dart';
import 'package:words_app/screens/review_card_screen/components/word_card.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/utils/size_config.dart';

class ReviewCard extends StatefulWidget {
  static String id = 'review_card_screen';
  ReviewCard({this.index});
  final int index;

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
  // Part part = Part(
  //   'n',
  //   Colors.green,
  // );

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

  // _getColor(Color color) {
  //   setState(() {
  //     part.partColor = color;
  //   });
  // }

  /// Pass throught [initialPage] what we get from [screens/manager_collection/components/word_card.dart]
  void getCurrInd() {
    initialPage = widget.index;
    Timer(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }

  /// Send data to [screens/training_screen/matches.dart]
  void sendDataToTrainingScreen(context) {
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;
    List<Word> dataWords = [...wordsData];
    dataWords.shuffle();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Matches(dataWord: dataWords)));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

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
          onPress: () => sendDataToTrainingScreen(context),
        ),
      ),
      body: Column(
        // fit: StackFit.expand,
        // alignment: Alignment.center,
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
                                        side: 'front',
                                        index: index,
                                        part: wordsData[index].part.partColor),
                                    back: WordCard(
                                        index: index,
                                        part: wordsData[index].part.partColor),
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

// import 'dart:async';
// import 'dart:math' as math;
// import 'package:flip_card/flip_card.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/components/base_appbar.dart';
// import 'package:words_app/components/base_bottom_appbar.dart';
// import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
// import 'package:words_app/constants/constants.dart';
// import 'package:words_app/providers/word_data.dart';
// import 'package:words_app/providers/words_provider.dart';
// import 'package:words_app/screens/review_card_screen/components/back_container.dart';
// import 'package:words_app/screens/review_card_screen/components/front_container.dart';
// import 'package:words_app/screens/training_screen/matches.dart';

// class ReviewCard extends StatefulWidget {
//   static String id = 'review_card_screen';
//   ReviewCard({this.index});
//   final int index;

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

//   @override
//   void initState() {
//     super.initState();
//     getCurrInd();
//     _pageController =
//         PageController(viewportFraction: 0.87, initialPage: initialPage);
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
//     Timer(Duration(milliseconds: 100), () {
//       setState(() {});
//     });
//   }

//   /// Send data to [screens/training_screen/matches.dart]
//   void sendDataToTrainingScreen(context) {
//     final wordsData = Provider.of<Words>(context, listen: false).wordsData;
//     List<Word> dataWords = [...wordsData];
//     dataWords.shuffle();
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => Matches(dataWord: dataWords)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.width;
//     final wordsData = Provider.of<Words>(context, listen: false).wordsData;
//     return Scaffold(
//       appBar: BaseAppBar(
//         title: Text("Collection's name"),
//         actions: <Widget>[],
//         appBar: AppBar(),
//       ),
//       bottomNavigationBar: BaseBottomAppBar(
//         child1: ReusableBottomIconBtn(
//           icons: Icons.keyboard_arrow_left,
//           color: kMainColorBackground,
//           onPress: () => Navigator.pop(context),
//         ),
//         child2: ReusableBottomIconBtn(
//           icons: Icons.fitness_center,
//           color: kMainColorBackground,
//           onPress: () => sendDataToTrainingScreen(context),
//         ),
//       ),
//       body: Stack(
//         fit: StackFit.expand,
//         alignment: Alignment.center,
//         children: <Widget>[
//           Container(
//             width: screenWidth,
//             height: screenHeight * 1.5,
//             color: Colors.grey,
//             child: Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: PageView.builder(
//                     onPageChanged: (value) {
//                       setState(() {
//                         initialPage = value;
//                       });
//                     },
//                     controller: _pageController,
//                     physics: ClampingScrollPhysics(),
//                     itemCount: wordsData.length,
//                     itemBuilder: (context, index) {
//                       return AnimatedBuilder(
//                           animation: _pageController,
//                           builder: (context, child) {
//                             double value = 0;
//                             if (_pageController.position.haveDimensions) {
//                               value = index - _pageController.page;
//                               value = (value * 0.06).clamp(-1, 1);
//                             }
//                             return AnimatedOpacity(
//                               duration: Duration(milliseconds: 500),
//                               opacity: initialPage == index ? 1 : 0.1,
//                               child: Transform.rotate(
//                                   angle: math.pi * value,
//                                   child: Stack(
//                                     fit: StackFit.expand,
//                                     alignment: Alignment.center,
//                                     children: <Widget>[
//                                       FlipCard(
//                                           onFlip: () {
//                                             setState(() {
//                                               toggleIsFront();
//                                             });
//                                           },
//                                           direction: FlipDirection.HORIZONTAL,
//                                           speed: 400,
//                                           front: FrontContainer(
//                                             index: index,
//                                           ),
//                                           back: BackContainer(
//                                             index: index,
//                                           )),
//                                       Positioned.fill(
//                                         top: 400,
//                                         left: 10,
//                                         child: AnimatedSwitcher(
//                                           duration: Duration(milliseconds: 300),
//                                           transitionBuilder:
//                                               (widget, animation) {
//                                             var begin = 0.0;
//                                             var end = 1.0;
//                                             var curve = Curves.ease;
//                                             var tween = Tween(
//                                                     begin: begin, end: end)
//                                                 .chain(
//                                                     CurveTween(curve: curve));
//                                             return ScaleTransition(
//                                                 scale: animation.drive(tween),
//                                                 child: widget);
//                                           },
//                                           child: isFront
//                                               // Example Text
//                                               ? Column(
//                                                   key: ValueKey(1),
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: <Widget>[
//                                                     Text(
//                                                         'В России холодная зима',
//                                                         style: TextStyle(
//                                                             fontSize: 20)),
//                                                   ],
//                                                 )
//                                               : Column(
//                                                   key: ValueKey(2),
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: <Widget>[
//                                                     Text(
//                                                         'Venäjällä on kylmä talvi.',
//                                                         style: TextStyle(
//                                                             fontSize: 20)),
//                                                     Text(
//                                                         'Winter is cold in Russia.',
//                                                         style: TextStyle(
//                                                             fontSize: 20)),
//                                                     Text('俄罗斯的冬天很冷。',
//                                                         style: TextStyle(
//                                                             fontSize: 20)),
//                                                   ],
//                                                 ),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             );
//                           });
//                     })),
//           ),
//         ],
//       ),
//     );
//   }
// }
