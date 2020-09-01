import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/screens/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';
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
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TrainingBtnsContainers(
                  defaultSize: defaultSize,
                  child: ReusableBottomIconBtn(
                    icons: Icons.fitness_center,
                    color: Colors.black,
                    onPress: () => Navigator.pushNamed(context, Matches.id),
                  ),
                ),
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
                    onPress: () => Navigator.pushNamed(
                      context,
                      Training.id,
                      arguments: {'id': collectionId},
                    ),
                  ),
                ),
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
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(defaultSize),
                margin: EdgeInsets.only(
                    bottom: defaultSize * 7,
                    right: defaultSize * 3,
                    left: defaultSize * 3),
                child: ListView.builder(
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          leading: Text(words[index].part.partName,
                              style: TextStyle(
                                  color: words[index].part.partColor)),
                          title: Container(
                              padding: EdgeInsets.only(left: defaultSize * 1),
                              child: Text(words[index].targetLang ?? '')),
                          subtitle: Container(
                              padding: EdgeInsets.only(left: defaultSize * 1),
                              child: Text(words[index].ownLang ?? '')),
                        ),
                      );
                    }),
              ),
            ),
          ),
          ReusableMainButton(
            titleText: 'Go to Trainig',
            textColor: Colors.black,
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ],
      ),
    );
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
      width: defaultSize * 12,
      height: defaultSize * 10,
      child: child,
    );
  }
}
