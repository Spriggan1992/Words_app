// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/helpers/functions.dart';
// import 'package:words_app/providers/words_repository.dart';
// import 'package:words_app/screens/card_creator_screen/card_creator.dart';

// import 'package:words_app/screens/review_card_screen/review_card.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:words_app/screens/words_screen/components/word_card.dart';

// class Body extends StatelessWidget {
//   const Body({
//     this.collectionId,
//     Key key,
//   }) : super(key: key);

//   final String collectionId;
//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = false;
//     //fetch data from db

//     return Container(
//       padding: EdgeInsets.only(bottom: 25.0),
//       // Here we render only listView
//       child: Consumer<Words>(
//         builder: (context, providerData, child) {
//           return AnimationLimiter(
//             child: ListView.builder(
//               // itemExtent: 100,
//               itemCount: providerData.wordsData.length,
//               // semanticChildCount: 1,
//               itemBuilder: (context, index) {
//                 /// Call conformation for removing word from collection
//                 void removeWord() {
//                   providerData.removeWord(providerData.wordsData[index]);
//                   Navigator.of(context).pop(true);
//                 }

//                 return AnimationConfiguration.staggeredList(
//                   position: index,
//                   duration: Duration(milliseconds: 400),
//                   child: SlideAnimation(
//                     verticalOffset: 44.0,
//                     child: FadeInAnimation(
//                       child: Slidable(
//                         key: UniqueKey(),
//                         child: WordCard(
//                           selected: isSelected,
//                           index: index,
//                         ),
//                         actionPane: SlidableDrawerActionPane(),
//                         secondaryActions: <Widget>[
//                           IconSlideAction(
//                               caption: 'Edit',
//                               color: Colors.black45,
//                               icon: Icons.edit,
//                               onTap: () =>
//                                   // Navigator.pushNamed(
//                                   //   context,
//                                   //   CardCreator.id,
//                                   //   arguments: {
//                                   //     'id': collectionId,
//                                   //     'index': index,
//                                   //     'editMode': true,
//                                   //   },
//                                   // ),
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => CardCreator(
//                                                 index: index,
//                                                 editMode: true,
//                                                 collectionId: collectionId,
//                                                 targetWord: providerData
//                                                     .wordsData[index]
//                                                     .targetLang,
//                                                 secondWord: providerData
//                                                     .wordsData[index]
//                                                     .secondLang,
//                                                 ownWord: providerData
//                                                     .wordsData[index].ownLang,
//                                                 thirdWord: providerData
//                                                     .wordsData[index].thirdLang,
//                                               )))),
//                           IconSlideAction(
//                               caption: 'Delete',
//                               color: Colors.red,
//                               icon: Icons.delete,
//                               onTap: () => deleteConfirmation(
//                                   context,
//                                   removeWord,
//                                   'Do you want to delete this word?')),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:words_app/helpers/functions.dart';
// // import 'package:words_app/providers/words_repository.dart';
// // import 'package:words_app/screens/card_creator_screen/card_creator.dart';
// // import 'package:words_app/screens/manager_collection/components/word_card.dart';

// // import 'package:words_app/screens/review_card_screen/review_card.dart';
// // import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// // import 'package:flutter_slidable/flutter_slidable.dart';

// // class Body extends StatelessWidget {
// //   const Body({
// //     this.collectionId,
// //     Key key,
// //   }) : super(key: key);

// //   final String collectionId;

// //   @override
// //   Widget build(BuildContext context) {
// //     //fetch data from db

// //     return Container(
// //       padding: EdgeInsets.only(bottom: 25.0),
// //       // Here we render only listView
// //       child: Consumer<Words>(
// //         builder: (context, providerData, child) {
// //           return AnimationLimiter(
// //             child: ListView.builder(
// //               // itemExtent: 100,
// //               itemCount: providerData.wordsData.length,
// //               // semanticChildCount: 1,
// //               itemBuilder: (context, index) {
// //                 /// Call conformation for removing word from collection
// //                 void removeWord() {
// //                   providerData.removeWord(providerData.wordsData[index]);
// //                   Navigator.of(context).pop(true);
// //                 }

// //                 return AnimationConfiguration.staggeredList(
// //                   position: index,
// //                   duration: Duration(milliseconds: 400),
// //                   child: SlideAnimation(
// //                     verticalOffset: 44.0,
// //                     child: FadeInAnimation(
// //                       child: Slidable(
// //                         key: UniqueKey(),
// //                         child: WordCard(
// //                           index: index,
// //                         ),
// //                         actionPane: SlidableDrawerActionPane(),
// //                         secondaryActions: <Widget>[
// //                           IconSlideAction(
// //                               caption: 'Edit',
// //                               color: Colors.black45,
// //                               icon: Icons.edit,
// //                               onTap: () =>
// //                                   // Navigator.pushNamed(
// //                                   //   context,
// //                                   //   CardCreator.id,
// //                                   //   arguments: {
// //                                   //     'id': collectionId,
// //                                   //     'index': index,
// //                                   //     'editMode': true,
// //                                   //   },
// //                                   // ),
// //                                   Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                           builder: (context) => CardCreator(
// //                                                 index: index,
// //                                                 editMode: true,
// //                                                 collectionId: collectionId,
// //                                                 targetWord: providerData
// //                                                     .wordsData[index]
// //                                                     .targetLang,
// //                                                 secondWord: providerData
// //                                                     .wordsData[index]
// //                                                     .secondLang,
// //                                                 ownWord: providerData
// //                                                     .wordsData[index].ownLang,
// //                                                 thirdWord: providerData
// //                                                     .wordsData[index].thirdLang,
// //                                               )))),
// //                           IconSlideAction(
// //                               caption: 'Delete',
// //                               color: Colors.red,
// //                               icon: Icons.delete,
// //                               onTap: () => deleteConfirmation(
// //                                   context,
// //                                   removeWord,
// //                                   'Do you want to delete this word?')),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
