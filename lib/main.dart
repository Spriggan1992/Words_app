import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/providers/pair_game_card_provider.dart';
import 'package:words_app/providers/training_matches_provider.dart';
import 'package:words_app/providers/validation_provider.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/card_creator_screen//card_creator.dart';
import 'package:words_app/screens/loging_screen/login_screen.dart';
import 'package:words_app/screens/pair_game_screen/pair_game.dart';
import 'package:words_app/screens/registration_screen/registration_screen.dart';
import 'package:words_app/screens/list_collection_screen/words_collections_list_screen.dart';
import 'package:words_app/screens/review_card_screen/review_card.dart';
import 'package:words_app/screens/training_screen/matches.dart';
import 'package:words_app/screens/welcome_screen/welcom_screen.dart';
import 'screens/manager_collection/collection_manager.dart';
import 'package:words_app/screens/training_screen/training_screen.dart';
import 'package:words_app/screens/result_screen/result_screen.dart';

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
        initialRoute: WordsCollectionsList.id,
        routes: {
          WelcomScreen.id: (_) => WelcomScreen(),
          LoginScreen.id: (_) => LoginScreen(),
          RegistrationScreen.id: (_) => RegistrationScreen(),
          WordsCollectionsList.id: (_) => WordsCollectionsList(),
          CollectionManager.id: (_) => CollectionManager(),
          CardCreator.id: (_) => CardCreator(),
          ReviewCard.id: (_) => ReviewCard(),
          Training.id: (_) => Training(),
          Matches.id: (_) => Matches(),
          PairGame.id: (_) => PairGame(),
          Result.id: (_) => Result(),
        },
      ),
    );
  }
}
