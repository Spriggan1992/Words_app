import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/screens/manager_collection/components/body.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

class CollectionManager extends StatelessWidget {
  static String id = 'collection_manager_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Exclude top from SafeArea
      top: false,
      child: Scaffold(
        backgroundColor: kMainColorBackground,
        appBar: BaseAppBar(
          title: Text('Collection Name'),
          appBar: AppBar(),
        ),
        body: Body(), // Body
        floatingActionButton: ReusableFloatActionButton(
          onPressed: () => Navigator.pushNamed(context, CardCreater.id),
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
            onPress: () => Navigator.pushNamed(context, Training.id),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
