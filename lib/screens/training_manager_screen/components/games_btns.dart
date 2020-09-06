import 'package:flutter/material.dart';
import 'package:words_app/models/FuiltersEnums.dart';
import 'package:words_app/utils/size_config.dart';

class GamesBtns extends StatefulWidget {
  GamesBtns({Key key}) : super(key: key);

  @override
  _GamesBtnsState createState() => _GamesBtnsState();
}

class _GamesBtnsState extends State<GamesBtns> {
  FilterGames selectedChoice = FilterGames.bricks;
  List<IconData> iconsList = [
    Icons.fitness_center,
    Icons.directions_bike,
    Icons.photo_album,
  ];

  List<Widget> _buildGamesBtns() {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    for (var i = 0; i < iconsList.length - 1; i++) {
      List<Widget> data = FilterGames.values.map((item) {
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
            selected: selectedChoice == item,
            onSelected: (selected) {
              setState(() {
                selectedChoice = item;
              });
            },
          ),
        );
      }).toList();
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildGamesBtns(),
    );
  }
}
