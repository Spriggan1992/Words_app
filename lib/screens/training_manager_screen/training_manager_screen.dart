import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/games/bricks_game.dart';
import 'package:words_app/screens/games/correct_wrong_game.dart';
import 'package:words_app/utils/size_config.dart';

class TrainingManager extends StatefulWidget {
  static String id = 'training_manager_screen';

  @override
  _TrainingManagerState createState() => _TrainingManagerState();
}

class _TrainingManagerState extends State<TrainingManager> {
  String dropdownValue = 'Filters';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    List<Word> words = args['words'];

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
              padding: EdgeInsets.all(defaultSize * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TitleTextHolder(title: '1. I want to play ...'),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TrainingBtnsContainers(
                            defaultSize: defaultSize,
                            child: ReusableBottomIconBtn(
                                icons: Icons.fitness_center,
                                color: Colors.black,
                                onPress: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Matches(
                                        words: words,
                                      ),
                                    )))),
                        TrainingBtnsContainers(
                          defaultSize: defaultSize,
                          child: ReusableBottomIconBtn(
                            icons: Icons.directions_bike,
                            color: Colors.black,
                            onPress: () => Navigator.pushNamed(
                              context,
                              PairGame.id,
                              arguments: {'id': collectionId},
                            ),
                          ),
                        ),
                        TrainingBtnsContainers(
                          defaultSize: defaultSize,
                          child: ReusableBottomIconBtn(
                              icons: Icons.photo_album,
                              color: Colors.black,
                              onPress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Training(
                                      words: words,
                                    ),
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  TitleTextHolder(title: '2. I want to study words that I ...'),
                  Container(
                    child: Row(
                      children: [
                        Chip(
                          label: Text('know'),
                          shape: Border(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.grey[200],
                    padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
                    height: defaultSize * 4,
                    width: SizeConfig.blockSizeHorizontal * 100,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text('Filters'),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: defaultSize * 3,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>[
                            'Filters',
                            'Know',
                            "Don't know",
                            'Custom list'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //  Button-container
          Container(
            child: ReusableMainButton(
              titleText: 'Go to Trainig',
              textColor: Colors.black,
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class TitleTextHolder extends StatelessWidget {
  const TitleTextHolder({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
        child: Text(title,
            style: TextStyle(
                fontSize: defaultSize * 2,
                color: Theme.of(context).accentColor)));
  }
}

class TrainingBtnsContainers extends StatelessWidget {
  const TrainingBtnsContainers({
    Key key,
    @required this.defaultSize,
    this.child,
  }) : super(key: key);

  final double defaultSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: defaultSize * 0.5, vertical: defaultSize),
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
        color: Colors.white,
      ),
      width: defaultSize * 5,
      height: defaultSize * 5,
      child: child,
    );
  }
}

// Expanded(
//                     child: Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                         ),
//                         padding: EdgeInsets.all(defaultSize),
//                         margin: EdgeInsets.only(
//                             bottom: defaultSize * 7,
//                             right: defaultSize * 3,
//                             left: defaultSize * 3),
//                         child: ListView.builder(
//                             itemCount: words.length,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 child: ListTile(
//                                   leading: Text(words[index].part.partName,
//                                       style: TextStyle(
//                                           color: words[index].part.partColor)),
//                                   title: Container(
//                                       padding: EdgeInsets.only(
//                                           left: defaultSize * 1),
//                                       child:
//                                           Text(words[index].targetLang ?? '')),
//                                   subtitle: Container(
//                                       padding: EdgeInsets.only(
//                                           left: defaultSize * 1),
//                                       child: Text(words[index].ownLang ?? '')),
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//                   ),
