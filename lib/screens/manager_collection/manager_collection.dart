import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

class ManagerCollection extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _ManagerCollectionState createState() => _ManagerCollectionState();
}

class _ManagerCollectionState extends State<ManagerCollection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return SafeArea(
        // Exclude top from SafeArea
        top: false,
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Collection Name'),
            appBar: AppBar(),
          ),
//        appBar: AppBar(
//          centerTitle: true,
//          backgroundColor: kMainColorBlue,
//          automaticallyImplyLeading: false,
//          title: Text('Collection Name'),
//        ),
          floatingActionButton: ReusableFloatActionButton(
              onPressed: () => Navigator.pushNamed(context, CardCreater.id)),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60.0,
              color: kMainColorBlue,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      width: 90,
                      height: 55,
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, Training.id),
                      )),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: ListView.builder(
              itemCount: providerData.wordsData.length,
              itemBuilder: (context, index) {
                final item = providerData.wordsData[index].mainWordTitle;

                return Dismissible(
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Color(0xFFF8b6b6),
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete),
                    ),
                  ),
                  key: Key(item),
                  direction: DismissDirection.endToStart,
                  child: WordCard(
                    // Here when we prees on word card, a diolog window pops up
                    onTap: () {
                      /* when we prees on WordCard, we pass an id of this WordCard to provider_data,
                          in provider_data Function choosePictureInProvider takes that id and send it to words_data throught 
                          Function choosePicture, in that Function check wich id match to WordCard and stored image in wordCardPicture.
                        */
                      providerData.wordsData[index].choosePictureInProvider(
                          providerData.wordsData[index].id);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            content:
                                StatefulBuilder(builder: (context, setState) {
                              return DialogWindow(
                                // MainWord
                                mainWordTitle:
                                    providerData.wordsData[index].mainWordTitle,
                                isCheckedTitleMainWords: providerData
                                    .wordsData[index].checkMainWordTitle,
                                toggleMainWord: () {
                                  setState(() {
                                    print(providerData
                                        .wordsData[index].checkMainWordTitle);
                                    providerData.togglingMainWord(
                                      providerData.wordsData[index],
                                    );
                                  });
                                },
                                submitMainWord: (value) {
                                  setState(() {
                                    providerData.handleSubmitMainWords(
                                      value,
                                      providerData.wordsData[index],
                                    );
                                  });
                                },

                                // SecondWord
                                secondWordTitle: providerData
                                    .wordsData[index].secondWordTitle,
                                isCheckedSecondWord: providerData
                                    .wordsData[index].checkSecondWordTitle,
                                toggleSecondWord: () {
                                  setState(() {
                                    providerData.togglingSecondWord(
                                      providerData.wordsData[index],
                                    );
                                  });
                                },
                                submitSecondWord: (value) {
                                  providerData.handleSubmitSecondWords(
                                    value,
                                    providerData.wordsData[index],
                                  );
                                },

                                // Translation Word
                                translationTitle: providerData
                                    .wordsData[index].translationTitle,
                                isCheckedTranslation: providerData
                                    .wordsData[index].checkTranslationTitle,
                                toggleTranslation: () {
                                  setState(() {
                                    providerData.togglingTranslation(
                                        providerData.wordsData[index]);
                                  });
                                },
                                submitTranslation: (value) {
                                  setState(() {
                                    providerData.handleSubmitTranslation(
                                        value, providerData.wordsData[index]);
                                  });
                                },

                                // Example
                                isCheckExampleTitle: providerData
                                    .wordsData[index].checkExampleTitle,

                                // WordsPicture
                                wordPicture: providerData
                                    .wordsData[index].wordCardPicture,
                              );
                            }),
                          );
                        },
                      );
                    },
                    //Main word
                    mainWordTitle: providerData.wordsData[index].mainWordTitle,

                    //Second word

                    secondWordTitle:
                        providerData.wordsData[index].secondWordTitle,

                    // Translation
                    translationTitle:
                        providerData.wordsData[index].translationTitle,
                    // WordPicture
                    wordPicture: providerData.wordsData[index].wordCardPicture,
                    showPicture: providerData.wordsData[index].checkShwoPicture,
                    showOrHidePicture: () {
                      providerData.wordsData[index].choosePictureInProvider(
                          providerData.wordsData[index].id);
                      providerData
                          .togglingShowPicture(providerData.wordsData[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

class DialogWindow extends StatelessWidget {
  const DialogWindow({
    this.mainWordTitle,
    this.secondWordTitle,
    this.translationTitle,
    this.wordPicture,
    this.isCheckedTitleMainWords,
    this.isCheckedSecondWord,
    this.isCheckedTranslation,
    this.isCheckExampleTitle,
    this.toggleMainWord,
    this.submitMainWord,
    this.submitSecondWord,
    this.toggleSecondWord,
    this.toggleTranslation,
    this.submitTranslation,
  });
  // MainWord
  final String mainWordTitle;
  final bool isCheckedTitleMainWords;
  final Function toggleMainWord;
  final Function submitMainWord;

  // SecondWord
  final String secondWordTitle;
  final bool isCheckedSecondWord;
  final Function submitSecondWord;
  final Function toggleSecondWord;
  // Translation
  final String translationTitle;
  final bool isCheckedTranslation;
  final Function toggleTranslation;
  final Function submitTranslation;

  final bool isCheckExampleTitle;
  final String wordPicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      width: 380.0,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(wordPicture), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Main word
          DialogTextHolderContainer(
            textTitleName: mainWordTitle,
            fontSize: 20,
            isCheckedTitlNameWords: isCheckedTitleMainWords,
            onPressedEditWordButton: toggleMainWord,
            editingSubmit: submitMainWord,
          ),
          SizedBox(height: 10.0),

          // Second Word
          DialogTextHolderContainer(
            textTitleName: secondWordTitle,
            fontSize: 20,
            isCheckedTitlNameWords: isCheckedSecondWord,
            onPressedEditWordButton: toggleSecondWord,
            editingSubmit: submitSecondWord,
          ),
          SizedBox(height: 10.0),

          // Translation word
          DialogTextHolderContainer(
            textTitleName: translationTitle,
            fontSize: 18.0,
            isCheckedTitlNameWords: isCheckedTranslation,
            onPressedEditWordButton: toggleTranslation,
            editingSubmit: submitTranslation,
          ),
          SizedBox(height: 15.0),

          //Example
          Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text('Example: ', style: TextStyle(fontSize: 7)),
                  ),
                  DialogTextHolderContainer(
                    textTitleName: 'It was an amazing summer',
                    isCheckedTitlNameWords: isCheckExampleTitle,
                  )
                ],
              ))
          // DialogTextHolderContainer(
          //   textTitleName: 'Example: It was an amazing summer',
          //   height: 80,
          //   isCheckedTitlNameWords: isCheckExampleTitle,
          // ),
        ],
      ),
    );
  }
}

