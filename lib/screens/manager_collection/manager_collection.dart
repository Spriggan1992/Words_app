import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:provider/provider.dart';
import 'components/reusable_text_container.dart';
import 'components/reusable_text_field_container.dart';
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
                      // Here when we prees on word card, a diolog windo pops up
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Container(
                                  height: 400.0,
                                  width: 360.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 30),
                                    child: Column(
                                      children: <Widget>[
                                        DialogTextHolderContainer(
                                            textTitleName: 'Summer'),
                                        SizedBox(height: 15.0),
                                        DialogTextHolderContainer(
                                            textTitleName: '夏天'),
                                        SizedBox(height: 15.0),
                                        DialogTextHolderContainer(
                                            textTitleName: 'Лето'),
                                        SizedBox(height: 20.0),
                                        DialogTextHolderContainer(
                                            textTitleName:
                                                'Example: It was an amazing summer'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      //Main word
                      titleMainWords:
                          providerData.wordsData[index].mainWordTitle,
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
        ),
      );
    });
  }
}

class DialogTextHolderContainer extends StatelessWidget {
  DialogTextHolderContainer({this.textTitleName});
  final String textTitleName;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Text(textTitleName, style: TextStyle(fontSize: 25)),
            ),
            IconButton(icon: Icon(Icons.edit), onPressed: null),
          ],
        ),
      ),
    );
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
    this.onTap,
  });

  final Function onTap;
  //MainWord
  final String titleMainWords;
  final bool isCheckedTitleMainWords;
  final Function submitMainWord;
  final Function toggleMainWord;

  //secondWord
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
                                  title: widget.titleMainWords,
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
