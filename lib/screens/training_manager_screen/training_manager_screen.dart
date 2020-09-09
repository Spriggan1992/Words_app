import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/models/collection.dart';

import 'package:words_app/models/difficulty.dart';
import 'package:words_app/models/fuiltersEnums.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/games/bricks_game.dart';
import 'package:words_app/screens/games/correct_wrong_game.dart';

import 'package:words_app/utils/size_config.dart';

import 'components/title_text_holder.dart';

class TrainingManager extends StatefulWidget {
  static String id = 'training_manager_screen';

  @override
  _TrainingManagerState createState() => _TrainingManagerState();
}

class _TrainingManagerState extends State<TrainingManager> {
  bool isChecked = false;
  List<Collection> selectedListCollections = [];
  List<String> dummySilectedCips = [
    'first collection',
    'body',
    'verbs',
    'noun',
    'nothing iteresting'
  ];
  int selectedDifficulty = 3;
  FilterGames selectedGames;
  String dropdownValue = 'Collection';

  List<Difficulty> difficulty = DifficultyList().difficultyList;

  List<IconData> iconsList = [
    Icons.fitness_center,
    Icons.directions_bike,
    Icons.photo_album,
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    List<Word> words = args['words'];

    return BlocBuilder<TrainingsBloc, TrainingsState>(
      builder: (context, state) {
        if (state is TrainingsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TrainingsSuccess) {
          return Scaffold(
            backgroundColor: Color(0xFFeae2da),
            appBar: BaseAppBar(
              title: Text('Training Manager'),
              appBar: AppBar(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Main container with all content on the page
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleTextHolder(title: '1. I want to play ...'),
                        buildGamesBtns(defaultSize, state, context),
                        TitleTextHolder(
                            title: '3. I want to use words from ...'),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: defaultSize * 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 3,
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: Text('Choose collections'),
                                    trailing: Icon(Icons.arrow_drop_down),
                                    visualDensity: VisualDensity.compact,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Select Colletions'),
                                              // contentPadding: EdgeInsets.all(
                                              //     defaultSize * 0.8),
                                              content: StatefulBuilder(
                                                builder: (context, setState) {
                                                  return Container(
                                                    height: defaultSize * 30,
                                                    width: SizeConfig
                                                            .blockSizeHorizontal *
                                                        70,
                                                    child: ListView.builder(
                                                      itemExtent:
                                                          defaultSize * 5,
                                                      // shrinkWrap: true,
                                                      itemCount: state
                                                          .listCollection
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CollectionPicker(
                                                          selectedList:
                                                              selectedListCollections,
                                                          state: state,
                                                          index: index,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              if (value) {
                                                                selectedListCollections
                                                                    .add(state
                                                                            .listCollection[
                                                                        index]);
                                                              } else {
                                                                selectedListCollections
                                                                    .remove(state
                                                                            .listCollection[
                                                                        index]);
                                                              }
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                              actions: [
                                                FlatButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text('Cancel'),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .bloc<TrainingsBloc>()
                                                        .add(TrainingsSelectCollections(
                                                            collection:
                                                                selectedListCollections));
                                                  },
                                                  child: Text('Ok'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 3,
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      // alignment: WrapAlignment.center,
                                      // crossAxisAlignment:
                                      //     WrapCrossAlignment.center,
                                      // direction: Axis.vertical,
                                      children:
                                          selectedListCollections.map((item) {
                                        return FittedBox(
                                          child: Chip(
                                            label: Text(item.title,
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        TitleTextHolder(
                            title: '2. I want to study words that I ...'),
                        buildDifficultiesBtns(defaultSize, context, state),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Checkbox(value: false, onChanged: null),
                //     Text('remember my choice'),
                //   ],
                // ),
                SizedBox(height: defaultSize * 2),

                //  Button-container
                Container(
                  child: ReusableMainButton(
                    titleText: 'Go to Trainig',
                    textColor: Colors.black,
                    backgroundColor: Theme.of(context).accentColor,
                    onPressed: () async {
                      if (state.filterGames == FilterGames.bricks) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Matches(
                                  // words: state.filteredListWords,
                                  ),
                            ));
                      }
                      if (state.filterGames == FilterGames.wrongCorrect) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CorrectWrong(
                                  // words: state.filteredListWords,
                                  ),
                            ));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Text('Somthing went wrong....');
      },
    );
  }

  Widget buildGamesBtns(
      double defaultSize, TrainingsSuccess state, BuildContext context) {
    return Container(
        // child: GamesBtns(),
        child: Row(
      children: FilterGames.values.map((item) {
        for (var i = 0; i < iconsList.length - 1; i++) {
          return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: ChoiceChip(
              backgroundColor: Colors.white,
              labelPadding: EdgeInsets.all(defaultSize * 0.8),
              selectedColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultSize * 0.5)),
              elevation: 5,
              label: Container(
                alignment: Alignment.center,
                width: defaultSize * 3,
                height: defaultSize * 3,
                child: Icon(
                  iconsList[item.index],
                  color: Colors.black,
                  size: defaultSize * 3,
                ),
              ),
              selected: state.filterGames == item,
              onSelected: (selected) {
                selectedGames = item;
                context.bloc<TrainingsBloc>().add(TrainingsFilteredDifficulties(
                    difficulty: selectedDifficulty, games: selectedGames));
              },
            ),
          );
        }
      }).toList(),
    ));
  }

  Container buildDifficultiesBtns(
      double defaultSize, BuildContext context, TrainingsSuccess state) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: difficulty.map((item) {
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ChoiceChip(
            elevation: 5,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
            label: Text(item.name),
            labelStyle: TextStyle(
                fontSize: defaultSize * 1.6,
                color: Colors.black,
                fontWeight: FontWeight.w900),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultSize * 0.5),
            ),
            backgroundColor: item.color,
            selectedColor: state.difficulty == 3 ? item.color : Colors.grey,
            selected: state.difficulty == item.difficulty,
            onSelected: (selected) {
              selectedDifficulty == item.difficulty
                  ? selectedDifficulty = 3
                  : selectedDifficulty = item.difficulty;
              context.bloc<TrainingsBloc>().add(TrainingsFilteredDifficulties(
                  difficulty: selectedDifficulty, games: selectedGames));
            },
          ),
        );
      }).toList(),
    ));
  }
}

class CollectionPicker extends StatelessWidget {
  const CollectionPicker({
    this.state,
    this.index,
    this.onChanged,
    this.selectedList,
    Key key,
  }) : super(key: key);

  final TrainingsSuccess state;
  final int index;
  final Function onChanged;
  final List selectedList;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(state.listCollection[index].title),
        value: selectedList.contains(state.listCollection[index]),
        onChanged: onChanged);
  }
}
