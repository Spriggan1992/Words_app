import 'package:flutter/material.dart';
import 'package:words_app/screens/login_screen.dart';
import 'package:words_app/screens/registration_screen.dart';
import 'package:words_app/screens/listCollection.dart';
import 'package:words_app/screens/welcom_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomScreen.id,
        routes: {
          WelcomScreen.id: (context) => WelcomScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          Registration.id: (context) => Registration(),
          ListCollection.id: (context) => ListCollection(),
        });
  }
}
