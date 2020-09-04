import 'package:flutter/material.dart';
import 'package:words_app/bloc/trainings/trainings_bloc.dart';
import 'package:words_app/models/difficulty.dart';
import 'package:words_app/utils/size_config.dart';

class ChoiceChipWidget extends StatefulWidget {
  final List<Difficulty> difficultyList;

  ChoiceChipWidget({this.difficultyList});

  @override
  _ChoiceChipWidgetState createState() => new _ChoiceChipWidgetState();
}

// ignore: camel_case_types
class _ChoiceChipWidgetState extends State<ChoiceChipWidget> {
  String selectedChoice = '';

  List<Widget> _buildChoiceList(context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;

    List<Widget> choices = List();
    widget.difficultyList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(3.0),
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
          selectedColor: selectedChoice == '' ? item.color : Colors.grey,
          selected: selectedChoice == item.name,
          onSelected: (selected) {
            setState(() {
              selectedChoice == item.name
                  ? selectedChoice = ''
                  : selectedChoice = item.name;
            });
            // print(item.difficulty);
            //   context.bloc<TrainingsBloc>().add(TrainingsDifficultiesFilter(
            //       difficultyFilter:
            //           selectedChoice == '' ? null : item.difficulty));
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _buildChoiceList(context),
    );
  }
}
