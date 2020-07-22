import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/components/reusable_main_button.dart';

class Result extends StatelessWidget {
  static String id = 'result_screenshot';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColorBlue,
          automaticallyImplyLeading: false,
          title: Text('Result'),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 60.0,
            color: kMainColorBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 90,
                  height: 55,
                  padding: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Text('Your score 8/10',
                      style: TextStyle(
                        fontSize: 20,
                      ))),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                child: Text('You are awesome!'),
              ),
              SizedBox(height: 50.0),
              ReusableMainButton(
                titleText: 'Back To Collections',
                onPressed: null,
                textColor: kMainColorBlue,
                backgroundColor: Colors.white,
                fontSize: 25,
              ),
            ],
          ),
        ));
  }
}
