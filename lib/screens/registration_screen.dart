import 'package:flutter/material.dart';
import 'package:words_app/constants.dart';
import 'package:words_app/components/reusable_button.dart';

class RegistrationScreen extends StatelessWidget {
  static String id = 'registration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kRegistrationBackground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: TextField(
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  decoration: kInputTextLogPass.copyWith(hintText: 'Email'),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Flexible(
                child: TextField(
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  decoration: kInputTextLogPass.copyWith(hintText: 'Password'),
                ),
              ),
              SizedBox(height: 20.0),
              ReusableButton(
                  titleText: 'Confirm',
                  color1: Colors.blue,
                  color2: Colors.pink[300]),
            ],
          ),
        ),
      ),
    );
  }
}
