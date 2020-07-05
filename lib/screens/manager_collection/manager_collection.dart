import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/provier_data.dart';
import 'package:provider/provider.dart';
import 'components/reusable_text_container.dart';
import 'components/reusable_text_field_container.dart';

class ManagerCollection extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _ManagerCollectionState createState() => _ManagerCollectionState();
}

class _ManagerCollectionState extends State<ManagerCollection> {
  @override
  Widget build(BuildContext context) {
    // bool isCheckedSecondWord = true;

    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColorBlue,
          automaticallyImplyLeading: false,
          title: Text('Collection Name'),
        ),
        floatingActionButton: ReusableFloatActionButton(),
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
                    padding: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    )),
                Container(
                    padding: EdgeInsets.only(right: 30, bottom: 30),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.fitness_center,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    )),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: providerData.wordsData.length,
            itemBuilder: (context, index) {
              final item = providerData.wordsData[index].mainWordTitle;

              // final item = temporaryData[index];
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
                    //Main word

                    titleMainWords: providerData.wordsData[index].mainWordTitle,
                    isCheckedTitleMainWords:
                        providerData.wordsData[index].checkMainWordTitle,
                    toggleMainWord: () {
                      providerData.togglingMainWord(
                        providerData.wordsData[index],
                      );
                    },
                    submitMainWord: (value) {
                      providerData.handleSubmitMainWords(
                        value,
                        providerData.wordsData[index],
                      );
                    },

                    //Second word
                    isCheckedSecondWord:
                        providerData.wordsData[index].checkSecondWordTitle,
                    secondWordTitle:
                        providerData.wordsData[index].secondWordTitle,
                    handleSubmitSecondWord: (value) {
                      providerData.handleSubmitSecondWords(
                        value,
                        providerData.wordsData[index],
                      );
                    },
                    toggleSecondWords: () {
                      providerData.togglingSecondWord(
                        providerData.wordsData[index],
                      );
                    },

                    //translation
                    translationTitle:
                        providerData.wordsData[index].translationTitle,
                    isCheckedTranslation:
                        providerData.wordsData[index].checkTranslationTitle,
                    toggleTranslation: () {
                      providerData
                          .togglingTranslation(providerData.wordsData[index]);
                    },
                    handleSubmitTranslation: (value) {
                      providerData.handleSubmitTranslation(
                          value, providerData.wordsData[index]);
                    }),
              );
            },
          ),
        ),
      );
    });
  }
}

class WordCard extends StatefulWidget {
  const WordCard({
    this.isCheckedSecondWord,
    this.toggleMainWord,
    this.titleMainWords,
    this.submitMainWord,
    this.isCheckedTitleMainWords,
    this.secondWordTitle,
    this.handleSubmitSecondWord,
    this.toggleSecondWords,
    this.translationTitle,
    this.isCheckedTranslation,
    this.toggleTranslation,
    this.handleSubmitTranslation,
  });

  final String titleMainWords;
  final bool isCheckedTitleMainWords;
  final Function submitMainWord;
  final Function toggleMainWord;

  //secondWordTitle
  final String secondWordTitle;
  final bool isCheckedSecondWord;
  final Function handleSubmitSecondWord;
  final Function toggleSecondWords;

  //translation
  final String translationTitle;
  final bool isCheckedTranslation;
  final Function toggleTranslation;
  final Function handleSubmitTranslation;
  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: widget.toggleMainWord,
                          child: !widget.isCheckedTitleMainWords
                              ? ReusableTextFieldContainer(
                                  height: 50,
                                  width: 100,
                                  handleSubmit: widget.submitMainWord,
                                  fontSize: 25.0,
                                  color: Color(0xFFF8b6b6),
                                )
                              : ReusableTextContainer(
                                  height: 30,
                                  width: 100,
                                  title: widget.titleMainWords,
                                  fontSize: 25.0,
                                  color: Color(0xFFF8b6b6),
                                ),
                        ),
                        GestureDetector(
                          onTap: widget.toggleSecondWords,
                          child: widget.isCheckedSecondWord
                              ? Container(
                                  child: Text(widget.secondWordTitle),
                                )
                              : ReusableTextFieldContainer(
                                  title: widget.secondWordTitle,
                                  handleSubmit: widget.handleSubmitSecondWord,
                                  width: 100,
                                ),
                        ),
                        Container(
                          child: FittedBox(
                              alignment: Alignment.center,
                              child: Text('50%',
                                  style: TextStyle(
                                      fontSize: 3.0,
                                      color: Colors.red.withOpacity(0.5)))),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.5, 0.5],
                                colors: [Colors.green, Color(0xFFf0f3f8)],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: GestureDetector(
                            onTap: widget.toggleTranslation,
                            child: widget.isCheckedTranslation
                                ? ReusableTextContainer(
                                    height: 25,
                                    width: 230,
                                    title: widget.translationTitle,
                                    fontSize: 15.0,
                                    color: Color(0xFFc9c97e),
                                  )
                                : ReusableTextFieldContainer(
                                    title: widget.translationTitle,
                                    fontSize: 15.0,
                                    color: Color(0xFFc9c97e),
                                    width: 220,
                                    handleSubmit:
                                        widget.handleSubmitTranslation)),
                      ),
                      Checkbox(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: false,
                        onChanged: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
