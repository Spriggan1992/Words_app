import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import '../helper.dart';

class MetricsContainer extends StatelessWidget {
  const MetricsContainer({
    Key key,
    this.state,
    // this.selectedDifficulties,
  }) : super(key: key);

  final TrainingManagerState state;
  // final List<int> selectedDifficulties;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: innerShadow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('know:'),
                Text(countWordsByDifficulty(
                    state.filteredWords, 0, state.selectedDifficulties))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('know a little:'),
                Text(countWordsByDifficulty(
                    state.filteredWords, 1, state.selectedDifficulties))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("don't know"),
                Text(countWordsByDifficulty(
                    state.filteredWords, 2, state.selectedDifficulties))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total:"),
                Text(countWordsByDifficulty(
                    state.filteredWords, 3, state.selectedDifficulties))
              ],
            )
          ],
        ));
  }
}
