import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

import 'widgets/widgets.dart';

class YesNoGame extends StatefulWidget {
  static String id = 'training_screen';
  YesNoGame({this.words});
  final List<Word> words;

  @override
  _YesNoGameState createState() => _YesNoGameState();
}

class _YesNoGameState extends State<YesNoGame> with TickerProviderStateMixin {
  AnimationController _correctController;
  AnimationController _wrongController;
  Animation<Color> _correctAnimation;
  Animation<Color> _wrongAnimation;

  @override
  void initState() {
    super.initState();

    _correctController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _wrongController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _correctAnimation = ColorTween(begin: Colors.black, end: Colors.green)
        .animate(_correctController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _correctController.reverse();
            }
          });
    _wrongAnimation = ColorTween(begin: Colors.black, end: Colors.red)
        .animate(_wrongController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _wrongController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _correctController.dispose();
    _wrongController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return WillPopScope(
        onWillPop: () async =>
            false ??
            showCustomDialog(
              context: context,
              title: 'Are you sure?',
              content: 'Do you want to delete this word?',
              function: () {
                Navigator.pushNamedAndRemoveUntil(context, TrainingManager.id,
                    ModalRoute.withName(TrainingManager.id));
              },
            ),
        child: BlocConsumer<YesNoGameBloc, YesNoGameState>(
          listener: (context, state) {
            final data = (state as YesNoGameSuccess);
            if (data.targetLang.isEmpty)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResultScreen(
                            correct: data.correct,
                            wrong: data.wrong,
                          )));
          },
          builder: (context, state) {
            if (state is YesNoGameLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is YesNoGameSuccess) {
              return Scaffold(
                appBar: BaseAppBar(
                  screenDefiner: ScreenDefiner.trainings,
                  title: Text('YES/NO'),
                  appBar: AppBar(),
                ),
                body: Center(
                  child: Stack(
                    children: <Widget>[
                      Deck(
                        state: state,
                        correctController: _correctController,
                        wrongController: _wrongController,
                      ),
                      MatchWords(state: state),
                      YesNoBtns(
                        title: 'YES',
                        top: SizeConfig.blockSizeVertical * 60,
                        left: defaultSize * 32,
                        icon: Icons.redo,
                        animationController: _correctAnimation,
                      ),
                      YesNoBtns(
                        title: 'NO',
                        top: SizeConfig.blockSizeVertical * 60,
                        left: defaultSize * 6,
                        icon: Icons.undo,
                        animationController: _wrongAnimation,
                      ),
                      Score(state: state)
                    ],
                  ),
                ),
              );
            } else
              return Text('Somthing went wrong...');
          },
        ));
  }
}
