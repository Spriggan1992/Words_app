import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';
import 'components/word_card.dart';
import 'package:words_app/screens/manager_collection/components/dialog_window.dart';

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
                      /*  when we prees on WordCard, we pass an id of this WordCard to provider_data,
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
                                // Pass wain word title in DialogWindow
                                mainWordTitle:
                                    providerData.wordsData[index].mainWordTitle,
                                // Pass bool in DialogWindow, for editing title name
                                isCheckedTitleMainWords: providerData
                                    .wordsData[index].checkMainWordTitle,
                                /* Toogle checkMainWordTitle(from words_data), if true {show just a text}, 
                                   if false {show Text field for editing title name} */
                                toggleMainWord: () {
                                  setState(() {
                                    providerData.togglingMainWord(
                                      providerData.wordsData[index],
                                    );
                                  });
                                },

                                /*  Handle value of Text field, send it value to Function handleSubmitMainWords 
                                    in provider_data, in handleSubmitMainWords pass this value to changeMainWordTitle 
                                    in words_data and store this value in mainWordTitle. */
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

                    /* When we press IconBotton is DialogTextHolderContainer, we pass an id of this WordCard to provider_data,
                          in provider_data Function choosePictureInProvider takes that id and send it to words_data throught 
                          Function choosePicture, in that Function check wich id match to WordCard and stored image 
                          in wordCardPicture.*/
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
