import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/manager_collection/components/word_card.dart';

import 'package:words_app/screens/review_card_screen/review_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //fetch data from db

    return Container(
      padding: EdgeInsets.only(bottom: 25.0),
      // Here we render only listView
      child: Consumer<Words>(
        builder: (context, words, child) {
          return AnimationLimiter(
            child: ListView.builder(
              // itemExtent: 100,
              itemCount: words.wordsData.length,
              // semanticChildCount: 1,
              itemBuilder: (context, index) {
                final item = words.wordsData[index].targetLang;

                /// Call conformation for removing word from collection
                void removeWord() {
                  words.removeWord(words.wordsData[index]);
                  Navigator.of(context).pop(true);
                }

                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 400),
                    child: SlideAnimation(
                        verticalOffset: 44.0,
                        child: FadeInAnimation(
                            child: buildDismissible(
                                item, index, context, words, removeWord))));
              },
            ),
          );
        },
      ),
    );
  }

  Dismissible buildDismissible(String item, int index, BuildContext context,
      Words words, Function removeWord) {
    return Dismissible(
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteConfirmation(
              context, removeWord, 'Do you want to delete this word?');
        }
      },
      onDismissed: (direction) {},
      background: Container(
        alignment: Alignment.centerRight,
        color: Color(0xFFF8b6b6),
        child: Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.delete),
        ),
      ),
      // key: Key(item),
      // TODO: here was error when dismiss widget, stackoverflows sugested to use UniqueKey()
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      child: WordCard(
        index: index,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/providers/words_provider.dart';
// import 'package:words_app/screens/manager_collection/components/word_card.dart';

// import 'package:words_app/screens/review_card_screen/review_card.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class Body extends StatelessWidget {
//   const Body({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //fetch data from db

//     return Container(
//       padding: EdgeInsets.only(top: 5.0, bottom: 0.0),
//       // Here we render only listView
//       child: Consumer<Words>(
//         builder: (context, words, child) {
//           return AnimationLimiter(
//             child: ListView.builder(
//               // itemExtent: 100,
//               itemCount: words.wordsData.length,
//               // semanticChildCount: 1,
//               itemBuilder: (context, index) {
//                 final item = words.wordsData[index].targetLang;
//                 return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: Duration(milliseconds: 400),
//                     child: SlideAnimation(
//                         verticalOffset: 44.0,
//                         child: FadeInAnimation(
//                             child: buildDismissible(
//                                 item, index, context, words))));
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Dismissible buildDismissible(
//       String item, int index, BuildContext context, Words words) {
//     return Dismissible(
//       onDismissed: (direction) {
//         words.removeWord(words.wordsData[index]);
//       },
//       background: Container(
//         alignment: Alignment.centerRight,
//         color: Color(0xFFF8b6b6),
//         child: Padding(
//           padding: EdgeInsets.only(right: 20),
//           child: Icon(Icons.delete),
//         ),
//       ),
//       // key: Key(item),
//       // TODO: here was error when dismiss widget, stackoverflows sugested to use UniqueKey()
//       key: UniqueKey(),
//       direction: DismissDirection.endToStart,
//       child: WordCard(
//         index: index,
//       ),
//     );
//   }
// }
