import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/game_card_data.dart';
import 'package:words_app/providers/pair_game_card_provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/screens/pair_game_screen/components/body.dart';
import 'package:words_app/utils/size_config.dart';

import 'components/game_card.dart';

class PairGame extends StatelessWidget {
  static const id = 'pair_game';

  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];

    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    double blockSizeHorizontal = SizeConfig.blockSizeHorizontal;
    double blockSizeVertical = SizeConfig.blockSizeVertical;
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: Text('pair words'),
      ),
      body: FutureBuilder(
        future: Provider.of<GameCards>(context, listen: false)
            .fetchWordsFromDB(collectionId),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Body(
                    defaultSize: defaultSize,
                    blockSizeVertical: blockSizeVertical,
                    blockSizeHorizontal: blockSizeHorizontal,
                  ),
      ),
    );
  }
}

//
//Body(
//defaultSize: defaultSize,
//blockSizeVertical: blockSizeVertical,
//blockSizeHorizontal: blockSizeHorizontal,
//),
