import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creator_screen/card_creator.dart';
import 'package:words_app/screens/manager_collection/components/word_card.dart';

import 'package:words_app/screens/review_card_screen/review_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Body extends StatelessWidget {
  const Body({
    this.collectionId,
    Key key,
  }) : super(key: key);

  final String collectionId;

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
                      child: Slidable(
                        key: UniqueKey(),
                        child: WordCard(
                          index: index,
                        ),
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Edit',
                            color: Colors.black45,
                            icon: Icons.edit,
                            onTap: () => Navigator.pushNamed(
                              context,
                              CardCreator.id,
                              arguments: {
                                'id': collectionId,
                                'index': index,
                                'editMode': true,
                              },
                            ),
                          ),
                          IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () => deleteConfirmation(
                                  context,
                                  removeWord,
                                  'Do you want to delete this word?')),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Future<bool> dismissFunction(DismissDirection direction) async {
  //   if (direction == DismissDirection.endToStart) {
  //     print('wait fo action');
  //     deleteConfirmation(
  //         context, removeWord, 'Do you want to delete this word?');
  //   }
  // }
}

//   Dismissible Slidable(
//     String item, int index, BuildContext context,
//       Words words, Function removeWord) {
//     return WordCard(
//         index: index

//   });
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/helpers/functions.dart';
// import 'package:words_app/providers/words_provider.dart';
// import 'package:words_app/screens/manager_collection/components/word_card.dart';

// import 'package:words_app/screens/review_card_screen/review_card.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class Body extends StatelessWidget {
//   const Body({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //fetch data from db

//     return Container(
//       padding: EdgeInsets.only(bottom: 25.0),
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

//                 /// Call conformation for removing word from collection
//                 void removeWord() {
//                   words.removeWord(words.wordsData[index]);
//                   Navigator.of(context).pop(true);
//                 }

//                 return AnimationConfiguration.staggeredList(
//                     position: index,
//                     duration: Duration(milliseconds: 400),
//                     child: SlideAnimation(
//                         verticalOffset: 44.0,
//                         child: FadeInAnimation(
//                             child: buildDismissible(
//                                 item, index, context, words, removeWord))));
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Future<bool> dismissFunction(DismissDirection direction) async {
//     if (direction == DismissDirection.endToStart) {
//       print('wait fo action');
//     }
//   }

//   Dismissible buildDismissible(String item, int index, BuildContext context,
//       Words words, Function removeWord) {
//     return Dismissible(
//       confirmDismiss: (direction) {
//         if (direction == DismissDirection.endToStart) {
//           print('yes');
//           // deleteConfirmation(
//           //     context, removeWord, 'Do you want to delete this word?');
//         }
//       },
//       onDismissed: (direction) {},
//       background: Container(
//         alignment: Alignment.centerRight,
//         color: Color(0xFFF8b6b6),
//         child: Padding(
//           padding: EdgeInsets.only(right: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               IconButton(icon: Icon(Icons.edit), onPressed: () {}),
//               IconButton(icon: Icon(Icons.delete), onPressed: () {}),
//             ],
//           ),
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
