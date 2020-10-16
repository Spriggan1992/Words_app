import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'package:words_app/models/models.dart';
import 'package:words_app/widgets/widgets.dart';

import 'wigets/title_text_holder.dart';
import 'wigets/widgets.dart';

class TrainingManager extends StatefulWidget {
  static String id = 'training_manager_screen';

  @override
  _TrainingManagerState createState() => _TrainingManagerState();
}

class _TrainingManagerState extends State<TrainingManager> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // List<int> _selectedDifficulties = [];
  List<Difficulty> _difficulty = DifficultyList().difficultyList;

  // Data for creating dynamic icons for games buttons

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    // Map args = ModalRoute.of(context).settings.arguments;
    // String collectionId = args['id'];
    // List<Word> words = args['words'];

    return BlocConsumer<TrainingManagerBloc, TrainingManagerState>(
        listener: ((context, failureState) {
      if (failureState.isFailure) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(milliseconds: 1500),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                failureState.errorMessage,
              ),
            )));
      }
    }), builder: (context, state) {
      if (state.selectedCollections == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFFeae2da),
          appBar: BaseAppBar(
            screenDefiner: ScreenDefiner.trainingManager,
            title: Text('Trainings'),
            appBar: AppBar(),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextHolder(title: '1. I want to play ...'),
                      GamesFilter(
                        state: state,
                      ),
                      TitleTextHolder(title: '2. I want to use words from ...'),
                      CollectionsFilter(
                        state: state,
                      ),
                      TitleTextHolder(
                          title: '3. I want to study words that I ...'),
                      DifficultiesFilter(difficulty: _difficulty, state: state),
                      MetricsContainer(state: state)
                    ],
                  ),
                ),
              ),
              BottomAppbar(
                state: state,
              ),
            ],
          ),
        );
    });
  }
}
