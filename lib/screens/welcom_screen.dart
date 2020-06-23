import 'package:flutter/material.dart';
import 'package:words_app/screens/login_screen.dart';
import 'package:words_app/screens/registration_screen.dart';

class WelcomScreen extends StatelessWidget {
  static String id = 'welcom_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.5, 0.5],
            colors: [Color(0xFF498ba6), Color(0xFFf0f3f8)],
          ),
        ),
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
                  Navigator.pushNamed(context, Registration.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableLogingRegestrationButtons extends StatelessWidget {
  const ReusableLogingRegestrationButtons(
      {this.titleText, this.titleColor, this.backgroundColor, this.onPressed});

  final String titleText;
  final Color titleColor;
  final Color backgroundColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          titleText,
          style: TextStyle(color: titleColor, fontSize: 30.0),
        ),
      ),
    );
  }
}

//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 stops: [0.5, 0.5],
//                 colors: [Color(0xFF498ba6), Color(0xFFf0f3f8)],
//               ),
//             ),
//             child: Text('dsad')),
//       ),
//     );
//   }
// }
