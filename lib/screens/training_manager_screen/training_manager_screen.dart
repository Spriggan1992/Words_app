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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<bool> confirm;
  List<int> selectedDifficulties = [];
  FilterGames selectedGames = FilterGames.bricks;
  List<Collection> dummyFilteredListCollection;

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
          // Varibal that contains Filtered List of Collections
          List<Collection> selectedListCollections =
              state.filteredListCollections;
          return Scaffold(
            key: _scaffoldKey,
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
                            title: '2. I want to use words from ...'),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: defaultSize * 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: Text('Choose collections',
                                        style: TextStyle(fontSize: 12)),
                                    trailing: Icon(Icons.arrow_drop_down),
                                    visualDensity: VisualDensity.compact,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Select Colletions',
                                                textAlign: TextAlign.center,
                                              ),
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
                                                          .listCollections
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CheckboxListTile(
                                                          title: Text(state
                                                              .listCollections[
                                                                  index]
                                                              .title),
                                                          value: selectedListCollections
                                                              .contains(state
                                                                      .listCollections[
                                                                  index]),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              if (value) {
                                                                selectedListCollections
                                                                    .add(state
                                                                            .listCollections[
                                                                        index]);
                                                              } else {
                                                                selectedListCollections
                                                                    .remove(state
                                                                            .listCollections[
                                                                        index]);
                                                                // context
                                                                //     .bloc<
                                                                //         TrainingsBloc>()
                                                                //     .add(TrainingsFiltered(
                                                                //         selectedDifficulties:
                                                                //             selectedDifficulties,
                                                                //         selectedListCollections:
                                                                //             selectedListCollections));
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
                                                  onPressed: () {
                                                    setState(() {});

                                                    context
                                                        .bloc<TrainingsBloc>()
                                                        .add(TrainingsFiltered(
                                                            selectedDifficulties:
                                                                selectedDifficulties,
                                                            selectedListCollections:
                                                                selectedListCollections));
                                                    Navigator.pop(
                                                      context,
                                                    );
                                                  },
                                                  child: Text('OK'),
                                                )
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: defaultSize * 2),
                              Expanded(
                                  child: SingleChildScrollView(
                                child: selectedListCollections.isEmpty
                                    ? Text('You have to choose Collection')
                                    : Wrap(
                                        alignment: WrapAlignment.center,
                                        children:
                                            selectedListCollections.map((item) {
                                          return Chip(
                                            label: Text(item.title,
                                                style: TextStyle(fontSize: 10)),
                                          );
                                        }).toList(),
                                      ),
                              ))
                            ],
                          ),
                        ),
                        TitleTextHolder(
                            title: '3. I want to study words that I ...'),
                        buildDifficultiesBtns(defaultSize, context, state,
                            selectedListCollections),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: defaultSize * 2),

                //  Button-container
                Container(
                  child: ReusableMainButton(
                    titleText: 'Go to Trainig',
                    textColor: Colors.black,
                    backgroundColor: Theme.of(context).accentColor,
                    onPressed: () async {
                      if (selectedDifficulties.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'You have to choose which words you want to learn',
                              ),
                            )));
                      }
                      if (selectedListCollections.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 1500),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'You have to choose which collection',
                              ),
                            )));
                      }

                      if (selectedGames == FilterGames.bricks &&
                          selectedDifficulties.isNotEmpty &&
                          selectedListCollections.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Matches(
                                words: state.filteredListWords,
                              ),
                            ));
                      }
                      if (selectedGames == FilterGames.wrongCorrect &&
                          selectedDifficulties.isNotEmpty &&
                          selectedListCollections.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CorrectWrong(
                                words: state.filteredListWords,
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
    double defaultSize,
    TrainingsSuccess state,
    BuildContext context,
  ) {
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
              selected: selectedGames == item,
              onSelected: (selected) {
                setState(() {
                  selectedGames = item;
                });
              },
            ),
          );
        }
      }).toList(),
    ));
  }

  Container buildDifficultiesBtns(double defaultSize, BuildContext context,
      TrainingsSuccess state, List<Collection> selectedListCollections) {
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: difficulty.map((item) {
            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: ChoiceChip(
                elevation: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
                label: Text(item.name),
                labelStyle: TextStyle(
                    fontSize: defaultSize * 1.6,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultSize * 0.5),
                ),
                backgroundColor: item.color,
                selected: selectedDifficulties.contains(item.difficulty),
                onSelected: (selected) {
                  setState(() {
                    if (selectedDifficulties.contains(3)) {
                      selectedDifficulties.clear();
                      if (selectedDifficulties.contains(item.difficulty)) {
                        selectedDifficulties.remove(item.difficulty);
                      } else {
                        selectedDifficulties.add(item.difficulty);
                      }
                    } else {
                      selectedDifficulties.contains(item.difficulty)
                          ? selectedDifficulties.remove(item.difficulty)
                          : selectedDifficulties.add(item.difficulty);
                    }
                  });

                  context.bloc<TrainingsBloc>().add(TrainingsFiltered(
                      selectedDifficulties: selectedDifficulties,
                      selectedListCollections: selectedListCollections));
                },
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 5),
        ChoiceChip(
          labelPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 37),
          elevation: 5,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
          label: Text('all'),
          labelStyle: TextStyle(
              fontSize: defaultSize * 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultSize * 0.5),
          ),
          backgroundColor: Colors.white,
          selected: selectedDifficulties.contains(3),
          onSelected: (selected) {
            setState(() {
              if (selectedDifficulties.contains(3)) {
                selectedDifficulties.remove(3);
              } else {
                selectedDifficulties.clear();
                selectedDifficulties.add(3);
              }
            });
            // context.bloc<TrainingsBloc>().add(
            context.bloc<TrainingsBloc>().add(TrainingsFiltered(
                selectedDifficulties: selectedDifficulties,
                selectedListCollections: selectedListCollections));
          },
        )
      ],
    ));
  }
}

// Colors.lightBlue.withOpacity(0.3),
// padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
