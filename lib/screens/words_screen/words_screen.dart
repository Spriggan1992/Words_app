import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:words_app/bloc/words/words_bloc.dart';

import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/cubit/card_creator/part_color/part_color_cubit.dart';

import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/word.dart';

import 'package:words_app/repositories/words_repository.dart';
import 'package:words_app/screens/card_creator_screen/card_creator.dart';

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Fake Appbar
                      buildAppBar(isEditingMode, context, collectionTitle,
                          providerData, collectionId, state),

                      /// List words
                      buildListView(state, isEditingMode, collectionId),

                      ReusableMainButton(
                        titleText: 'Add Word',
                        textColor: Colors.white,
                        backgroundColor: Theme.of(context).accentColor,
                        onPressed: () {
                          Navigator.pushNamed(context, CardCreator.id,
                              arguments: {
                                'isEditingMode': false,
                                'collectionId': collectionId
                              });
                        },
                      ),
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

  Expanded buildListView(
      WordsSuccess state, bool isEditingMode, String collectionId) {
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
                ), //
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: <Widget>[
                  IconSlideAction(
                      caption: 'Edit',
                      color: Colors.black45,
                      icon: Icons.edit,
                      onTap: () {
                        Navigator.pushNamed(context, CardCreator.id,
                            arguments: {
                              'isEditingMode': true,
                              'word': state.words[index],
                              'collectionId': collectionId
                            });
                        context
                            .bloc<PartColorCubit>()
                            .changeColor(state.words[index].part.partColor);
                      }),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
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
          )),
    );
  }

  Container buildAppBar(
    bool isEditingMode,
    BuildContext context,
    String collectionTitle,
    WordsRepository providerData,
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
                          context.bloc<WordsBloc>().add(WordsToggledAll());
                          context
                              .bloc<WordsBloc>()
                              .add(WordsAddSelectedAllToSelectedList());
                        },
                        icon: Icon(Icons.select_all)),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                            onPressed: () => deleteConfirmation(context, () {
                                  BlocProvider.of<WordsBloc>(context)
                                      .add(WordsDeletedSelectedAll());
                                  Navigator.pop(context);
                                }, 'Do you want to delete this word?'),
                            icon: Icon(Icons.delete)),
                        Positioned(
                          child: Text("${state.selectedList?.length ?? 0}"),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<WordsBloc>(context)
                                  .add(WordsDeletedSelectedAll());
                            },
                            icon: Icon(Icons.fitness_center)),
                        Positioned(
                          child: Text("${state.selectedList?.length ?? 0}"),
                        ),
                      ],
                    ),
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
                              BlocProvider.of<WordsBloc>(context)
                                  .add(WordsDeletedSelectedAll());
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
                      onPressed: () async {
                        await Provider.of<WordsRepository>(context,
                                listen: false)
                            .populateList(collectionId);
                      },
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