class DialogTextHolderContainer extends StatelessWidget {
  DialogTextHolderContainer({
    this.textTitleName,
    this.fontSize,
    this.isCheckedTitlNameWords,
    this.height = 45,
    this.onPressedEditWordButton,
    this.editingSubmit,
  });
  final String textTitleName;
  final double fontSize;
  final bool isCheckedTitlNameWords;
  final double height;
  final Function onPressedEditWordButton;
  final Function editingSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      height: height,
      // width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: !isCheckedTitlNameWords
                  ? TextField(
                      autofocus: true,
                      textAlign: TextAlign.start,
                      controller: TextEditingController(text: textTitleName),
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onSubmitted: editingSubmit,
                    )
                  : SizedBox(
                      width: 200,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          textTitleName,
                          style: TextStyle(fontSize: fontSize),
                        ),
                      ),
                    ),
            ),
            IconButton(
                icon: Icon(Icons.edit), onPressed: onPressedEditWordButton),
          ],
        ),
      ),
    );
  }
}

class WordCard extends StatefulWidget {
  const WordCard({
    this.mainWordTitle,
    this.secondWordTitle,
    this.translationTitle,
    this.onTap,
    this.wordPicture,
    this.showOrHidePicture,
    this.showPicture,
  });

  final Function onTap;
  final String mainWordTitle;
  final String secondWordTitle;
  final String translationTitle;
  final String wordPicture;
  final Function showOrHidePicture;
  final bool showPicture;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF878686),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: Offset(1, 0.5))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Checkbox(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: false,
                          onChanged: null,
                        ),
                      ),
                      //Main word container
                      Container(
                        height: 30,
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(widget.mainWordTitle,
                              style: TextStyle(
                                  fontSize: 25.0, color: Color(0xFFF8b6b6))),
                        ),
                      ),
                    ],
                  ),
                  // Translation word container
                  Expanded(
                    child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(widget.translationTitle)),
                  ),
                  // Picture
                  GestureDetector(
                    onTap: widget.showOrHidePicture,
                    child: widget.showPicture
                        ? Icon(Icons.image)
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(widget.wordPicture),
                                  fit: BoxFit.cover),
                            ),
                            // padding: EdgeInsets.all(0),
                            width: 48,
                            height: 48,
                          ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
