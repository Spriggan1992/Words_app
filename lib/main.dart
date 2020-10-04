import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:words_app/screens/screens.dart';

import 'bloc/blocs.dart';
import 'cubit/card_creator/part_color/part_color_cubit.dart';
import 'cubit/words/words_cubit.dart';
import 'repositories/repositories.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider<CollectionsBloc>(
        create: (context) {
          return CollectionsBloc(
            collectionsRepository: CollectionsRepository(),
          )..add(CollectionsLoaded());
        },
      ),
      BlocProvider<WordsBloc>(
        create: (context) {
          return WordsBloc(
            wordsRepository: WordsRepository(),
          );
        },
      ),
      BlocProvider<CardCreatorBloc>(
        create: (context) {
          return CardCreatorBloc(
            imageRepository: ImageRepository(),
          );
        },
      ),
      BlocProvider<TrainingsBloc>(
        create: (context) {
          return TrainingsBloc(
            wordsRepository: WordsRepository(),
            collectionsRepository: CollectionsRepository(),
          );
        },
      ),
      BlocProvider<WordsCubit>(
        create: (context) {
          return WordsCubit();
        },
      ),
      BlocProvider<PartColorCubit>(
        create: (context) {
          return PartColorCubit();
        },
      ),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create this textTheme  because there're  two fonts in  app app
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => CollectionsRepository(),
        // ),
        ChangeNotifierProvider(
          create: (_) => WordsRepository(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => ValidationForm(),
        // ),
        ChangeNotifierProvider(
          create: (_) => Bricks(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          //primary font is Montserrat and font for appbar titles is Anybody
          primaryTextTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
            // responsible for title colors in the app, AppBar title color and style
            headline6: TextStyle(
              color: Color(0xffA53860),
              fontFamily: 'Anybody',
              fontStyle: FontStyle.italic,
              fontSize: 20,
            ),
            // bodyText1: TextStyle(
            //   color: Color(0xFFDA627D),
            // ),

            // to apply it on Text, you need specify Theme.of(context).primaryTextField.bodyText2
            bodyText2: GoogleFonts.montserrat(
                textStyle: TextStyle(
              color: Colors.black,
            )),
            // bodyText2: TextStyle(
            //   color: Colors.green,
            //   fontSize: 40,
            // ),
          ),
          //resposible for appBArColor
          primaryColor: Color(0xff450920),
          buttonColor: Color(0xFFDA627D),
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
          CollectionsScreen.id: (_) => CollectionsScreen(),
          WordsScreen.id: (_) => WordsScreen(),
          CardCreator.id: (_) => CardCreator(),
          ReviewCard.id: (_) => ReviewCard(),
          YesNoGame.id: (_) => YesNoGame(),
          BricksGame.id: (_) => BricksGame(),
          PairGame.id: (_) => PairGame(),
          ResultScreen.id: (_) => ResultScreen(),
          TrainingManager.id: (_) => TrainingManager(),
          ImageApi.id: (_) => ImageApi(),
        },
      ),
    );
  }
}
