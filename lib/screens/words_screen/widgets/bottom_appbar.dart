import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

class WordsBottomAppbar extends StatelessWidget {
  final bool isEditingMode;
  final String collectionId;
  final String collectionLang;
  final WordsSuccess state;

  const WordsBottomAppbar(
      {Key key,
      this.isEditingMode,
      this.collectionId,
      this.collectionLang,
      this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseBottomAppbar(
        screenDefiner: ScreenDefiner.words,
        add: isEditingMode
            ? () {}
            : () {
                Navigator.pushNamed(
                  context,
                  CardCreator.id,
                  arguments: {
                    'isEditingMode': false,
                    'collectionId': collectionId,
                    'lang': collectionLang,
                  },
                );
                context.bloc<CardCreatorBloc>().add(CardCreatorLoaded(
                    word: Word(),
                    isEditingMode: false,
                    collectionLaguage: collectionLang));
              },
        goToCollection: () {
          context.bloc<CollectionsBloc>().add(CollectionsLoaded());
          context.bloc<WordsCubit>().toggleEditModeToFalse();
          Navigator.pushNamed(context, CollectionsScreen.id);
        },
        goToTrainings: () {
          context.bloc<TrainingManagerBloc>().add(TrainingManagerLoaded(
              words: state.words, collectionId: collectionId));
          Navigator.pushNamed(
            context,
            TrainingManager.id,
          );
          context.bloc<WordsCubit>().toggleEditModeToFalse();
          context.bloc<WordsBloc>().add(WordsTurnOffIsEditingMode());
        },
        trainingsWordCounter: "${state.words?.length ?? 0}",
      ),
    );
  }
}
