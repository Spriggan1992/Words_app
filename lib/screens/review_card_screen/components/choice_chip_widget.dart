import 'package:flutter/material.dart';
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
    List<Widget> choices = List();
    widget.difficultyList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          elevation: 5,
          label: Text(item.name),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
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
