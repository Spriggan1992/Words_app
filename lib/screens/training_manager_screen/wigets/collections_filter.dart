import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'widgets.dart';

class CollectionsFilter extends StatelessWidget {
  const CollectionsFilter({
    Key key,
    this.state,
  }) : super(key: key);
  final TrainingManagerState state;

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
            state: state,
          ),
          SizedBox(width: defaultSize * 2),
          CollectionsFuilterShowColldection(state: state)
        ],
      ),
    );
  }
}
