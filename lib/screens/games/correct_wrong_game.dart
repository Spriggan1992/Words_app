import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/word.dart';

class Training extends StatefulWidget {
  static String id = 'training_screen';
  Training({this.words});

  final List<Word> words;

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Word> targetWords;
  List<Word> ownLanguageWords;
  bool correct = false;
  bool wrong = false;

  @override
  void initState() {
    super.initState();
    createData();
  }

  void toggleAnswerCorrect() {
    setState(() {
      correct = true;
      wrong = false;
    });
  }

  void toggleAnswerWrong() {
    setState(() {
      correct = false;
      wrong = true;
    });
  }

  void getData(List data) {}

  void createData() {
    targetWords = [...widget.words];
    targetWords.shuffle();
    ownLanguageWords = [...widget.words];
    ownLanguageWords.shuffle();
  }

  void removeTWords(value) {
    setState(() {
      targetWords.remove(value);
      ownLanguageWords.removeLast();
      if (ownLanguageWords.length < 1) {
        ownLanguageWords.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
          children: <Widget>[
            Container(
                child: targetWords.length > 0
                    ? Stack(
                        alignment: Alignment.center,
                        children: deck(
                            targetWords,
                            removeTWords,
                            ownLanguageWords,
                            toggleAnswerCorrect,
                            toggleAnswerWrong))
                    : Text('fdskjajfds')),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: matchWords(ownLanguageWords),
              ),
            ),
            // widget.dataWord.length > 0 ? nioticeContainer(flag) : Container(),
            Positioned(
              top: 480,
              left: 270,
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 40,
                decoration:
                    BoxDecoration(color: correct ? Colors.green : Colors.grey),
                child: Text(
                  'correct',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 480,
              left: 60,
              child: Container(
                alignment: Alignment.center,
                width: 100,
                height: 40,
                decoration:
                    BoxDecoration(color: wrong ? Colors.red : Colors.grey),
                child: Text(
                  'wrong',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List matchWords(List<Word> words) {
  var matches = words.map(
    (item) {
      return Positioned(
        top: 400,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 200,
          color: Colors.grey,
          child: Text(item.ownLang),
        ),
      );
    },
  ).toList();
  return matches;
}

List<Widget> deck(List<Word> targetWords, removieItem, ownLanguageWords,
    toogleAnswerCorrect, toogleAnswerWrong) {
  List<Widget> cardList = new List();
  int count = 0;
  double padding = 50.0;
  for (int i = 0; i < targetWords.length; i++) {
    if (count >= 1) {
      padding += 4;
    } else if (count >= 2) {
      padding += 3;
    } else if (count >= 4) {
      padding += 1;
    } else {
      padding += 0.1;
    }
    cardList.add(
      Positioned(
        top: padding,
        child: Dismissible(
          onDismissed: (DismissDirection derection) {
            if (derection == DismissDirection.startToEnd) {
              if (targetWords.last.id == ownLanguageWords.last.id) {
                toogleAnswerCorrect();
              } else {
                toogleAnswerWrong();
              }
              removieItem(targetWords[i]);
            }
            if (derection == DismissDirection.endToStart) {
              if (targetWords.last.id == ownLanguageWords.last.id) {
                toogleAnswerWrong();
              } else {
                toogleAnswerCorrect();
              }
              removieItem(targetWords[i]);
            }
          },
          key: UniqueKey(),
          child: Card(
            elevation: 10,
            child: Container(
                width: 300,
                height: 300,
                color: Colors.grey,
                child: Center(child: Text(targetWords[i].targetLang))),
          ),
        ),
      ),
    );
    count++;
  }

  return cardList;
}
// import 'package:flutter/material.dart';
// import 'package:words_app/components/base_appbar.dart';
// import 'package:words_app/components/base_bottom_appbar.dart';
// import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
// import 'package:words_app/constants/constants.dart';
// import 'package:words_app/providers/word_data.dart';
// import 'package:words_app/providers/words_repository.dart';
// import 'package:provider/provider.dart';
// import "dart:math";

// class Training extends StatefulWidget {
//   static String id = 'training_screen';
//   Training({this.dataWord});

//   final List<Word> dataWord;

//   @override
//   _TrainingState createState() => _TrainingState();
// }

// class _TrainingState extends State<Training> {
//   int flag = 0;
//   final int rightSwipe = 1;
//   final int leftSwipe = 0;

//   void setUpFlagForIcon(data) {
//     if (data == 1) {
//       flag = 1;
//     } else {
//       flag = 2;
//     }
//     setState(() {});
//   }

//   void removieItem(value) {
//     widget.dataWord.remove(value);
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final dataWords = Provider.of<Words>(context).wordsData;

//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: BaseAppBar(
//         title: Text('Training'),
//         appBar: AppBar(),
//       ),
//       bottomNavigationBar: BaseBottomAppBar(
//         child1: ReusableBottomIconBtn(
//           icons: Icons.keyboard_arrow_left,
//           color: kMainColorBackground,
//           onPress: () => Navigator.pop(context),
//         ),
//         child2: Container(),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Flexible(
//               flex: 3,
//               child: Container(
//                   child: widget.dataWord.length > 0
//                       ? Stack(
//                           alignment: Alignment.center,
//                           children: deck(
//                               widget.dataWord, removieItem, setUpFlagForIcon))
//                       : Text('fdskjajfds')),
//             ),
//             widget.dataWord.length > 0 ? nioticeContainer(flag) : Container()
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget nioticeContainer(flag) {
//   if (flag == 1) {
//     return Flexible(
//         flex: 1,
//         child:
//             Container(child: Text('I know', style: TextStyle(fontSize: 20))));
//   } else if (flag == 2) {
//     return Flexible(
//         flex: 1,
//         child: Container(
//             child: Text("I don't know", style: TextStyle(fontSize: 20))));
//   } else {
//     return Container();
//   }
// }

// List<Widget> deck(List<Word> data, removieItem, setUpFlagForIcon) {
//   List<Widget> cardList = new List();
//   int count = 0;
//   double padding = 50.0;
//   List<Word> randomData = data;
//   // randomData.shuffle();
//   for (int i = 0; i < randomData.length; i++) {
//     if (count >= 1) {
//       padding += 4;
//     } else if (count >= 2) {
//       padding += 3;
//     } else if (count >= 4) {
//       padding += 1;
//     } else {
//       padding += 0.1;
//     }
//     cardList.add(
//       Positioned(
//         top: padding,
//         child: Dismissible(
//           onDismissed: (DismissDirection derection) {
//             if (derection == DismissDirection.startToEnd) {
//               removieItem(data[i]);
//               setUpFlagForIcon(1);
//               print(data.length);
//             }
//             if (derection == DismissDirection.endToStart) {
//               removieItem(data[i]);
//               setUpFlagForIcon(2);
//               print(data.length);
//             }
//           },
//           key: UniqueKey(),
//           child: Card(
//             elevation: 10,
//             child: Container(
//                 width: 300,
//                 height: 300,
//                 color: Colors.grey,
//                 child: Center(child: Text(data[i].targetLang))),
//           ),
//         ),
//       ),
//     );
//     count++;
//   }

//   return cardList;
// }
