import 'package:flutter/material.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/list_collection_screen/listCollection.dart';
import 'package:words_app/screens/welcome_screen/welcom_screen.dart';
import 'screens/collections_manager/collections_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Word App',
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomScreen.id,
        routes: {
          WelcomScreen.id: (context) => WelcomScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ListCollection.id: (context) => ListCollection(),
          CollectionManager.id: (context) => CollectionManager(),
        });
  }
}
