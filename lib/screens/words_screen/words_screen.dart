import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words_repository.dart';
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final providerData = Provider.of<WordsRepository>(context, listen: false);
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    String collectionTitle = args['title'];

    return SafeArea(
      // Exclude top from SafeArea
      top: true,
      child: Scaffold(
        backgroundColor: Color(0xFFeae2da),

        // Use future builder because when using fetch data it returns future
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () {
            // setState(() {});
            // providerData.isEditingMode = false;
            // providerData.clearSelectedData();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardCreator(
                  editMode: false,
                  collectionId: collectionId,
                  index: 0,
                ),
              ),
            );
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
                    // providerData.isEditingMode = false;
                    setState(() {});
                  }),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BlocBuilder<WordsBloc, WordsState>(
          builder: (context, state) {
            if (state is WordsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WordsSuccess) {
              /// Use cubit to switch editing mode(For selecting words);
              return BlocBuilder<WordsCubit, bool>(
                builder: (context, isEditingMode) {
                  return Column(
                    children: [
                      /// Fake Appbar
                      buildAppBar(isEditingMode, context, collectionTitle,
                          providerData, collectionId, state.selectedList),

                      /// List words
                      buildListView(state, isEditingMode),
                    ],
                  );
                },
              );
            } else {
              Text('Somthing went wrong....');
            }
          },
        ),
      ),
    );
  }

  Expanded buildListView(WordsSuccess state, bool isEditingMode) {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(bottom: 25.0),
          // Here we render only listView
          child: ListView.builder(
            // itemExtent: 100,
            itemCount: state.words.length,
            // semanticChildCount: 1,
            itemBuilder: (context, index) {
              /// Call conformation for removing word from collection
              // void removeWord() {
              //   setState(() {
              //     providerData
              //         .removeWord(providerData.wordsData[index]);
              //     Navigator.of(context).pop(true);
              //   });
              // }

              return Slidable(
                enabled: isEditingMode ? false : true,

                /// WORD CARD
                // child: Text(state.words[index].targetLang),
                child: WordCard(
                  isEditingMode: isEditingMode,
                  // isEditingMode: state.isEditMode,
                  toggleIsSelection: () {
                    // setState(() {
                    //   providerData.isEditingMode = true;
                    // });
                  },
                  index: index,
                  selectedList: state.selectedList,
                  word: state.words[index],
                ), //
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Edit',
                      color: Colors.black45,
                      icon: Icons.edit,
                      onTap: () {}
                      // Navigator.pushNamed(
                      //   context,
                      //   CardCreator.id,
                      //   arguments: {
                      //     'id': collectionId,
                      //     'index': index,
                      //     'editMode': true,
                      //   },
                      // ),
                      //     Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CardCreator(
                      //       index: index,
                      //       editMode: true,
                      //       collectionId: collectionId,
                      //       targetWord:
                      //           providerData.wordsData[index].targetLang,
                      //       secondWord:
                      //           providerData.wordsData[index].secondLang,
                      //       ownWord:
                      //           providerData.wordsData[index].ownLang,
                      //       thirdWord:
                      //           providerData.wordsData[index].thirdLang,
                      //     ),
                      //   ),
                      // ),

                      ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => deleteConfirmation(context, () {
                      BlocProvider.of<WordsBloc>(context)
                          .add(WordsDeleted(word: state.words[index]));
                      Navigator.pop(context);
                    }, 'Do you want to delete this word?'),
                  )
                ],
              );
            },
          )),
    );
  }

  Container buildAppBar(
    bool isEditingMode,
    BuildContext context,
    String collectionTitle,
    WordsRepository providerData,
    String collectionId,
    List<Word> selectedData,
  ) {
    return Container(
      color: isEditingMode ? Colors.grey[500] : Theme.of(context).primaryColor,
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.defaultSize * 6,
      child: Stack(
        alignment: Alignment.centerRight,
        children: <Widget>[
          Align(
            child: isEditingMode
                ? Text('')
                : Text(
                    "$collectionTitle",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      fontFamily: 'Anybody',
                    ),
                  ),
          ),
          isEditingMode
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          context.bloc<WordsBloc>().add(WordsSelectedAll());
                          context.bloc<WordsBloc>().add(WordsAddSelectedAll());
                        },
                        icon: Icon(Icons.select_all)),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<WordsBloc>(context)
                                  .add(WordsDeletedSelectedAll());
                            },
                            icon: Icon(Icons.delete)),
                        Positioned(
                          child: Text(
                              // providerData.selectedData.length.toString(),
                              "${selectedData?.length ?? 0}"),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<WordsCubit>(context).toggleEditMode();
                        },
                        icon: Icon(Icons.close)),
                  ],
                )
              : IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await Provider.of<WordsRepository>(context, listen: false)
                        .populateList(collectionId);
                  },
                )
        ],
      ),
    );
  }
}
