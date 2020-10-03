import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:words_app/bloc/card_creator/card_creator_bloc.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/widgets/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/cubit/card_creator/part_color/part_color_cubit.dart';
import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/repositories/words/words_repository.dart';
import 'package:words_app/screens/card_creator_screen/card_creator.dart';
import 'package:words_app/screens/collections_screen/collections_screen.dart';
import 'package:words_app/screens/training_manager_screen/training_manager_screen.dart';
import 'package:words_app/utils/size_config.dart';
import 'components/word_card.dart';

class WordsScreen extends StatelessWidget {
  static String id = 'collection_manager_screen';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    String collectionTitle = args['title'];
    String collectionLang = args['lang'];

    return WillPopScope(
      /// Overriding Back navigation logic --> exit from EditMode
      onWillPop: () async {
        context.bloc<WordsCubit>().toggleEditModeToFalse();
        context.bloc<WordsBloc>().add(WordsTurnOffIsEditingMode());
        Navigator.pushNamedAndRemoveUntil(context, CollectionsScreen.id,
            ModalRoute.withName(CollectionsScreen.id));
        return;
      },
      child: SafeArea(
        // Exclude top from SafeArea
        top: true,
        child: Scaffold(
          // backgroundColor: Theme.of(context).backgroundColor,
          body: BlocBuilder<WordsBloc, WordsState>(
            builder: (context, state) {
              if (state is WordsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WordsSuccess) {
                /// Use cubit to switch editing mode(For selecting words);
                return buildBody(
                    collectionTitle, collectionId, state, collectionLang);
              }
              return Text('Somthing went wrong....');
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(String collectionTitle, String collectionId,
      WordsSuccess state, String collectionLang) {
    return Container(
      child: BlocBuilder<WordsCubit, bool>(
        builder: (context, isEditingMode) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Fake Appbar
              buildAppBar(
                  isEditingMode, context, collectionTitle, collectionId, state),

              /// List words
              buildListView(state, isEditingMode, collectionId, collectionLang),

              ReusableMainButton(
                titleText: 'Add Word',
                textColor: Colors.white,
                backgroundColor: Theme.of(context).buttonColor,
                onPressed: isEditingMode
                    ? () {}
                    : () {
                        Navigator.pushNamed(
                          context,
                          CardCreator.id,
                          arguments: {
                            'isEditingMode': false,
                            'collectionId': collectionId,
                            'lang': collectionLang,
                          },
                        );
                        context.bloc<CardCreatorBloc>().add(CardCreatorLoaded(
                            word: Word(),
                            isEditingMode: false,
                            collectionLaguage: collectionLang));
                      },
              ),
            ],
          );
        },
      ),
    );
  }

  Expanded buildListView(WordsSuccess state, bool isEditingMode,
      String collectionId, String collectionLang) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 25.0),
        // Here we render only listView
        child: ListView.builder(
          // itemExtent: 100,
          itemCount: state.words.length,
          // semanticChildCount: 1,
          itemBuilder: (context, index) {
            return Slidable(
              enabled: isEditingMode ? false : true,

              /// WORD CARD

              child: WordCard(
                isEditingMode: isEditingMode,
                index: index,
                selectedList: state.selectedList,
                word: state.words[index],
                words: state.words,
              ), //
              actionPane: SlidableDrawerActionPane(),

              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.black26,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CardCreator.id,
                      arguments: {
                        'isEditingMode': true,
                        'word': state.words[index],
                        'collectionId': collectionId,
                      },
                    );
                    context
                        .bloc<PartColorCubit>()
                        .changeColor(state.words[index].part.partColor);
                    context.bloc<CardCreatorBloc>().add(
                          CardCreatorLoaded(
                              word: state.words[index],
                              isEditingMode: true,
                              collectionLaguage: collectionLang),
                        );
                  },
                ),
                IconSlideAction(
                  
                  caption: 'Delete',
                  color: Theme.of(context).accentColor,
                  icon: Icons.delete,
                  onTap: () => deleteConfirmation(context, () {
                    context
                        .bloc<WordsBloc>()
                        .add(WordsDeleted(word: state.words[index]));
                    Navigator.pop(context);
                  }, 'Do you want to delete this word?'),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildAppBar(
    bool isEditingMode,
    BuildContext context,
    String collectionTitle,
    String collectionId,
    WordsSuccess state,
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
                    "${collectionTitle ?? ''}",
                    style: kAppBarTextStyle,
                  ),
          ),
          isEditingMode
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text("${state.selectedList?.length ?? 0}",
                          style: TextStyle(
                              fontSize: SizeConfig.defaultSize * 1.8)),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          context.bloc<WordsBloc>().add(WordsToggledAll());
                          context
                              .bloc<WordsBloc>()
                              .add(WordsAddSelectedAllToSelectedList());
                        },
                        icon: Icon(Icons.select_all)),
                    // Stack(
                    //   alignment: Alignment.topRight,
                    //   children: [
                    IconButton(
                        onPressed: () => deleteConfirmation(context, () {
                              BlocProvider.of<WordsBloc>(context)
                                  .add(WordsDeletedSelectedAll());
                              Navigator.pop(context);
                            }, 'Do you want to delete this word?'),
                        icon: Icon(Icons.delete)),
                    //   Positioned(
                    //     child: Text("${state.selectedList?.length ?? 0}"),
                    //   ),
                    // ],
                    // ),
                    // Stack(
                    //   alignment: Alignment.topRight,
                    //   children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            TrainingManager.id,
                            arguments: {'words': state.selectedList},
                          );
                        },
                        icon: Icon(Icons.fitness_center)),
                    // Positioned(
                    //   child: Text("${state.selectedList?.length ?? 0}"),
                    // ),
                    // ],
                    // ),
                    IconButton(
                        onPressed: () {
                          context.bloc<WordsCubit>().toggleEditMode();
                          context
                              .bloc<WordsBloc>()
                              .add(WordsTurnOffIsEditingMode());
                        },
                        icon: Icon(Icons.close)),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                            onPressed: () {
                              context.bloc<TrainingsBloc>().add(TrainingsLoaded(
                                  words: state.words,
                                  collectionId: collectionId));
                              Navigator.pushNamed(
                                context,
                                TrainingManager.id,
                                arguments: {'words': state.words},
                              );
                            },
                            icon: Icon(
                              Icons.fitness_center,
                              color: Colors.white,
                            )),
                        Positioned(
                          child: Text("${state.words?.length ?? 0}",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //FIXME: Temp used to populate words  delete it later
                        context
                            .bloc<WordsBloc>()
                            .add(WordsPopulate(id: collectionId));
                        context
                            .bloc<WordsBloc>()
                            .add(WordsLoaded(id: collectionId));
                      },
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
