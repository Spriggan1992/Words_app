import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';

import 'package:words_app/config/constants.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/config/size_config.dart';
import 'package:words_app/widgets/widgets.dart';

import '../../screens.dart';

class DialogAddCollection extends StatefulWidget {
  const DialogAddCollection({
    Key key,
  }) : super(key: key);

  @override
  _DialogAddCollectionState createState() => _DialogAddCollectionState();
}

class _DialogAddCollectionState extends State<DialogAddCollection> {
  String _collectionTitle;
  // String collectionLanguage;
  String _collectionLanguage = 'english';

  var _languages = [
    "finnish",
    "english",
    "chinese",
    "german",
    'czech',
    'danish',
    'spanish',
    'french',
    'indonesian',
    'italian',
    'hungarian',
    'nederlands',
    'norwegian',
    'polish',
    'russian',
  ];
  //cs, da, de, en, es, fr, id, it, hu, nl, no, pl, pt, ro, sk, fi, sv, tr, vi, th, bg, ru, el, ja, ko, zh
  Map<String, String> languageMap = {
    "finnish": 'fi',
    "english": 'en',
    "chinese": 'zh',
    "german": 'de',
    'czech': 'cs',
    'danish': 'da',
    'spanish': 'es',
    'french': 'fr',
    'indonesian': 'id',
    'italian': 'it',
    'hungarian': 'hu',
    'nederlands': 'nl',
    'norwegian': 'no',
    'polish': 'pl',
    'russian': 'ru',
  };

  @override
  Widget build(BuildContext context) {
    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      height: SizeConfig.blockSizeHorizontal * 70,
      width: SizeConfig.blockSizeHorizontal * 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCloseBtn(context),
          SizedBox(height: defaultSize * 2),
          _buildCollectionTitleField(defaultSize, context),
          SizedBox(height: defaultSize * 2),
          _buildLanguagePicker(defaultSize),
          SizedBox(height: defaultSize * 2),
          _buildCreateCollectionBtn(defaultSize, context)
        ],
      ),
    );
  }

  Widget _buildCloseBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomRoundBtn(
          fillColor: Theme.of(context).primaryColor,
          icon: Icons.close,
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  Container _buildCollectionTitleField(
    double defaultSize,
    BuildContext context,
  ) {
    return Container(
      decoration: innerShadow,
      child: TextField(
        style: kHintStyle,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                vertical: defaultSize * 1.3, horizontal: defaultSize * 1),
            filled: true,
            hintStyle: Theme.of(context).primaryTextTheme.bodyText2.merge(
                  kHintStyle,
                ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultSize * 1),
                borderSide: BorderSide.none),
            hintText: 'Collection name',
            isDense: true),
        onChanged: (value) {
          _collectionTitle = value;
        },
      ),
    );
  }

  Container _buildLanguagePicker(double defaultSize) {
    return Container(
      alignment: Alignment.center,
      decoration: innerShadow,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: defaultSize * 1, horizontal: defaultSize * 2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultSize * 1),
                borderSide: BorderSide.none,
              ),
            ),
            isEmpty: _collectionLanguage == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _collectionLanguage,
                isDense: true,
                onChanged: (newValue) {
                  setState(
                    () {
                      _collectionLanguage = newValue;
                      state.didChange(newValue);
                    },
                  );
                },
                items: _languages.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                            kHintStyle,
                          ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  RaisedButton _buildCreateCollectionBtn(
    double defaultSize,
    BuildContext context,
  ) {
    return RaisedButton(
      highlightElevation: 5,
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultSize * 1)),
      padding: EdgeInsets.zero,
      color: Color(0xffDA627D),
      child: Text(
        'CREATE COLLECTION',
        style: Theme.of(context).primaryTextTheme.bodyText2.merge(
              TextStyle(color: Colors.white),
            ),
      ),
      onPressed: () {
        Collection collection = Collection(
          language: languageMap[_collectionLanguage],
          title: _collectionTitle,
        );
        context.bloc<CollectionsBloc>().add(
              CollectionsAdded(
                collection: collection,
              ),
            );
        context.bloc<WordsBloc>().add(
              WordsLoaded(
                id: collection.id,
              ),
            );

        Navigator.pushNamed(
          context,
          WordsScreen.id,
          arguments: {
            "id": collection.id,
            'title': collection.title,
          },
        );
      },
    );
  }
}
