import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/screens/training_manager_screen/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesFilter extends StatelessWidget {
  const GamesFilter({
    Key key,
    this.state,
  }) : super(key: key);

  final TrainingManagerState state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
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
              selected: state.selectedGames == item,
              onSelected: (selected) {
                context
                    .bloc<TrainingManagerBloc>()
                    .add(TrainingManagerSelectedGames(selectedGame: item));
              },
            ),
          );
        }
      }).toList(),
    ));
  }
}
