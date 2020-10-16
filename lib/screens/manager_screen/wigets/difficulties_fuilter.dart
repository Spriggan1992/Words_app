import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DifficultiesFilter extends StatelessWidget {
  const DifficultiesFilter({
    Key key,
    this.difficulty,
    this.state,
  }) : super(key: key);

  final List<Difficulty> difficulty;

  final TrainingManagerState state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    List<int> selectedDifficulties = [];
    return Container(
        child: Column(
      children: [
        _buildKnowLittleDontKnowBtns(
            defaultSize, context, selectedDifficulties),
      ],
    ));
  }

  Row _buildKnowLittleDontKnowBtns(double defaultSize, BuildContext context,
      List<int> selectedDifficulties) {
    return Row(
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
                fontWeight: FontWeight.w700),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultSize * 0.5),
            ),
            backgroundColor: item.color,
            selected: state.selectedDifficulties.contains(item.difficulty),
            onSelected: (selected) {
              context.bloc<TrainingManagerBloc>().add(
                  TrainingManagerUpdatedDifficulties(
                      difficulty: item.difficulty));
              context
                  .bloc<TrainingManagerBloc>()
                  .add(TrainingManagerFiltered());
            },
          ),
        );
      }).toList(),
    );
  }
}
