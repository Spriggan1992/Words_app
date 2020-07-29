import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/word_data.dart';
import 'package:words_app/providers/words_provider.dart';

class WordsReview extends StatelessWidget {
  static String id = 'words_review_screen';
  const WordsReview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFlipped = true;
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: Text('Collection Name'),
        appBar: AppBar(),
      ),
      bottomNavigationBar: BaseBottomAppBar(
        child1: Container(),
        child2: Container(),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: wordsData.length,
        itemBuilder: (context, index) {
          return FlipCard(
              onFlipDone: (a) {
                isFlipped = !isFlipped;
                print(isFlipped);
              },
              direction: FlipDirection.HORIZONTAL,
              speed: 300,
              front: FlipContainer(
                index: index,
                isFlipped: isFlipped,
              ),
              back: FlipContainer(
                index: index,
                isFlipped: isFlipped,
              ));
        },
      ),
    );
  }
}

class FlipContainer extends StatelessWidget {
  const FlipContainer({
    Key key,
    this.index,
    this.isFlipped,
    // this.toggleContainer,
  }) : super(key: key);

  final int index;
  final bool isFlipped;
  // final Function toggleContainer;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;

    return GestureDetector(
      // onTap: toggleContainer,
      child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: <Widget>[
              Container(
                width: screenWidth * 0.7,
                height: screenHeight * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  color: kAppBarsColor,
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: isFlipped
                        ? Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextHolder(title: wordsData[index].word1),
                              TextHolder(title: wordsData[index].word2),
                              TextHolder(title: 'third word'),
                            ],
                          )
                        : Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(wordsData[index].translation),
                              Text('сущ'),
                              Container(
                                width: screenWidth * 0.3,
                                height: screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
//                                    image: AssetImage(wordsData[index].image),
                                    image: FileImage(wordsData[index].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          )),
              ),
              SizedBox(height: 20),
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.35,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.grey[400],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Venäjällä on kylmä talvi.',
                          style: TextStyle(fontSize: 20)),
                      Text('Winter is cold in Russia.',
                          style: TextStyle(fontSize: 20)),
                      Text('俄罗斯的冬天很冷。', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class TextHolder extends StatelessWidget {
  const TextHolder({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 25.0,
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 50.0),
            child: Text(
              'n',
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(title, style: TextStyle(fontSize: 30))
        ],
      ),
    );
  }
}
