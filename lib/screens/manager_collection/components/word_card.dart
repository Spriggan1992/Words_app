import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/manager_collection/components/dialog_window.dart';
import 'package:words_app/screens/review_card_screen/review_card.dart';
import 'package:words_app/utils/size_config.dart';
import 'expandable_container.dart';

class WordCard extends StatefulWidget {
  const WordCard({this.index});
  final index;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {
  Offset cardPosition;
  bool isExpanded = false;

  AnimationController pageAnimationController;
  Animation pageAnimation;
  AnimationController expandController;
  Animation<double> animation;
  Animation rotationAnimation;

  void runExpandCheck() {
    setState(() {
      if (!isExpanded) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();

    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.5).animate(expandController);
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;

    /// Receiving word data from[ word_data provider], using index to extract single item from array
    final word =
        Provider.of<Words>(context, listen: false).wordsData[widget.index];
    // print("DEBUG wordCard${word.image}");

    return ExpandableContainer(
      expanded: isExpanded,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ReviewCard(index: widget.index),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = 0.0;
                    var end = 1.0;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return ScaleTransition(
                      scale: animation.drive(tween),
                      alignment: Alignment.center,
                      child: child,
                    );
                  }));
        },
        child: Container(
          // margin: EdgeInsets.only(bottom: defaultSize * 3),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: isExpanded ? Colors.black38 : Colors.transparent),
            ),
            color: isExpanded ? Color(0xFFCFD8DC) : Color(0xFFeae2da),
          ),
          width: SizeConfig.blockSizeHorizontal * 100,
          child: Stack(
            alignment: Alignment.topLeft,
            overflow: Overflow.clip,
            children: <Widget>[
              //Part of speech
              AnimatedPositioned(
                top: word.part.partName.length > 1
                    ? defaultSize * 2.8
                    : defaultSize * 2.5,
                left: defaultSize,
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: isExpanded ? defaultSize : defaultSize * 4,
                  height: defaultSize * 8,
                  child: Text(
                    word.part.partName,
                    maxLines: 4,
                    style: TextStyle(
                      fontSize: word.part.partName.length > 1
                          ? defaultSize * 1.5
                          : defaultSize * 2.2,
                      color: word.part.partColor,
                    ),
                  ),
                ),
              ),

              //Main word container
              AnimatedPositioned(
                left: isExpanded ? defaultSize * 3.7 : defaultSize * 6,
                top: defaultSize * 2.7,
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: defaultSize * 30,
                  height: defaultSize * 3,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      word.targetLang, //Main word
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          // fontSize: 20.0,
                          fontSize: defaultSize * 2),
                    ),
                  ),
                ),
              ),
              // Translation word container
              AnimatedPositioned(
                curve: Curves.easeIn,
                left: isExpanded ? defaultSize * 3.7 : defaultSize * 6.0,
                top: defaultSize * 6.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  height: defaultSize * 3,
                  width: defaultSize * 30.0,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(word.ownLang, // Translation
                        maxLines: 2,
                        style: TextStyle(fontSize: defaultSize * 1.6)),
                  ),
                ),
              ),
              // Arrow Icon
              Positioned(
                left: defaultSize * 36,
                top: defaultSize * 1.3,
                child: RotationTransition(
                  turns: rotationAnimation,
                  child: Container(
                    child: IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        color: isExpanded ? Color(0xFF34c7b3) : Colors.black,
                        onPressed: () {
                          runExpandCheck();
                        }),
                  ),
                ),
              ),
              // Container with Word2 and Image
              Positioned(
                  left: defaultSize * 3.7,
                  top: defaultSize * 9.5,
                  child: ScaleTransition(
                    scale: animation,
                    child:
                        // Word2
                        Container(
                            width: defaultSize * 30.0,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(word.secondLang,
                                  style:
                                      TextStyle(fontSize: defaultSize * 1.6)),
                            )),
                  )),

              // Example
              Positioned(
                left: defaultSize * 3.7,
                top: defaultSize * 13,
                child: ScaleTransition(
                  scale: animation,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultSize * 0.5),
                      color: Colors.white,
                    ),
                    width: defaultSize * 35,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'example : ${word.example} \n translationExample: ${word.exampleTranslations}'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showDialogWindow(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: StatefulBuilder(builder: (context, setState) {
            return DialogWindow(index: index);
          }),
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/constants/constants.dart';
// import 'package:words_app/providers/words_provider.dart';
// import 'package:words_app/screens/manager_collection/components/dialog_window.dart';
// import 'package:words_app/screens/review_card_screen/review_card.dart';
// import 'package:words_app/utils/size_config.dart';
// import 'expandable_container.dart';

// class WordCard extends StatefulWidget {
//   const WordCard({this.index});
//   final index;

//   @override
//   _WordCardState createState() => _WordCardState();
// }

// class _WordCardState extends State<WordCard> with TickerProviderStateMixin {
//   Offset cardPosition;
//   bool isExpanded = false;

//   AnimationController pageAnimationController;
//   Animation pageAnimation;
//   AnimationController expandController;
//   Animation<double> animation;
//   Animation rotationAnimation;

//   void runExpandCheck() {
//     setState(() {
//       if (!isExpanded) {
//         expandController.forward();
//       } else {
//         expandController.reverse();
//       }
//       isExpanded = !isExpanded;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     expandController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 300));
//     animation =
//         CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
//     rotationAnimation =
//         Tween<double>(begin: 0.0, end: 0.5).animate(expandController);
//   }

//   @override
//   void dispose() {
//     expandController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     final defaultSize = SizeConfig.defaultSize;

//     /// Receiving word data from[ word_data provider], using index to extract single item from array
//     final word =
//         Provider.of<Words>(context, listen: false).wordsData[widget.index];
//     // print("DEBUG wordCard${word.image}");

//     double setUpDimensions() {
//       if (isExpanded && word.targetLang.length < 8) {
//         return defaultSize * 1.8;
//       } else if (isExpanded && word.targetLang.length <= 13) {
//         return defaultSize * 1.8;
//       } else if (isExpanded && word.targetLang.length > 13) {
//         return defaultSize;
//       } else {
//         return defaultSize * 2;
//       }
//     }

//     return ExpandableContainer(
//       expanded: isExpanded,
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context,
//               PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) =>
//                       ReviewCard(index: widget.index),
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) {
//                     var begin = 0.0;
//                     var end = 1.0;
//                     var curve = Curves.ease;

//                     var tween = Tween(begin: begin, end: end)
//                         .chain(CurveTween(curve: curve));
//                     return ScaleTransition(
//                       scale: animation.drive(tween),
//                       alignment: Alignment.center,
//                       child: child,
//                     );
//                   }));
//         },
//         child: Container(
//           width: SizeConfig.blockSizeHorizontal * 100,
//           color: kMainColorBackground,
//           child: Stack(
//             alignment: Alignment.topLeft,
//             overflow: Overflow.clip,
//             children: <Widget>[
//               //Part of speech
//               AnimatedPositioned(
//                 top: word.part.partName.length > 1
//                     ? defaultSize * 2.8
//                     : defaultSize * 2.5,
//                 left: defaultSize,
//                 duration: Duration(milliseconds: 300),
//                 child: Container(
//                   width: isExpanded ? defaultSize : defaultSize * 4,
//                   height: defaultSize * 8,
//                   child: Text(
//                     word.part.partName,
//                     maxLines: 4,
//                     style: TextStyle(
//                       fontSize: word.part.partName.length > 1
//                           ? defaultSize * 1.5
//                           : defaultSize * 2.2,
//                       color: word.part.partColor,
//                     ),
//                   ),
//                 ),
//               ),

//               //Main word container
//               AnimatedPositioned(
//                 left: isExpanded ? defaultSize * 3.7 : defaultSize * 6,
//                 top: defaultSize * 2.7,
//                 duration: Duration(milliseconds: 300),
//                 child: Container(
//                   width: isExpanded ? defaultSize * 13 : defaultSize * 15,
//                   child: Text(
//                     word.targetLang, //Main word
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                     style: TextStyle(
//                         // fontSize: 20.0,
//                         fontSize: setUpDimensions()),
//                   ),
//                 ),
//               ),
//               // Translation word container
//               AnimatedPositioned(
//                 curve: Curves.easeIn,
//                 left: isExpanded ? defaultSize * 3.7 : defaultSize * 22,
//                 top: isExpanded ? defaultSize * 6.0 : defaultSize * 3,
//                 duration: Duration(milliseconds: 200),
//                 child: Container(
//                   width: defaultSize * 13.0,
//                   child: Text(word.ownLang, // Translation
//                       maxLines: 2,
//                       style: TextStyle(fontSize: defaultSize * 1.3)),
//                 ),
//               ),
//               // Arrow Icon
//               Positioned(
//                 left: defaultSize * 36,
//                 top: defaultSize * 1.3,
//                 child: RotationTransition(
//                   turns: rotationAnimation,
//                   child: Container(
//                     child: IconButton(
//                         icon: Icon(Icons.arrow_drop_down),
//                         iconSize: 30,
//                         color: isExpanded ? Color(0xFF34c7b3) : Colors.black,
//                         onPressed: () {
//                           runExpandCheck();
//                         }),
//                   ),
//                 ),
//               ),
//               // Container with Word2 and Image
//               Positioned(
//                   left: defaultSize * 3.7,
//                   top: 90,
//                   child: ScaleTransition(
//                       scale: animation,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           // Word2
//                           Container(
//                               alignment: Alignment.centerLeft,
//                               child: Text(word.secondLang)),
//                           SizedBox(height: 20),
//                           // Image
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                   image: FileImage(word.image),
//                                   fit: BoxFit.cover),
//                             ),
//                             width: 80,
//                             height: 80,
//                           )
//                         ],
//                       ))),

//               // Example
//               Positioned(
//                 left: defaultSize * 16,
//                 top: 20,
//                 child: ScaleTransition(
//                   scale: animation,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     width: 180,
//                     height: 189,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                           'example : ${word.example} \n translationExample: ${word.exampleTranslations}'),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future showDialogWindow(BuildContext context, int index) {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//           content: StatefulBuilder(builder: (context, setState) {
//             return DialogWindow(index: index);
//           }),
//         );
//       },
//     );
//   }
// }
