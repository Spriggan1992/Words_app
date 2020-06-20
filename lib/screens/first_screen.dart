import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_button.dart';
import 'package:words_app/constants.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF87dfd6),
      body: Container(
        decoration: kGradientBackgroundColor,
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
                  decoration: kInputTextLogPass.copyWith(hintText: 'Loging'),
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
                  titleText: 'Login',
                  color1: Colors.purple,
                  color2: Colors.blue),
              SizedBox(
                height: 20.0,
              ),
              ReusableButton(
                  titleText: 'Registration',
                  color1: Colors.blue,
                  color2: Colors.pink[300]),
            ],
          ),
        ),
      ),
    );
  }
}
