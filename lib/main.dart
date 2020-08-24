import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'repositories/collections_provider.dart';
import 'repositories/pair_game_card_provider.dart';
import 'repositories/training_matches_provider.dart';
import 'repositories/validation_provider.dart';
import 'repositories/words_provider.dart';
import 'screens/card_creator_screen//card_creator.dart';
import 'screens/collections_screen/collections_screen.dart';
import 'screens/loging_screen/login_screen.dart';
import 'screens/pair_game_screen/pair_game.dart';
import 'screens/registration_screen/registration_screen.dart';
import 'screens/result_screen/result_screen.dart';
import 'screens/review_card_screen/review_card.dart';
import 'screens/training_manager_screen/training_manager_screen.dart';
import 'screens/training_screen/matches.dart';
import 'screens/training_screen/training_screen.dart';
import 'screens/welcome_screen/welcom_screen.dart';
import 'screens/words_screen/words_screen.dart';

// import 'package:hive/hive.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create this textTheme  because there're  two fonts in app
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Collections(),
        ),
        ChangeNotifierProvider(
          create: (_) => Words(),
        ),
        ChangeNotifierProvider(
          create: (_) => ValidationForm(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrainingMatches(),
        ),
        ChangeNotifierProvider(
          create: (_) => GameCards(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          //primary font is Montserrat and font for appbar titles is Anybody
          primaryTextTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
            headline6: TextStyle(
              color: Color(0xffA53860),
              fontFamily: 'Anybody',
              fontStyle: FontStyle.italic,
            ),
            bodyText1: TextStyle(
              color: Color(0xFFDA627D),
            ),
            bodyText2: TextStyle(
              color: Color(0xFFDA627D),
            ),
          ),
          primaryColor: Color(0xff450920),
          accentColor: Color(0xFFDA627D),
          backgroundColor: Color(0xffEAE2DA),
          scaffoldBackgroundColor: Color(0xffEAE2DA),
          bottomAppBarColor: Color(0xffA53860),
//          primaryTextTheme:
//              //this responsible for appBAr title
//              TextTheme(
//            headline6: TextStyle(
//              color: Color(0xffA53860),
//            ),
//          ),
        ),
        title: 'Word App',
        debugShowCheckedModeBanner: false,
        initialRoute: CollectionsScreen.id,
        routes: {
          WelcomScreen.id: (_) => WelcomScreen(),
          LoginScreen.id: (_) => LoginScreen(),
          RegistrationScreen.id: (_) => RegistrationScreen(),
          CollectionsScreen.id: (_) => CollectionsScreen(),
          WordsScreen.id: (_) => WordsScreen(),
          CardCreator.id: (_) => CardCreator(),
          ReviewCard.id: (_) => ReviewCard(),
          Training.id: (_) => Training(),
          Matches.id: (_) => Matches(),
          PairGame.id: (_) => PairGame(),
          Result.id: (_) => Result(),
          TrainingManager.id: (_) => TrainingManager(),
        },
      ),
    );
  }
}
