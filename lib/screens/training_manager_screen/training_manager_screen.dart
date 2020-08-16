import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/screens/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';
import 'package:words_app/utils/size_config.dart';

class TrainingManager extends StatelessWidget {
  static String id = 'training_manager_screen';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    return Scaffold(
      backgroundColor: Color(0xFFeae2da),
      appBar: BaseAppBar(
        title: Text('Training Manager'),
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TrainingBtnsContainers(
                  defaultSize: defaultSize,
                  child: ReusableBottomIconBtn(
                    icons: Icons.fitness_center,
                    color: Colors.black,
                    onPress: () => Navigator.pushNamed(context, Matches.id),
                  ),
                ),
                TrainingBtnsContainers(
                  defaultSize: defaultSize,
                  child: ReusableBottomIconBtn(
                    icons: Icons.directions_bike,
                    color: Colors.black,
                    onPress: () => Navigator.pushNamed(
                      context,
                      PairGame.id,
                      arguments: {'id': collectionId},
                    ),
                  ),
                ),
                TrainingBtnsContainers(
                  defaultSize: defaultSize,
                  child: ReusableBottomIconBtn(
                    icons: Icons.photo_album,
                    color: Colors.black,
                    onPress: () => Navigator.pushNamed(
                      context,
                      Training.id,
                      arguments: {'id': collectionId},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrainingBtnsContainers extends StatelessWidget {
  const TrainingBtnsContainers({
    Key key,
    @required this.defaultSize,
    this.child,
  }) : super(key: key);

  final double defaultSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: defaultSize * 0.5, vertical: defaultSize),
      decoration: BoxDecoration(
        boxShadow: [kBoxShadow],
        color: Colors.white,
      ),
      width: defaultSize * 12,
      height: defaultSize * 10,
      child: child,
    );
  }
}
