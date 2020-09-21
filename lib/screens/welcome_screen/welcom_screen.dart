import 'package:flutter/material.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/widgets/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';

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
              ReusableMainButton(
                titleText: 'Login',
                textColor: Color(0xFFf0f3f8),
                backgroundColor: Color(0xFF498ba6),
                fontSize: 25,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              SizedBox(height: 50),
              ReusableMainButton(
                titleText: 'Registration',
                textColor: Color(0xFF498ba6),
                backgroundColor: Color(0xFFf0f3f8),
                fontSize: 25,
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
