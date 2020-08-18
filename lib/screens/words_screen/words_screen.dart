import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creator_screen//card_creator.dart';
import 'package:words_app/screens/training_manager_screen/training_manager_screen.dart';
import 'package:words_app/utils/size_config.dart';
import 'components/word_card.dart';

class WordsScreen extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  List selectedData = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final providerData = Provider.of<Words>(context, listen: false);
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    String collectionTitle = args['title'];

    return SafeArea(
      // Exclude top from SafeArea
      top: true,
      child: Scaffold(
        backgroundColor: Color(0xFFeae2da),
        appBar: BaseAppBar(
          backgroundColor: providerData.isEditingMode
              ? Colors.grey[500]
              : Theme.of(context).primaryColor,
          title:
              providerData.isEditingMode ? Text('') : Text('$collectionTitle'),
          actions: <Widget>[
            providerData.isEditingMode
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            providerData.toogleAllSelectedWords();
                            providerData.addItemInList();
                            print(providerData.selectedData.length);
                          },
                          icon: Icon(Icons.select_all)),
                      // Stack(
                      //   alignment: Alignment.topRight,
                      //   children: [
                      IconButton(
                          onPressed: () {
                            setState(() {});
                            providerData.removeSelectedWords();
                            providerData.clearSelectedData();
                          },
                          icon: Icon(Icons.delete)),
                      //     Positioned(
                      //       child: Text(
                      //           providerData.selectedData.length.toString()),
                      //     ),
                      //   ],
                      // ),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                            for (int i = 0;
                                i < providerData.wordsData.length;
                                i++) {
                              providerData.wordsData[i].isSelected = false;
                            }
                            providerData.isEditingMode = false;
                            providerData.clearSelectedData();
                          },
                          icon: Icon(Icons.close)),
                    ],
                  )
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      await Provider.of<Words>(context, listen: false)
                          .populateList(collectionId);
                    },
                  )
          ],
          appBar: AppBar(),
        ),
        // Use future builder because when using fetch data it returns future
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () {
            setState(() {});
            providerData.isEditingMode = false;
            providerData.clearSelectedData();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CardCreator(
                          editMode: false,
                          collectionId: collectionId,
                          index: 0,
                        )));
          },
          // Navigator.pushNamed(context, CardCreator.id,
          //     arguments: {'id': collectionId, 'editMode': false}),
        ),

        bottomNavigationBar: BaseBottomAppBar(
          child1: ReusableBottomIconBtn(
            icons: Icons.keyboard_arrow_left,
            color: kMainColorBackground,
            onPress: () {
              Navigator.pop(context);
              providerData.isEditingMode = false;
              providerData.clearSelectedData();
            },
          ),
          child2: Row(
            children: [
              ReusableBottomIconBtn(
                  icons: Icons.fitness_center,
                  color: kMainColorBackground,
                  onPress: () {
                    Navigator.pushNamed(context, TrainingManager.id,
                        arguments: {
                          'id': collectionId,
                          'selectedWords': providerData.selectedData.isEmpty
                              ? providerData.wordsData
                              : providerData.selectedData
                        });
                    providerData.isEditingMode = false;
                    setState(() {});
                  }),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: FutureBuilder(
          future: Provider.of<Words>(context, listen: false)
              .fetchAndSetWords(collectionId),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.only(bottom: 25.0),
                  // Here we render only listView
                  child: Consumer<Words>(
                    builder: (context, providerData, child) {
                      return ListView.builder(
                        // itemExtent: 100,
                        itemCount: providerData.wordsData.length,
                        // semanticChildCount: 1,
                        itemBuilder: (context, index) {
                          /// Call conformation for removing word from collection
                          void removeWord() {
                            setState(() {
                              providerData
                                  .removeWord(providerData.wordsData[index]);
                              Navigator.of(context).pop(true);
                            });
                          }

                          return Slidable(
                            enabled: providerData.isEditingMode ? false : true,

                            /// WORD CARD
                            child: WordCard(
                              toggleIsSelection: () {
                                setState(() {
                                  providerData.isEditingMode = true;
                                });
                              },
                              index: index,
                              selectedData: selectedData,
                            ),
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                  caption: 'Edit',
                                  color: Colors.black45,
                                  icon: Icons.edit,
                                  onTap: () =>
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   CardCreator.id,
                                      //   arguments: {
                                      //     'id': collectionId,
                                      //     'index': index,
                                      //     'editMode': true,
                                      //   },
                                      // ),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CardCreator(
                                                    index: index,
                                                    editMode: true,
                                                    collectionId: collectionId,
                                                    targetWord: providerData
                                                        .wordsData[index]
                                                        .targetLang,
                                                    secondWord: providerData
                                                        .wordsData[index]
                                                        .secondLang,
                                                    ownWord: providerData
                                                        .wordsData[index]
                                                        .ownLang,
                                                    thirdWord: providerData
                                                        .wordsData[index]
                                                        .thirdLang,
                                                  )))),
                              IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () => deleteConfirmation(
                                      context,
                                      removeWord,
                                      'Do you want to delete this word?')),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
