import 'package:flutter/material.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/models/game_card.dart';
import 'package:words_app/models/word.dart';
import 'package:words_app/widgets/base_appbar.dart';
import 'package:words_app/screens/games/pair_game_screen/widgets/body.dart';

import 'package:words_app/config/size_config.dart';

class PairGame extends StatefulWidget {
  PairGame({this.words});
  final List<Word> words;
  static const id = 'pair_game';
  @override
  _PairGameState createState() => _PairGameState();
}

class _PairGameState extends State<PairGame> {
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    double blockSizeHorizontal = SizeConfig.blockSizeHorizontal;
    double blockSizeVertical = SizeConfig.blockSizeVertical;

    List<GameCard> _pairGameList = [];

    createGameList() async {
      _pairGameList = widget.words.map((item) {
        GameCard gameCard = GameCard(
          id: item.id,
          targetLang: item.targetLang,
          ownLang: item.ownLang,
        );
        return gameCard;
      }).toList();
      // prepare data for game, shuffle it a little bit
      _pairGameList.shuffle();
    }

    setState(
      () {
        createGameList();
      },
    );

    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        screenDefiner: ScreenDefiner.trainings,
        title: Text('Pair words'),
      ),
      body: Body(
        defaultSize: defaultSize,
        blockSizeVertical: blockSizeVertical,
        blockSizeHorizontal: blockSizeHorizontal,
        pairGameList: _pairGameList,
      ),
    );
  }
}
