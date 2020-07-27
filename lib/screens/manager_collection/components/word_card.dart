import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/manager_collection/components/dialog_window.dart';

import 'expandable_container.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';

class WordCard extends StatefulWidget {
  const WordCard({this.index});
  final index;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  bool expand = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    //Receiving word data from word_data provider, using index to extract single item from array
    final keyValue =
        Provider.of<Words>(context).wordsData[widget.index].id.toString();
    final keyValue2 = Provider.of<Words>(context).wordsData[widget.index].word1;
    final word =
        Provider.of<Words>(context, listen: false).wordsData[widget.index];

    // final showImg = Provider.of<Words>(context);
    return ExpandableContainer(
      expanded: expand,
      key: ValueKey('$keyValue2 - $keyValue'),
      // onExpansionChanged: (v) => setState(() {
      //   expand = !expand;
      // }),
      child: GestureDetector(
        onTap: () {
          // When we press on WordCard, we pass an id of this WordCard to provider_data,
          // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
          // Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
          word.selectImages(word.id);
          showDialogWindow(context, widget.index);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide()),
            color: kMainColorBackground,
            // borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: Stack(
              alignment: Alignment.topLeft,
              overflow: Overflow.visible,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AnimatedPositioned(
                  top: 20,
                  left: 10,
                  duration: Duration(milliseconds: 300),
                  key: ValueKey(widget.index),
                  child: Text(
                    word.part,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                //Main word container
                AnimatedPositioned(
                  key: ValueKey(word.word1),
                  left: expand ? 40 : 70,
                  top: 20,
                  duration: Duration(milliseconds: 300),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 120, maxHeight: 60),
                    child: Text(word.word1, //Main word
                        style: TextStyle(fontSize: 20.0)),
                  ),
                ),
                // Translation word container
                AnimatedPositioned(
                  key: ValueKey(word.translation),
                  left: expand ? 40 : 230,
                  top: expand ? 60 : 27,
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    word.translation, //  Translation
                  ),
                ),
                // Arrow Icon
                Positioned(
                  left: 315,
                  top: 10,
                  child: Container(
                    child: IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        onPressed: () {
                          setState(() {
                            expand = !expand;
                          });
                        }),
                  ),
                ),
                // Word2
                expand
                    ? Positioned(
                        left: 40,
                        top: 90,
                        child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: Text(word.word2)),
                      )
                    : Container(),

                // Image
                expand
                    ? Positioned(
                        left: 40,
                        top: 130,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(
                                  word.image,
                                ),
                                fit: BoxFit.cover),
                          ),
                          // padding: EdgeInsets.all(0),
                          width: 80,
                          height: 80,
                        ),
                      )
                    : Container(),
                // Example
                expand
                    ? Positioned(
                        left: 140,
                        top: 20,
                        child: AnimatedContainer(
                          width: 180,
                          height: expand ? 195 : 0,
                          color: Colors.white,
                          curve: Curves.ease,
                          duration: Duration(milliseconds: 600),
                          // child: Padding(
                          // padding: const EdgeInsets.all(8.0),
                          // child: Text(
                          //     'Venäjällä on kylmä talvi Winter is cold in Russia.'),
                        ),
                        // ),
                      )
                    : Container(),

                // Image
                // GestureDetector(
                //     // When we press IconBotton is DialogTextHolderContainer, we pass an id of this WordCard to provider_data,
                //     // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
                //     // Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
                //     onTap: () {
                //       word.selectImages(word.id);
                //       showImg.toggleShowImgInWordsProvider(word);

                //       // words
                //       //     .toggleShowImgInWordsProvider(words);
                //     },
                //     // child: Icon(Icons.arrow_drop_down)

                //     // : Container(
                //     //     decoration: BoxDecoration(
                //     //       borderRadius: BorderRadius.circular(10),
                //     //       image: DecorationImage(
                //     //           image: AssetImage(
                //     //             word.image,
                //     //           ),
                //     //           fit: BoxFit.cover),
                //     //     ),
                //     //     // padding: EdgeInsets.all(0),
                //     //     width: 48,
                //     //     height: 48,
                //     //   ),
                //     ),
              ],
            ),
          ),
        ),
      ),
      // children: <Widget>[
      //   Container(
      //     height: 100,
      //   ),
      // ],
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

