import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/manager_collection/components/dialog_window.dart';
import 'expandable_container.dart';

class WordCard extends StatefulWidget {
  const WordCard({this.index});
  final index;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with SingleTickerProviderStateMixin {
  bool isExpand = false;

  AnimationController expandController;
  Animation<double> animation;
  Animation rotationAnimation;

  void runExpandCheck() {
    setState(() {
      if (!isExpand) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
      isExpand = !isExpand;
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
    //Receiving word data from word_data provider, using index to extract single item from array
    final word =
        Provider.of<Words>(context, listen: false).wordsData[widget.index];
    // print("DEBUG wordCard${word.image}");

    return ExpandableContainer(
      expanded: isExpand,
      child: GestureDetector(
        onTap: () {
          // When we press on WordCard, we pass an id of this WordCard to provider_data,
          // in provider_data Function choosePictureInProvider takes that id and send it to words_data throught
          // Function choosePicture, in that Function check wich id match to WordCard and stosred image in wordCardPicture.
//          word.selectImages(word.id);
          showDialogWindow(context, widget.index);
        },
        child: Container(
          color: kMainColorBackground,
          child: Stack(
            alignment: Alignment.topLeft,
            overflow: Overflow.clip,
            children: <Widget>[
              //Part of speech
              AnimatedPositioned(
                top: 20,
                left: 10,
                duration: Duration(milliseconds: 300),
                key: ValueKey(widget.index),
                child: Text(
                  word.part.part,
                  style: TextStyle(fontSize: 20.0, color: word.part.color),
                ),
              ),

              //Main word container
              AnimatedPositioned(
                left: isExpand ? 50 : 70,
                top: 20,
                duration: Duration(milliseconds: 300),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 120, maxHeight: 60),
                  child: Text(
                    word.targetLang, //Main word
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              // Translation word container
              AnimatedPositioned(
                curve: Curves.easeIn,
                left: isExpand ? 50 : 230,
                top: isExpand ? 60 : 27,
                duration: Duration(milliseconds: 200),
                child: Text(
                  word.ownLang, // Translation
                ),
              ),
              // Arrow Icon
              Positioned(
                left: 350,
                top: 10,
                child: RotationTransition(
                  turns: rotationAnimation,
                  child: Container(
                    child: IconButton(
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        color: isExpand ? Color(0xFF34c7b3) : Colors.black,
                        onPressed: () {
                          runExpandCheck();
                        }),
                  ),
                ),
              ),
              // Container with Word2 and Image
              Positioned(
                  left: 50,
                  top: 90,
                  child: ScaleTransition(
                      scale: animation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Word2
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(word.secondLang)),
                          SizedBox(height: 20),
                          // Image
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: FileImage(word.image),
                                  fit: BoxFit.cover),
                            ),
                            width: 80,
                            height: 80,
                          )
                        ],
                      ))),

              // Example
              Positioned(
                left: 160,
                top: 20,
                child: ScaleTransition(
                  scale: animation,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    width: 180,
                    height: 195,
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
