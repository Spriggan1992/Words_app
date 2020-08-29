import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';
import 'package:words_app/utils/size_config.dart';

import 'title_text_holder_container.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    this.index,
    this.part,
    this.side,
    // this.wordHolder,
  }) : super(key: key);

  final int index;
  final Color part;
  final String side;
  // final String targetLang;
  // final String secondLang;
  // final String thirdLang;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    double defaultSize = SizeConfig.defaultSize;
    final wordsData =
        Provider.of<WordsRepository>(context, listen: false).words;
    return Container(
        padding: EdgeInsets.only(
          right: defaultSize * 3,
          left: defaultSize * 3,
          top: defaultSize * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 75,
              height: SizeConfig.blockSizeVertical * 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
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
                            width: SizeConfig.blockSizeHorizontal * 73,
                            height: 10,
                            decoration: BoxDecoration(
                                color: part,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  side == 'front'
                      ? Column(
                          children: [
                            TitleTextHolderContainer(
                                defaultSize: defaultSize,
                                wordHolder: wordsData[index].targetLang,
                                index: index),
                            SizedBox(height: defaultSize * 4),
                            Container(
                              margin: EdgeInsets.only(bottom: defaultSize * 1),
                              width: defaultSize * 20,
                              height: defaultSize * 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(wordsData[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        )
                      : Container(
                          margin: EdgeInsets.only(bottom: defaultSize * 6.5),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              TitleTextHolderContainer(
                                  defaultSize: defaultSize,
                                  wordHolder: wordsData[index].secondLang,
                                  index: index),
                              SizedBox(height: defaultSize * 5),
                              TitleTextHolderContainer(
                                  defaultSize: defaultSize,
                                  wordHolder: wordsData[index].thirdLang,
                                  index: index),
                              SizedBox(height: defaultSize * 5),
                              TitleTextHolderContainer(
                                  defaultSize: defaultSize,
                                  wordHolder: wordsData[index].ownLang,
                                  index: index)
                            ],
                          ),
                        )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: SizeConfig.blockSizeVertical * 20,
              decoration: innerShadow,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    side == 'front'
                        ? Text(wordsData[index].example,
                            style: TextStyle(fontSize: 20))
                        : Text(wordsData[index].exampleTranslations,
                            style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
