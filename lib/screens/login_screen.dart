import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_login_registration_buttons.dart';
import 'package:words_app/components/text_field_log_pass.dart';
import 'package:words_app/screens/listCollection.dart';

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
                child: ReusableLogingRegestrationButtons(
                  titleText: 'Login',
                  titleColor: Color(0xFF498ba6),
                  backgroundColor: Color(0xFFf0f3f8),
                  onPressed: () =>
                      Navigator.pushNamed(context, ListCollection.id),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
