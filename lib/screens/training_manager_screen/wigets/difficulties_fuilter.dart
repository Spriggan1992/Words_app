import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DifficultiesFilter extends StatelessWidget {
  const DifficultiesFilter({
    Key key,
    this.difficulty,
    this.selectedDifficulties,
    this.state,
  }) : super(key: key);

  final List<Difficulty> difficulty;
  final List<int> selectedDifficulties;
  final TrainingsSuccess state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;

    return Container(
        child: Column(
      children: [
        buildKnowLittleDontKnowBtns(defaultSize, context),
        SizedBox(height: 5),
        buildAllBtn(defaultSize, context)
      ],
    ));
  }

  ChoiceChip buildAllBtn(double defaultSize, BuildContext context) {
    return ChoiceChip(
      labelPadding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 37),
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

        if (selectedDifficulties.contains(3)) {
          selectedDifficulties.remove(3);
        } else {
          selectedDifficulties.clear();
          selectedDifficulties.add(3);
        }

        context.bloc<TrainingsBloc>().add(TrainingsFiltered(
            selectedDifficulties: selectedDifficulties,
            selectedCollections: state.filteredCollections));
      },
    );
  }

  Row buildKnowLittleDontKnowBtns(double defaultSize, BuildContext context) {
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
            selected: selectedDifficulties.contains(item.difficulty),
            onSelected: (selected) {
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

              context.bloc<TrainingsBloc>().add(TrainingsFiltered(
                  selectedDifficulties: selectedDifficulties,
                  selectedCollections: state.filteredCollections));
            },
          ),
        );
      }).toList(),
    );
  }
}
