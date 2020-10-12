import 'package:flutter/material.dart';
import 'package:words_app/widgets/reusable_main_button.dart';
import 'package:words_app/widgets/text_field_log_pass.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/screens/words_screen/words_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'first_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode myFocusNodeEmail = FocusNode();
  FocusNode myFocusNodePassword = FocusNode();
  String emailValue;
  String passwordValue;
  bool checkEmail = false;
  bool checkPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF498ba6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 200.0),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: TextFieldLogPass(
                  onChanged: (value) {
                    setState(() {
                      emailValue = value;
                      if (emailValue.length > 0) {
                        checkEmail = true;
                      } else {
                        checkEmail = false;
                      }
                    });
                  },
                  focusNode: myFocusNodeEmail,
                  onTap: () {
                    setState(() {
                      myFocusNodeEmail.requestFocus();
                    });
                  },
                  textLabel: 'Email',
                  isChecked: checkEmail,
                  color1: Colors.white,
                  color2: Colors.black,
                  borderColor: Colors.white,
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 20.0,
                ),
              ),
              Flexible(
                child: TextFieldLogPass(
                  onChanged: (value) {
                    setState(() {
                      passwordValue = value;
                      if (passwordValue.length > 0) {
                        checkPassword = true;
                      } else {
                        checkPassword = false;
                      }
                    });
                  },
                  focusNode: myFocusNodePassword,
                  onTap: () {
                    setState(() {
                      myFocusNodePassword.requestFocus();
                    });
                  },
                  textLabel: 'Password',
                  isChecked: checkPassword,
                  color1: Colors.white,
                  color2: Colors.black,
                  borderColor: Colors.white,
                ),
              ),
              SizedBox(height: 80.0),
              Flexible(
                child: ReusableMainButton(
                  titleText: 'Login',
                  textColor: kMainColorBlue,
                  backgroundColor: Color(0xFFf0f3f8),
                  fontSize: 25,
                  onPressed: () => Navigator.pushNamed(context, WordsScreen.id),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
