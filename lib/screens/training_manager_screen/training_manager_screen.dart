import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/screens/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

class TrainingManager extends StatelessWidget {
  static String id = 'training_manager_screen';

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReusableBottomIconBtn(
              icons: Icons.fitness_center,
              color: Colors.black,
              onPress: () => Navigator.pushNamed(context, Matches.id),
            ),
            ReusableBottomIconBtn(
              icons: Icons.directions_bike,
              color: Colors.black,
              onPress: () => Navigator.pushNamed(
                context,
                PairGame.id,
                arguments: {'id': collectionId},
              ),
            ),
            ReusableBottomIconBtn(
              icons: Icons.photo_album,
              color: Colors.black,
              onPress: () => Navigator.pushNamed(
                context,
                Training.id,
                arguments: {'id': collectionId},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
