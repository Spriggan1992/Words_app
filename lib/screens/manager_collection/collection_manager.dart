import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creater/card_creator.dart';
import 'package:words_app/screens/manager_collection/components/body.dart';
import 'package:words_app/screens/words_review_screen/words_review.dart';

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
        backgroundColor: kMainColorBackground,
        appBar: BaseAppBar(
          title: Text('$collectionTitle'),
          actions: <Widget>[],
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
          child2: ReusableBottomIconBtn(
            icons: Icons.fitness_center,
            color: kMainColorBackground,
            onPress: () => Navigator.pushNamed(context, WordsReview.id),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
