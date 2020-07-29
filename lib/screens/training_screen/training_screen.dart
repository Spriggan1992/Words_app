import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/components/base_bottom_appbar.dart';
import 'package:words_app/components/reusable_bottomappbar_icon_btn.dart';
import 'package:words_app/constants/constants.dart';

class Training extends StatelessWidget {
  static String id = 'training_screen';
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: BaseAppBar(
          title: Text('Training'),
          appBar: AppBar(),
        ),
        bottomNavigationBar: BaseBottomAppBar(
          child1: ReusableBottomIconBtn(
            icons: Icons.keyboard_arrow_left,
            color: kMainColorBackground,
            onPress: () => Navigator.pop(context),
          ),
          child2: Container(),
        ),
        body: Card(
          color: Colors.transparent,
          child: Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.6,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                Container(
                    width: screenWidth / 1.2,
                    height: screenHeight / 2.2,
                    child: Text('First Card')),
                Container(
                  width: screenWidth / 1.2,
                  height: screenHeight / 1.7 - screenHeight / 2.2,
                ),
              ],
            ),
          ),
        ));
  }
}
