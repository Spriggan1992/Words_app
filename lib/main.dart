import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';

import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/providers/training_matches_provider.dart';
import 'package:words_app/providers/validation_provider.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creater/card_creator.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/list_collection_screen/words_collections_list_screen.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/welcome_screen/welcom_screen.dart';
import 'package:words_app/screens/words_review_screen/words_review.dart';
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
        ChangeNotifierProvider(
          create: (context) => TrainingMatches(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
            primaryColor: Color(0xff450920),
            backgroundColor: Color(0xffEAE2DA),
            scaffoldBackgroundColor: Color(0xffEAE2DA),
            bottomAppBarColor: Color(0xffA53860)),
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
          WordsReview.id: (context) => WordsReview(),
          Training.id: (context) => Training(),
          Matches.id: (context) => Matches(),
          Result.id: (context) => Result(),
        },
      ),
    );
  }
}
