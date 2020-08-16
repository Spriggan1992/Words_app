import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
import 'components/body.dart';
import 'components/word_card.dart';

class WordsScreen extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Words>(context, listen: false);
    bool isEditingMode = providerData.isEditingMode;
    bool isSelected = providerData.isSelected;
    // bool isEditingMode = false;
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    String collectionTitle = args['title'];

    return SafeArea(
      // Exclude top from SafeArea
      top: true,
      child: Scaffold(
        backgroundColor: Color(0xFFeae2da),
        appBar: AppBar(
          backgroundColor:
              isEditingMode ? Colors.grey[500] : Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: isEditingMode ? Text('') : Text('$collectionTitle'),
          actions: <Widget>[
            isEditingMode
                ? IconButton(onPressed: () {}, icon: Icon(Icons.close))
                : IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      await Provider.of<Words>(context, listen: false)
                          .populateList(collectionId);
                    },
                  )
          ],
        ),
        // Use future builder because when using fetch data it returns future
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CardCreator(
                      editMode: false, collectionId: collectionId, index: 0))),
          // Navigator.pushNamed(context, CardCreator.id,
          //     arguments: {'id': collectionId, 'editMode': false}),
        ),

        bottomNavigationBar: BaseBottomAppBar(
          child1: ReusableBottomIconBtn(
            icons: Icons.keyboard_arrow_left,
            color: kMainColorBackground,
            onPress: () => Navigator.pop(context),
          ),
          child2: Row(
            children: [
              ReusableBottomIconBtn(
                icons: Icons.fitness_center,
                color: kMainColorBackground,
                onPress: () => Navigator.pushNamed(context, TrainingManager.id,
                    arguments: {'id': collectionId}),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: FutureBuilder(
          future: Provider.of<Words>(context, listen: false)
              .fetchAndSetWords(collectionId),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.only(bottom: 25.0),
                      // Here we render only listView
                      child: Consumer<Words>(
                        builder: (context, providerData, child) {
                          return AnimationLimiter(
                            child: ListView.builder(
                              // itemExtent: 100,
                              itemCount: providerData.wordsData.length,
                              // semanticChildCount: 1,
                              itemBuilder: (context, index) {
                                /// Call conformation for removing word from collection
                                void removeWord() {
                                  providerData.removeWord(
                                      providerData.wordsData[index]);
                                  Navigator.of(context).pop(true);
                                }

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 400),
                                  child: SlideAnimation(
                                    verticalOffset: 44.0,
                                    child: FadeInAnimation(
                                      child: Slidable(
                                        key: UniqueKey(),
                                        child: WordCard(
                                          isEditingMode: isEditingMode,
                                          index: index,
                                          isSelected: isSelected,
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
                                                          builder: (context) =>
                                                              CardCreator(
                                                                index: index,
                                                                editMode: true,
                                                                collectionId:
                                                                    collectionId,
                                                                targetWord: providerData
                                                                    .wordsData[
                                                                        index]
                                                                    .targetLang,
                                                                secondWord: providerData
                                                                    .wordsData[
                                                                        index]
                                                                    .secondLang,
                                                                ownWord: providerData
                                                                    .wordsData[
                                                                        index]
                                                                    .ownLang,
                                                                thirdWord: providerData
                                                                    .wordsData[
                                                                        index]
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
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
        ), // Body
      ),
    );
  }
}
