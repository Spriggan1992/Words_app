import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/components/text_field_log_pass.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FocusNode myFocusNodeEmail = FocusNode();
  FocusNode myFocusNodePassword = FocusNode();
  String emailValue;
  String passwordValue;
  bool checkEmail = false;
  bool checkPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFf0f3f8),
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
                  color1: Color(0xFF498ba6),
                  color2: Colors.black,
                  borderColor: Color(0xFF498ba6),
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
                  color1: Color(0xFF498ba6),
                  color2: Colors.black,
                  borderColor: Color(0xFF498ba6),
                ),
              ),
              SizedBox(height: 80.0),
              Flexible(
                child: ReusableMainButton(
                  titleText: 'Registration',
                  titleColor: Color(0xFFf0f3f8),
                  backgroundColor: Color(0xFF498ba6),
                  fontSize: 25,
                  onPressed: () => Navigator.pushNamed(context, CardCreater.id),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
