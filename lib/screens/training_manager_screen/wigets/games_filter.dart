import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/screens/training_manager_screen/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesFilter extends StatefulWidget {
  const GamesFilter({
    Key key,
    @required this.iconsList,
    this.state,
  }) : super(key: key);

  final List<IconData> iconsList;
  final TrainingsSuccess state;

  @override
  _GamesFilterState createState() => _GamesFilterState();
}

class _GamesFilterState extends State<GamesFilter> {
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
        // child: GamesBtns(),
        child: Row(
      children: FilterGames.values.map((item) {
        for (var i = 0; i < widget.iconsList.length; i++) {
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
                  widget.iconsList[item.index],
                  color: Colors.black,
                  size: defaultSize * 3,
                ),
              ),
              selected: widget.state.selectedGames == item,
              onSelected: (selected) {
                context
                    .bloc<TrainingsBloc>()
                    .add(TrainingsUpdatedSelectedGames(selectedGames: item));
                // selectedGames = item;
              },
            ),
          );
        }
      }).toList(),
    ));
  }
}
