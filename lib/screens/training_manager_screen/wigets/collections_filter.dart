import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'widgets.dart';

class CollectionsFilter extends StatelessWidget {
  const CollectionsFilter({
    Key key,
    @required this.selectedDifficulties,
    this.state,
  }) : super(key: key);
  final TrainingsSuccess state;
  final List<int> selectedDifficulties;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      width: SizeConfig.blockSizeHorizontal * 100,
      height: defaultSize * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CollectionsFilterChooseCollection(
              defaultSize: defaultSize,
              state: state,
              selectedDifficulties: selectedDifficulties),
          SizedBox(width: defaultSize * 2),
          CollectionsFuilterShowColldection(state: state)
        ],
      ),
    );
  }
}
