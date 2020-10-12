import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/animations/shake_animation.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/config/size_config.dart';

import 'package:words_app/widgets/widgets.dart';

import '../../screens.dart';
import 'btns.dart';
import 'collection_text_holder.dart';

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
                      _buildCollectionTitle(defaultSize, context),
                      _buildMySeparator(defaultSize),
                      SizedBox(height: defaultSize * 2),
                      _buildLanguagePicker(defaultSize),
                      SizedBox(height: 5.0),
                      _buildWordCounter(defaultSize)
                    ],
                  ),
                ),
              ),
            ),
            _buildEditDeleteBtns(
                context,
                collections[index].isEditingBtns,
                defaultSize,
                () => showEditDialog(collections[index]),
                collections[index].id)
          ],
        ),
      ),
    );
  }

  Container _buildCollectionTitle(double defaultSize, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: defaultSize * 1),
      alignment: Alignment.center,
      height: defaultSize * 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultSize * 1),
          topRight: Radius.circular(defaultSize * 1),
        ),
      ),
      child: FittedBox(
        child: Padding(
          padding: EdgeInsets.all(defaultSize * 1),
          child: Text(
            collections[index].title ?? '',
            style: Theme.of(context)
                .primaryTextTheme
                .bodyText2
                .merge(TextStyle(fontSize: defaultSize * 4)),
          ),
        ),
      ),
    );
  }

  CollectionTextHolder _buildWordCounter(double defaultSize) {
    return CollectionTextHolder(
      titleName: 'words: ',
      titleNameValue: collections[index].wordCount.toString(),
      fontSize1: defaultSize * 1.5,
      fontSize2: defaultSize * 1.5,
    );
  }

  FittedBox _buildLanguagePicker(double defaultSize) {
    return FittedBox(
      child: CollectionTextHolder(
        titleNameValue: languageMap[collections[index].language] ?? ' ',
        fontSize1: defaultSize * 1.5,
        fontSize2: defaultSize * 1.5,
      ),
    );
  }

  MySeparator _buildMySeparator(double defaultSize) {
    return MySeparator(
      padding: EdgeInsets.symmetric(
          horizontal: defaultSize * 1, vertical: defaultSize * 0.5),
      dWidth: defaultSize * 0.2,
      dCount: defaultSize * 0.4,
      color: Colors.grey,
      height: defaultSize * 0.2,
    );
  }

  Widget _buildEditDeleteBtns(BuildContext context, bool isEditingBtns,
      double defaultSize, Function showDialog, String id) {
    return isEditingBtns
        ? Positioned(
            top: defaultSize * (-0.1),
            left: defaultSize * 7.6,
            child: Row(
              children: <Widget>[
                // Edit btn
                Btns(
                    backgroundColor: Colors.white,
                    icon: Icons.edit,
                    color: Colors.black54,
                    onPress: () {
                      BlocProvider.of<CollectionsBloc>(context)
                          .add(CollectionsToggleAll());
                      showDialog();
                    }),

                Btns(
                  backgroundColor: Colors.white,
                  icon: Icons.delete,
                  color: Colors.black54,
                  onPress: () {
                    deleteConfirmation(context, () {
                      BlocProvider.of<CollectionsBloc>(context)
                        ..add(CollectionsDeleted(id: id));
                      Navigator.pop(context);
                    }, 'Do you want to delete your collection?');
                  },
                ),
                SizedBox(width: defaultSize * 0.5),
              ],
            ).shakeAnimation,
          )
        : Container();
  }
}

extension AnimationExtension on Widget {
  Widget get shakeAnimation {
    return ShakeAnimation(child: this);
  }
}
