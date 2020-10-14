import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

import '../helper.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({
    Key key,
    this.selectedDifficulties,
    GlobalKey<ScaffoldState> scaffoldKey,
    this.state,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final List<int> selectedDifficulties;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final TrainingsSuccess state;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseBottomAppbar(
        goToCollection: () =>
            Navigator.pushNamed(context, CollectionsScreen.id),
        screenDefiner: ScreenDefiner.trainingManager,
        add: () {
          if (state.isEmptyCardWord == true &&
              selectedDifficulties.isNotEmpty) {
            showCustomDialog(context, () {
              checkNavigation(
                state.filteredCollections,
                state,
                context,
                _scaffoldKey,
                selectedDifficulties,
              );
            });
          } else {
            checkNavigation(
              state.filteredCollections,
              state,
              context,
              _scaffoldKey,
              selectedDifficulties,
            );
          }
        },
      ),
    );
  }
}
