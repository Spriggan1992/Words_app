import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/widgets/base_appbar.dart';
import 'package:words_app/widgets/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/collection_model.dart';

import 'package:words_app/models/difficulty.dart';
import 'package:words_app/models/fuiltersEnums.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/screens/games/bricks_game_screen//bricks_game.dart';
import 'package:words_app/screens/games/pair_game_screen/pair_game.dart';

import 'package:words_app/utils/size_config.dart';

import 'helper.dart';
import 'wigets/title_text_holder.dart';

class TrainingManager extends StatefulWidget {
  static String id = 'training_manager_screen';

  @override
  _TrainingManagerState createState() => _TrainingManagerState();
}

class _TrainingManagerState extends State<TrainingManager> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<int> selectedDifficulties = [];
  FilterGames selectedGames = FilterGames.bricks;
  List<Difficulty> difficulty = DifficultyList().difficultyList;
  bool isEmptyString;

  // Data for creating dynamic icons for games buttons
  List<IconData> iconsList = [
    Icons.fitness_center,
    Icons.directions_bike,
    Icons.photo_album,
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    // Map args = ModalRoute.of(context).settings.arguments;
    // String collectionId = args['id'];
    // List<Word> words = args['words'];

    return BlocBuilder<TrainingsBloc, TrainingsState>(
      builder: (context, state) {
        if (state is TrainingsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TrainingsSuccess) {
          // Varibal that contains Filtered List of Collections
          List<Collection> selectedListCollections = state.filteredCollections;
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
                        buildChooseCollectionsContainer(defaultSize, context,
                            state, selectedListCollections),
                        TitleTextHolder(
                            title: '3. I want to study words that I ...'),
                        buildDifficultiesBtns(defaultSize, context, state,
                            selectedListCollections, isEmptyString),
                        buildMetricsContainer(state, selectedDifficulties),
                      ],
                    ),
                  ),
                ),
                buildMainBtn(context, selectedListCollections, state),
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
        for (var i = 0; i < iconsList.length; i++) {
          return Padding(
            padding: const EdgeInsets.only(right: 30),
            child: ChoiceChip(
              backgroundColor: Colors.white,
              labelPadding: EdgeInsets.all(defaultSize * 0.8),
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

  Container buildDifficultiesBtns(
      double defaultSize,
      BuildContext context,
      TrainingsSuccess state,
      List<Collection> selectedListCollections,
      bool isEmptyString) {
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
                    fontWeight: FontWeight.w700),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultSize * 0.5),
                ),
                backgroundColor: item.color,
                selected: selectedDifficulties.contains(item.difficulty),
                onSelected: (selected) {
                  setState(() {
                    /// Add difficulties filter to the List[selectedDifficulties]
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
                      selectedCollections: selectedListCollections));
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
          onSelected: (selected) async {
            /// Add difficulties filter to the List[selectedDifficulties]
            setState(() {
              if (selectedDifficulties.contains(3)) {
                selectedDifficulties.remove(3);
              } else {
                selectedDifficulties.clear();
                selectedDifficulties.add(3);
              }
            });
            context.bloc<TrainingsBloc>().add(TrainingsFiltered(
                selectedDifficulties: selectedDifficulties,
                selectedCollections: selectedListCollections));
            isEmptyString = state.isEmptyCardWord;
          },
        )
      ],
    ));
  }

  Container buildChooseCollectionsContainer(
      double defaultSize,
      BuildContext context,
      TrainingsSuccess state,
      List<Collection> selectedListCollections) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: defaultSize * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Card(
              elevation: 5,
              child: ListTile(
                leading:
                    Text('Choose collections', style: TextStyle(fontSize: 12)),
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
                          content: StatefulBuilder(
                            builder: (context, setState) {
                              return Container(
                                height: defaultSize * 30,
                                width: SizeConfig.blockSizeHorizontal * 70,
                                child: ListView.builder(
                                  itemExtent: defaultSize * 5,
                                  itemCount: state.collections.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      title:
                                          Text(state.collections[index].title),
                                      value: selectedListCollections
                                          .contains(state.collections[index]),
                                      onChanged: (value) {
                                        setState(() {
                                          if (value) {
                                            selectedListCollections
                                                .add(state.collections[index]);
                                          } else {
                                            selectedListCollections.remove(
                                                state.collections[index]);
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
                                context.bloc<TrainingsBloc>().add(
                                    TrainingsFiltered(
                                        selectedDifficulties:
                                            selectedDifficulties,
                                        selectedCollections:
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
              child: Container(
            decoration: innerShadow,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                clipBehavior: Clip.hardEdge,
                child: selectedListCollections.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'You have to choose Collection',
                        ),
                      )
                    : Wrap(
                        spacing: defaultSize * 0.3,
                        alignment: WrapAlignment.center,
                        children: selectedListCollections.map((item) {
                          return Chip(
                            label: Text(item.title,
                                style: TextStyle(fontSize: 10)),
                          );
                        }).toList(),
                      ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Container buildMetricsContainer(
      TrainingsSuccess state, selectedDifficulties) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: innerShadow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('know:'),
                Text(countWordsByDifficulty(
                    state.filteredWords, 0, selectedDifficulties))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('know a little:'),
                Text(countWordsByDifficulty(
                    state.filteredWords, 1, selectedDifficulties))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("don't know"),
                Text(countWordsByDifficulty(
                    state.filteredWords, 2, selectedDifficulties))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total:"),
                Text(countWordsByDifficulty(
                    state.filteredWords, 3, selectedDifficulties))
              ],
            )
          ],
        ));
  }

  Container buildMainBtn(
    BuildContext context,
    List<Collection> selectedListCollections,
    TrainingsSuccess state,
  ) {
    return Container(
      child: ReusableMainButton(
        titleText: 'Go to Trainig',
        textColor: Colors.black,
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: () {
          if (state.isEmptyCardWord == true &&
              selectedDifficulties.isNotEmpty) {
            showCustomDialog(context, () {
              checkNavigation(
                selectedListCollections,
                state,
                context,
                _scaffoldKey,
                selectedDifficulties,
                selectedGames,
              );
            });
          } else {
            checkNavigation(
              selectedListCollections,
              state,
              context,
              _scaffoldKey,
              selectedDifficulties,
              selectedGames,
            );
          }
        },
      ),
    );
  }
}
