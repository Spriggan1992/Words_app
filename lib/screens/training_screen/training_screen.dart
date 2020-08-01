import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:provider/provider.dart';
import "dart:math";
import 'dart:collection';

class Training extends StatefulWidget {
  static String id = 'training_screen';
  Training({this.dataWord});

  final List<Word> dataWord;

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  List<Word> targetWords;
  List<Word> ownLanguageWords;
  int flag = 0;
  final int rightSwipe = 1;
  final int leftSwipe = 0;

  @override
  void initState() {
    super.initState();
    createData();
  }

  bool checkAnswer() {
    // setState(() {
    if (targetWords[-1].id == ownLanguageWords[-1].id) {
      print('yes');
      return true;
    } else {
      print('no');
      return false;
    }
    // });
  }

// for (int i=0;i< a.length; i +=1){
//       b.add(i);
//       a.remove(i);
//     };

  void createData() {
    targetWords = [...widget.dataWord];
    // var a = [];
    // targetWords.
    // for (int i=0; targetWords.length< 0; i++ ){
    //   a.add(targetWords.every((element) => i % 2 ==0));

    // targetWords.shuffle();
    ownLanguageWords = [...widget.dataWord];

    // ownLanguageWords.shuffle();
  }

  void setUpFlagForIcon(data) {
    if (data == 1) {
      flag = 1;
    } else {
      flag = 2;
    }
    setState(() {});
  }

  void removeOwnLanguageWord() {
    ownLanguageWords.removeLast();
    if (ownLanguageWords.length < 1) {
      ownLanguageWords.clear();
    }
    print(ownLanguageWords);
    setState(() {});
  }

  void removeTargetWord(value) {
    setState(() {
      if (targetWords.last.id == ownLanguageWords.last.id) {
        print("yes");
      } else {
        print('no');
      }
      targetWords.remove(value);
      removeOwnLanguageWord();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final dataWords = Provider.of<Words>(context).wordsData;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
            Expanded(
              // flex: 3,
              child: Container(
                  child: targetWords.length > 0
                      ? Stack(
                          alignment: Alignment.center,
                          children: deck(
                              targetWords,
                              removeTargetWord,
                              setUpFlagForIcon,
                              checkAnswer,
                              removeOwnLanguageWord))
                      : Text('fdskjajfds')),
            ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: matchWords(ownLanguageWords),
              ),
            ),
            widget.dataWord.length > 0 ? nioticeContainer(flag) : Container()
          ],
        ),
      ),
    );
  }
}

Widget nioticeContainer(flag) {
  if (flag == 1) {
    return Center(
      child: Expanded(
          // flex: 1,
          child:
              Container(child: Text('I know', style: TextStyle(fontSize: 20)))),
    );
  } else if (flag == 2) {
    return Center(
      child: Expanded(
          // flex: 1,
          child: Container(
              child: Text("I don't know", style: TextStyle(fontSize: 20)))),
    );
  } else {
    return Container();
  }
}

List matchWords(List dataWord) {
  var matches = dataWord.map(
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

List<Widget> deck(List<Word> data, removieItem, setUpFlagForIcon, checkAnswer,
    removeOwnLanguageWord) {
  List<Widget> cardList = new List();
  int count = 0;
  double padding = 50.0;
  List<Word> randomTargetWord = data;
  // randomTargetWord.shuffle();

  for (int i = 0; i < randomTargetWord.length; i++) {
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
              removieItem(data[i]);

              setUpFlagForIcon(1);
              // checkAnswer();
            }
            if (derection == DismissDirection.endToStart) {
              removieItem(data[i]);
              setUpFlagForIcon(2);
            }
          },
          key: UniqueKey(),
          child: Card(
            elevation: 10,
            child: Container(
                width: 300,
                height: 300,
                color: Colors.grey,
                child: Center(child: Text(data[i].targetLang))),
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
// import 'package:words_app/providers/words_provider.dart';
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
