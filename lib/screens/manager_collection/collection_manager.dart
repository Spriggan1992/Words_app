import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';

import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creator_screen//card_creator.dart';
import 'package:words_app/screens/manager_collection/components/body.dart';
import 'package:words_app/screens/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

class CollectionManager extends StatelessWidget {
  static String id = 'collection_manager_screen';

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    String collectionTitle = args['title'];

    return SafeArea(
      // Exclude top from SafeArea
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFFeae2da),
        appBar: BaseAppBar(
          title: Text('$collectionTitle'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                await Provider.of<Words>(context, listen: false)
                    .populateList(collectionId);
              },
            )
          ],
          appBar: AppBar(),
        ),
        // Use future builder because when using fetch data it returns future
        body: FutureBuilder(
          future: Provider.of<Words>(context, listen: false)
              .fetchAndSetWords(collectionId),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Body(),
        ), // Body
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () => Navigator.pushNamed(context, CardCreator.id,
              arguments: {'id': collectionId}),
        ),

        bottomNavigationBar: BaseBottomAppBar(
          child1: ReusableBottomIconBtn(
            icons: Icons.keyboard_arrow_left,
            color: kMainColorBackground,
            onPress: () => Navigator.pop(context),
          ),
          child2: Row(
            children: [
              ReusableBottomIconBtn(
                icons: Icons.fitness_center,
                color: kMainColorBackground,
                onPress: () => Navigator.pushNamed(context, Matches.id),
              ),
              ReusableBottomIconBtn(
                icons: Icons.directions_bike,
                color: kMainColorBackground,
                onPress: () => Navigator.pushNamed(
                  context,
                  PairGame.id,
                  arguments: {'id': collectionId},
                ),
              ),
              ReusableBottomIconBtn(
                icons: Icons.photo_album,
                color: kMainColorBackground,
                onPress: () => Navigator.pushNamed(
                  context,
                  Training.id,
                  arguments: {'id': collectionId},
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
