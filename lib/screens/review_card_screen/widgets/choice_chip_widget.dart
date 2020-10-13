import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/difficulty.dart';

class ChoiceChipWidget extends StatefulWidget {
  final List<Difficulty> difficultyList;

  ChoiceChipWidget({this.difficultyList});

  @override
  _ChoiceChipWidgetState createState() => new _ChoiceChipWidgetState();
}

class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    final defaultSize = SizeConfig.defaultSize;
    List<Widget> choices = List();
    widget.difficultyList.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.all(defaultSize * 0.5),
        child: ChoiceChip(
          elevation: 5,
          label: Text(item.name),
          labelStyle: TextStyle(
              color: Colors.black,
              fontSize: defaultSize * 1.4,
              fontWeight: FontWeight.bold),
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
