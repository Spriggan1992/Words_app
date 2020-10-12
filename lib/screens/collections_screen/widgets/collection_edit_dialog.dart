import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/config/constants.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/config/size_config.dart';
import 'package:words_app/widgets/widgets.dart';

import 'widgets.dart';

class CollectionsEditDialog extends StatefulWidget {
  const CollectionsEditDialog({
    this.index,
    this.onSaveForm,
    this.collection,
    Key key,
  }) : super(key: key);

  final int index;
  final Function onSaveForm;
  final Collection collection;

  @override
  _CollectionsEditDialogState createState() => _CollectionsEditDialogState();
}

class _CollectionsEditDialogState extends State<CollectionsEditDialog> {
  String _onSubmitTitleField;
  String _onSubmitLanguageField;
  @override
  void initState() {
    super.initState();
    _onSubmitLanguageField = widget.collection.language;
    _onSubmitTitleField = widget.collection.title;
  }

  @override
  Widget build(BuildContext context) {
    var _languages = [
      'fi',
      'en',
      "zh",
      'de',
      'cz',
      'da',
      'es',
      'fr',
      'id',
      'it',
      'hu',
      'nl',
      'no',
      'pl',
      'ru',
    ];
    //cs, da, de, en, es, fr, id, it, hu, nl, no, pl, pt, ro, sk, fi, sv, tr, vi, th, bg, ru, el, ja, ko, zh
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

    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      height: SizeConfig.blockSizeVertical * 43,
      width: SizeConfig.blockSizeHorizontal * 56,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(top: defaultSize * 2),
            height: SizeConfig.blockSizeVertical * 38,
            width: SizeConfig.blockSizeHorizontal * 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultSize * 1),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildCollectionTitle(defaultSize),
                Flexible(child: SizedBox(height: defaultSize * 1)),
                _buildMySeparator(defaultSize),
                Flexible(
                  child: SizedBox(height: defaultSize * 5),
                ),
                _buildLanguagePicker(_languages, languageMap, defaultSize),
                Flexible(child: SizedBox(height: defaultSize * 0.5)),
                _buildWordCounter(defaultSize),
                Flexible(child: SizedBox(height: defaultSize * 26)),
              ],
            ),
          ),
          _buildeBtns(defaultSize),
        ],
      ),
    );
  }

  Container _buildCollectionTitle(double defaultSize) {
    return Container(
      alignment: Alignment.center,
      width: defaultSize * 20,
      child: TextField(
          expands: false,
          style: TextStyle(fontSize: defaultSize * 2.5),
          textAlign: TextAlign.center,
          decoration: InputDecoration(border: InputBorder.none),
          controller: TextEditingController(text: widget.collection.title),
          onChanged: (value) {
            _onSubmitTitleField = value;
          }),
    );
  }

  Flexible _buildMySeparator(double defaultSize) {
    return Flexible(
      child: MySeparator(
        padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
        dWidth: 3.0,
        dCount: 5.0,
        color: Colors.grey,
        height: 3.0,
      ),
    );
  }

  Container _buildLanguagePicker(List<String> _languages,
      Map<String, String> languageMap, double defaultSize) {
    return Container(
      child: DropdownButton(
        items: _languages
            .map(
              (language) => DropdownMenuItem(
                value: language,
                child: Text(languageMap[language],
                    style: TextStyle(
                        fontSize: defaultSize * 2.5,
                        color: kLanguagePickerColor)),
              ),
            )
            .toList(),
        value: _onSubmitLanguageField,
        onChanged: (value) {
          setState(() {
            _onSubmitLanguageField = value;
          });
        },
      ),
    );
  }

  CollectionTextHolder _buildWordCounter(double defaultSize) {
    return CollectionTextHolder(
      titleName: 'words:   ',
      titleNameValue: widget.collection.wordCount.toString(),
      fontSize1: defaultSize * 2.5,
      fontSize2: defaultSize * 2.5,
    );
  }

  Widget _buildeBtns(double defaultSize) {
    return Positioned(
      top: defaultSize * 0.5,
      left: defaultSize * 15.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Done btn
          CustomRoundBtn(
            icon: Icons.check,
            fillColor: Theme.of(context).accentColor,
            // onPressed: onSaveForm,
            onPressed: () {
              context.bloc<CollectionsBloc>().add(
                    CollectionsUpdated(
                        id: widget.collection.id,
                        title: _onSubmitTitleField,
                        language: _onSubmitLanguageField),
                  );
              Navigator.pop(context);
            },
          ),

          // Close btn
          CustomRoundBtn(
            fillColor: Theme.of(context).primaryColor,
            icon: Icons.close,
            onPressed: () => Navigator.of(context).pop(),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
