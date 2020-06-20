import 'package:flutter/material.dart';
import 'package:words_app/screens/first_screen.dart';
import 'package:words_app/screens/registration_screen.dart';
import 'package:words_app/screens/listCollection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: ListCollection.id,
        routes: {
          FirstScreen.id: (context) => FirstScreen(),
          Registration.id: (context) => Registration(),
          ListCollection.id: (context) => ListCollection(),
        });
  }
}
