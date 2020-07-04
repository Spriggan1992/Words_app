import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/list_collection_screen/listCollection.dart';
import 'package:words_app/screens/welcome_screen/welcom_screen.dart';
import 'screens/manager_collection/manager_collection.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/models/provier_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderData(),
      child: MaterialApp(
          title: 'Word App',
          debugShowCheckedModeBanner: false,
          initialRoute: WelcomScreen.id,
          routes: {
            WelcomScreen.id: (context) => WelcomScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            ListCollection.id: (context) => ListCollection(),
            ManagerCollection.id: (context) => ManagerCollection(),
            CardCreater.id: (context) => CardCreater(),
          }),
    );
  }
}
