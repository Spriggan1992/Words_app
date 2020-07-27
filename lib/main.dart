import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/providers/validation_provider.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creater/card_creator.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/list_collection_screen/words_collections_list_screen.dart';
import 'package:words_app/screens/welcome_screen/welcom_screen.dart';
import 'screens/manager_collection/collection_manager.dart';

import 'package:words_app/screens/training_screen/training_screen.dart';
import 'package:words_app/screens/result_screen/result_screen.dart';

// import 'package:hive/hive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Collections(),
        ),
        ChangeNotifierProvider(
          create: (context) => Words(),
        ),
        ChangeNotifierProvider(
          create: (context) => ValidationForm(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
            primaryColor: kAppBarsColor,
            scaffoldBackgroundColor: kMainColorBackground),
        title: 'Word App',
        debugShowCheckedModeBanner: false,
        initialRoute: WordsCollectionsList.id,
        routes: {
          WelcomScreen.id: (context) => WelcomScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          WordsCollectionsList.id: (context) => WordsCollectionsList(),
          CollectionManager.id: (context) => CollectionManager(),
          CardCreator.id: (context) => CardCreator(),
          Training.id: (context) => Training(),
          Result.id: (context) => Result(),
        },
      ),
    );
  }
}
