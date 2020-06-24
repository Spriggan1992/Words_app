import 'package:flutter/material.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/constnts/constants.dart';

class WelcomScreen extends StatelessWidget {
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ReusableLogingRegestrationButtons(
                titleText: 'Login',
                titleColor: Color(0xFFf0f3f8),
                backgroundColor: Color(0xFF498ba6),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              SizedBox(height: 50),
              ReusableLogingRegestrationButtons(
                titleText: 'Registration',
                titleColor: Color(0xFF498ba6),
                backgroundColor: Color(0xFFf0f3f8),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// dsadsa