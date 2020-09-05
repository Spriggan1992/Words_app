import 'package:flutter/material.dart';
import 'package:words_app/models/difficulty.dart';
import 'package:words_app/utils/size_config.dart';

class choiceChipWidget extends StatefulWidget {
  final List<Difficulty> difficultyList;

  choiceChipWidget({this.difficultyList});

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    List<Widget> choices = List();
    widget.difficultyList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          label: Text(item.name),
          labelStyle: TextStyle(
              fontSize: defaultSize * 1.6,
              color: Colors.black,
              fontWeight: FontWeight.w900),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultSize * 0.5),
          ),
          backgroundColor: item.color,
          selectedColor: Theme.of(context).accentColor,
          selected: selectedChoice == item.name,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item.name;
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _buildChoiceList(),
    );
  }
}
