import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/list_collection_screen/words_collections_list_screen.dart';
import 'package:words_app/screens/welcome_screen/welcom_screen.dart';
import 'screens/manager_collection/collection_manager.dart';
import 'package:words_app/screens/card_creater/card_creater.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';
import 'package:words_app/screens/result_screen/result_screen.dart';

// import 'package:hive/hive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderData(),
      child: MaterialApp(
        title: 'Word App',
        debugShowCheckedModeBanner: false,
        initialRoute: WordsCollectionsList.id,
        routes: {
          WelcomScreen.id: (context) => WelcomScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          WordsCollectionsList.id: (context) => WordsCollectionsList(),
          CollectionManager.id: (context) => CollectionManager(),
          CardCreater.id: (context) => CardCreater(),
          Training.id: (context) => Training(),
          Result.id: (context) => Result(),
        },
      ),
    );
  }
}
