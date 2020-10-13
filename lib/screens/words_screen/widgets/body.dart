import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:words_app/bloc/blocs.dart';

import 'package:words_app/cubit/words/words_cubit.dart';

import 'widgets.dart';

class Body extends StatelessWidget {
  final String collectionTitle;
  final String collectionId;
  final String collectionLang;
  final WordsSuccess state;

  const Body(
      {Key key,
      this.collectionTitle,
      this.collectionId,
      this.collectionLang,
      this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /// Use cubit to switch editing mode(For selecting words);
      child: BlocBuilder<WordsCubit, bool>(
        builder: (context, isEditingMode) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WordsAppbar(
                isEditingMode: isEditingMode,
                collectionTitle: collectionTitle,
                collectionId: collectionId,
                state: state,
              ),
              WordsListView(
                collectionId: collectionId,
                collectionLang: collectionLang,
                collectionTitle: collectionTitle,
                isEditingMode: isEditingMode,
                state: state,
              ),
              WordsBottomAppbar(
                state: state,
                isEditingMode: isEditingMode,
                collectionId: collectionId,
                collectionLang: collectionLang,
              ),
            ],
          );
        },
      ),
    );
  }
}