// // import 'package:flutter_form_builder/flutter_form_builder.dart';

// class WordCard extends StatefulWidget {
//   const WordCard({this.index});
//   final index;

//   @override
//   _WordCardState createState() => _WordCardState();
// }

// class _WordCardState extends State<WordCard> {
//   bool expand = true;
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     //Receiving word data from word_data provider, using index to extract single item from array
//     final keyValue =
//         Provider.of<Words>(context).wordsData[widget.index].id.toString();
//     final keyValue2 = Provider.of<Words>(context).wordsData[widget.index].word1;
//     final word =
//         Provider.of<Words>(context, listen: false).wordsData[widget.index];

//     // final showImg = Provider.of<Words>(context);
//     return ExpansionTile(
//       key: ValueKey('$keyValue2 - $keyValue'),
//       onExpansionChanged: (v) => setState(() {
//         expand = !expand;
//       }),
//       title: GestureDetector(
//         onTap: () {
//           // When we press on WordCard, we pass an id of this WordCard to provider_data,
//           // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
//           // Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
//           word.selectImages(word.id);
//           showDialogWindow(context, widget.index);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: kMainColorBackground,
//             // borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//             child: Stack(
//               // alignment: Alignment.centerLeft,
//               overflow: Overflow.visible,
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Positioned(
//                   key: ValueKey(widget.index),
//                   child: Text(
//                     word.part,
//                     style: TextStyle(fontSize: 20.0),
//                   ),
//                 ),
//                 //Main word container
//                 AnimatedPositioned(
//                   key: ValueKey(word.word1),
//                   left: expand ? 60 : 40,
//                   duration: Duration(milliseconds: 300),
//                   child: Text(word.word1, //Main word
//                       style: TextStyle(fontSize: 20.0)),
//                 ),
//                 // Translation word container
//                 AnimatedPositioned(
//                   key: ValueKey(word.translation),
//                   left: expand ? 250 : 40,
//                   bottom: expand ? 1 : -25,
//                   duration: Duration(milliseconds: 200),
//                   child: Text(
//                     word.translation, //  Translation
//                   ),
//                 ),
//                 // Positioned(
//                 //   left: 160,
//                 //   child: AnimatedContainer(
//                 //     curve: Curves.fastLinearToSlowEaseIn,
//                 //     height: expand ? 0 : 130,
//                 //     duration: Duration(milliseconds: 200),
//                 //     width: 160,
//                 //     color: Colors.red,
//                 //   ),
//                 // ),

//                 // Image
//                 // GestureDetector(
//                 //     // When we press IconBotton is DialogTextHolderContainer, we pass an id of this WordCard to provider_data,
//                 //     // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
//                 //     // Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
//                 //     onTap: () {
//                 //       word.selectImages(word.id);
//                 //       showImg.toggleShowImgInWordsProvider(word);

//                 //       // words
//                 //       //     .toggleShowImgInWordsProvider(words);
//                 //     },
//                 //     // child: Icon(Icons.arrow_drop_down)

//                 //     // : Container(
//                 //     //     decoration: BoxDecoration(
//                 //     //       borderRadius: BorderRadius.circular(10),
//                 //     //       image: DecorationImage(
//                 //     //           image: AssetImage(
//                 //     //             word.image,
//                 //     //           ),
//                 //     //           fit: BoxFit.cover),
//                 //     //     ),
//                 //     //     // padding: EdgeInsets.all(0),
//                 //     //     width: 48,
//                 //     //     height: 48,
//                 //     //   ),
//                 //     ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       children: <Widget>[
//         Container(
//           height: 100,
//         ),
//       ],
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
