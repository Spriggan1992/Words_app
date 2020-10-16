import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

import '../helper.dart';

class BottomAppbar extends StatelessWidget {
  const BottomAppbar({
    Key key,
    GlobalKey<ScaffoldState> scaffoldKey,
    this.state,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  // final List<int> selectedDifficulties;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final TrainingsState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseBottomAppbar(
          goToCollection: () =>
              Navigator.pushNamed(context, CollectionsScreen.id),
          screenDefiner: ScreenDefiner.trainingManager,
          add: () {
            // context.bloc<TrainingsBloc>().add(TrainingsSubmitted());
            // print('collection length: ${state.selectedCollections.length}');
            // print('success: ${state.isSuccess}');
            // print('failure: ${state.isFailure}');

            // if (state.isFailure) {
            //   _scaffoldKey.currentState.showSnackBar(SnackBar(
            //       duration: Duration(milliseconds: 1500),
            //       content: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           state.errorMessage,
            //         ),
            //       )));
            // }
            // if (state.isEmptyCardWord) {
            //   showCustomDialog(context, () {
            //     checkNavigation(
            //       state,
            //       context,
            //       _scaffoldKey,
            //     );
            //   });
            // // } else {
            context.bloc<TrainingsBloc>().add(TrainingsSubmitted());
            checkNavigation(
              state,
              context,
              _scaffoldKey,
            );
          }
          // },
          ),
    );
  }
}
