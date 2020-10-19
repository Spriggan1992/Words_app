import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      BlocProvider<TrainingManagerBloc>(
        create: (context) {
          return TrainingManagerBloc(
            wordsRepository: WordsRepository(),
            collectionsRepository: CollectionsRepository(),
            trainingManagerRepository: TrainingManagerRepository(),
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
      BlocProvider<ThemeBloc>(
        create: (context) {
          return ThemeBloc()..add(LoadedTheme());
        },
      ),
      BlocProvider<YesNoGameBloc>(
        create: (context) {
          return YesNoGameBloc(
              trainingManagerBloc: context.bloc<TrainingManagerBloc>());
        },
      ),
      BlocProvider<BricksBloc>(
        create: (context) {
          return BricksBloc(
              trainingManagerBloc: context.bloc<TrainingManagerBloc>());
        },
      ),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Bricks(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Word App',
            debugShowCheckedModeBanner: false,
            initialRoute: CollectionsScreen.id,
            theme: state.themeData,
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
          );
        },
      ),
    );
  }
}
