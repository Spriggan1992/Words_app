import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/utils/size_config.dart';

import 'highlight_text.dart';
import 'title_text_holder_container.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    this.word,
    this.index,
    this.part,
    this.side,
    this.active,
  }) : super(key: key);

  final int index;
  final Color part;
  final String side;
  final Word word;
  final bool active;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return AnimatedContainer(
      height: 400,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOutQuint,
      padding: EdgeInsets.only(
        right: defaultSize * 3,
        left: defaultSize * 3,
        top: active
            ? SizeConfig.blockSizeVertical * 2
            : SizeConfig.blockSizeVertical * 7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: SizeConfig.blockSizeVertical * 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(defaultSize * 1),
              color: Colors.white,
              boxShadow: [kBoxShadow],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Stack(
                    overflow: Overflow.visible,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Positioned(
                        top: -1,
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 65.6,
                          height: defaultSize * 1.2,
                          decoration: BoxDecoration(
                            color: part,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(defaultSize * 1),
                              topRight: Radius.circular(defaultSize * 1),
                            ),
                          ),
                        ),
                      ),
                      side == 'front'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: defaultSize * 3,
                                ),
                                TitleTextHolderContainer(
                                  defaultSize: defaultSize,
                                  wordHolder: word.targetLang ?? '...',
                                ),
                                SizedBox(height: defaultSize * 2),
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: defaultSize * 1),
                                    width: defaultSize * 19,
                                    height: defaultSize * 19,
                                    decoration: word.image.path == '' ||
                                            word.image == null ||
                                            word.image.path == null
                                        ? BoxDecoration()
                                        : BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                defaultSize * 1),
                                            image: DecorationImage(
                                              image: FileImage(word.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                )
                              ],
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TitleTextHolderContainer(
                                    defaultSize: defaultSize,
                                    wordHolder: word.ownLang ?? '...',
                                  ),
                                  TitleTextHolderContainer(
                                    defaultSize: defaultSize,
                                    wordHolder: word.secondLang ?? '...',
                                  ),
                                  TitleTextHolderContainer(
                                    defaultSize: defaultSize,
                                    wordHolder: word.thirdLang ?? '...',
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeOutQuint,
            height: active
                ? SizeConfig.blockSizeVertical * 20
                : SizeConfig.blockSizeVertical * 16,
            decoration: innerShadow,
            margin: EdgeInsets.only(
              top: active ? defaultSize * 2 : defaultSize * 2,
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: defaultSize * 1, left: defaultSize * 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  side == 'front'
                      ? HighlightText(
                          text: word.example ?? '...',
                          highlight: word.targetLang,
                          highlightColor: Colors.red,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2
                              .merge(
                                TextStyle(fontSize: defaultSize * 2),
                              ),
                        )
                      // Text(word.example ?? '...',
                      //     style: Theme.of(context)
                      //         .primaryTextTheme
                      //         .bodyText2
                      //         .merge(TextStyle(fontSize: defaultSize * 2)))
                      : HighlightText(
                          text: word.exampleTranslations ?? '...',
                          highlight: word.ownLang,
                          highlightColor: Colors.red,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2
                              .merge(
                                TextStyle(fontSize: defaultSize * 2),
                              ),
                        )
                  // Text(
                  //     word.exampleTranslations ?? '...',
                  //     style: Theme.of(context)
                  //         .primaryTextTheme
                  //         .bodyText2
                  //         .merge(
                  //           TextStyle(fontSize: defaultSize * 2),
                  //         ),
                  //   )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:words_app/constants/constants.dart';
// import 'package:words_app/models/word_model.dart';
// import 'package:words_app/utils/size_config.dart';

// import 'title_text_holder_container.dart';

// class WordCard extends StatelessWidget {
//   const WordCard({
//     Key key,
//     this.word,
//     this.index,
//     this.part,
//     this.side,
//     // this.wordHolder,
//   }) : super(key: key);

//   final int index;
//   final Color part;
//   final String side;
//   final Word word;
//   // final String targetLang;
//   // final String secondLang;
//   // final String thirdLang;

//   @override
//   Widget build(BuildContext context) {
//     double defaultSize = SizeConfig.defaultSize;

//     return Container(
//       padding: EdgeInsets.only(
//         right: defaultSize * 3,
//         left: defaultSize * 3,
//         top: defaultSize * 2,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Container(
//             width: SizeConfig.blockSizeHorizontal * 75,
//             height: SizeConfig.blockSizeVertical * 44,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.white),
//               borderRadius: BorderRadius.circular(10.0),
//               color: Colors.white,
//               boxShadow: [kBoxShadow],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Stack(
//                     overflow: Overflow.visible,
//                     alignment: Alignment.bottomCenter,
//                     children: <Widget>[
//                       Positioned(
//                         top: -1,
//                         child: Container(
//                           width: SizeConfig.blockSizeHorizontal * 73,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             color: part,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               topRight: Radius.circular(10),
//                             ),
//                           ),
//                         ),
//                       ),
//                       side == 'front'
//                           ? Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 SizedBox(
//                                   height: defaultSize * 2,
//                                 ),
//                                 TitleTextHolderContainer(
//                                   defaultSize: defaultSize,
//                                   wordHolder: word.targetLang ?? '...',
//                                 ),
//                                 SizedBox(height: defaultSize * 4),
//                                 Container(
//                                   margin:
//                                       EdgeInsets.only(bottom: defaultSize * 1),
//                                   width: defaultSize * 20,
//                                   height: defaultSize * 20,
//                                   decoration: word.image.path == '' ||
//                                           word.image == null ||
//                                           word.image.path == null
//                                       ? BoxDecoration()
//                                       : BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           image: DecorationImage(
//                                             image: FileImage(word.image),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                 )
//                               ],
//                             )
//                           : Container(
//                               alignment: Alignment.center,
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   TitleTextHolderContainer(
//                                     defaultSize: defaultSize,
//                                     wordHolder: word.ownLang ?? '...',
//                                   ),
//                                   TitleTextHolderContainer(
//                                     defaultSize: defaultSize,
//                                     wordHolder: word.secondLang ?? '...',
//                                   ),
//                                   TitleTextHolderContainer(
//                                     defaultSize: defaultSize,
//                                     wordHolder: word.thirdLang ?? '...',
//                                   )
//                                 ],
//                               ),
//                             )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Container(
//             height: SizeConfig.blockSizeVertical * 20,
//             decoration: innerShadow,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 10, left: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   side == 'front'
//                       ? Text(word.example ?? '...',
//                           style: Theme.of(context)
//                               .primaryTextTheme
//                               .bodyText2
//                               .merge(TextStyle(fontSize: 20.0)))
//                       : Text(word.exampleTranslations ?? '...',
//                           style: Theme.of(context)
//                               .primaryTextTheme
//                               .bodyText2
//                               .merge(TextStyle(fontSize: 20.0)))
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
