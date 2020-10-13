import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/config/size_config.dart';
import 'package:words_app/widgets/widgets.dart';
import '../../screens.dart';
import 'widgets.dart';

class CollectionCard extends StatelessWidget {
  CollectionCard({
    this.goToManagerCollections,
    this.index,
    this.showEditDialog,
    this.collections,
  });

  final Function goToManagerCollections;
  final int index;
  final List<Collection> collections;
  final Function showEditDialog;
  Map<String, String> languageMap = {
    'fi': "finnish",
    'en': "english",
    "zh": "chinese",
    'de': "german",
    'cz': 'czech',
    'da': 'danish',
    'es': 'spanish',
    'fr': 'french',
    'id': 'indonesian',
    'it': 'italian',
    'hu': 'hungarian',
    'nl': 'nederlands',
    'no': 'norwegian',
    'pl': 'polish',
    'ru': 'russian',
  };
  @override
  Widget build(BuildContext context) {
    final double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: collections[index].isEditingBtns
          ? () {}
          : () {
              Navigator.pushNamed(
                context,
                WordsScreen.id,
                arguments: {
                  'id': collections[index].id,
                  'title': collections[index].title,
                  'lang': collections[index].language,
                },
              );
              context.bloc<CollectionsBloc>().add(CollectionsSetToFalse());
              context.bloc<WordsBloc>()
                ..add(
                  WordsLoaded(
                    id: collections[index].id,
                  ),
                );
            },
      onLongPress: () {
        BlocProvider.of<CollectionsBloc>(context).add(CollectionsToggleAll());
      },
      child: Padding(
        padding: EdgeInsets.only(top: defaultSize * 2),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          overflow: Overflow.visible,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: defaultSize * 1,
                  right: defaultSize * 0.5,
                  left: defaultSize * 0.5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultSize * 0.4),
                    color: Colors.white,
                    border: Border.all(color: Colors.white)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultSize * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Title
                      CollectionCardTitle(title: collections[index].title),
                      // Separator
                      MySeparator(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultSize * 1,
                            vertical: defaultSize * 0.5),
                        dWidth: defaultSize * 0.2,
                        dCount: defaultSize * 0.4,
                        color: Colors.grey,
                        height: defaultSize * 0.2,
                      ),
                      SizedBox(height: defaultSize * 2),
                      // Language picker
                      FittedBox(
                        child: CollectionTextHolder(
                          titleNameValue:
                              languageMap[collections[index].language] ?? ' ',
                          fontSize1: defaultSize * 1.5,
                          fontSize2: defaultSize * 1.5,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      // Words counter
                      CollectionTextHolder(
                        titleName: 'words: ',
                        titleNameValue: collections[index].wordCount.toString(),
                        fontSize1: defaultSize * 1.5,
                        fontSize2: defaultSize * 1.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Btns
            CollectionCardEditDeleteBtns(
                id: collections[index].id,
                isEditingBtns: collections[index].isEditingBtns,
                showDialog: () => showEditDialog(
                      collections[index],
                    )),
          ],
        ),
      ),
    );
  }
}
