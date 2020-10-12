import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

import 'package:words_app/cubit/words/words_cubit.dart';

import 'package:words_app/screens/screens.dart';
import 'package:words_app/screens/words_screen/widgets/body.dart';

class WordsScreen extends StatelessWidget {
  static String id = 'collection_manager_screen';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Map args = ModalRoute.of(context).settings.arguments;
    String collectionId = args['id'];
    String collectionTitle = args['title'];
    String collectionLang = args['lang'];

    return WillPopScope(
      /// Overriding Back navigation logic --> exit from EditMode
      onWillPop: () async {
        context.bloc<WordsCubit>().toggleEditModeToFalse();
        context.bloc<WordsBloc>().add(WordsTurnOffIsEditingMode());
        Navigator.pushNamedAndRemoveUntil(context, CollectionsScreen.id,
            ModalRoute.withName(CollectionsScreen.id));
        context.bloc<CollectionsBloc>().add(CollectionsLoaded());
        return;
      },
      child: SafeArea(
        // Exclude top from SafeArea
        top: true,
        child: Scaffold(
          body: BlocBuilder<WordsBloc, WordsState>(
            builder: (context, state) {
              if (state is WordsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WordsSuccess) {
                return Body(
                    collectionTitle: collectionTitle,
                    collectionId: collectionId,
                    state: state,
                    collectionLang: collectionLang);
              }
              return Text('Somthing went wrong....');
            },
          ),
        ),
      ),
    );
  }
}
