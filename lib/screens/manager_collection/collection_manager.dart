import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/screens/manager_collection/components/body.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';

class CollectionManager extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _CollectionManagerState createState() => _CollectionManagerState();
}

class _CollectionManagerState extends State<CollectionManager> {
  @override
  Widget build(BuildContext context) {
    // bool ignoreActions = false;
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return SafeArea(
        // Exclude top from SafeArea
        top: false,
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Collection Name'),
            appBar: AppBar(),
          ),
          body: Body(),
          floatingActionButton: ReusableFloatActionButton(
              onPressed: () => Navigator.pushNamed(context, CardCreater.id)),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60.0,
              color: kMainColorBlue,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      width: 90,
                      height: 55,
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      )),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, Training.id),
                      )),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
    });
  }
}
