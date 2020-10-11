import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/config/constants.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/utils/size_config.dart';
import 'package:words_app/widgets/widgets.dart';

import 'collection_widgets.dart';

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
  String onSubmitTitleField;
  String onSubmitLanguageField;
  @override
  void initState() {
    super.initState();
    onSubmitLanguageField = widget.collection.language;
    onSubmitTitleField = widget.collection.title;
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
      height: SizeConfig.blockSizeVertical * 50,
      width: SizeConfig.blockSizeHorizontal * 56,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(top: defaultSize * 2),
            height: SizeConfig.blockSizeVertical * 45,
            width: SizeConfig.blockSizeHorizontal * 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultSize * 1),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Title Text Field
                Container(
                  alignment: Alignment.center,
                  width: defaultSize * 20,
                  child: TextField(
                      expands: false,
                      style: TextStyle(fontSize: defaultSize * 2.5),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller:
                          TextEditingController(text: widget.collection.title),
                      onChanged: (value) {
                        onSubmitTitleField = value;
                      }),
                ),
                Flexible(child: SizedBox(height: defaultSize * 1)),
                Flexible(
                  child: MySeparator(
                    padding: EdgeInsets.symmetric(horizontal: defaultSize * 1),
                    dWidth: 3.0,
                    dCount: 5.0,
                    color: Colors.grey,
                    height: 3.0,
                  ),
                ),
                Flexible(
                  child: SizedBox(height: defaultSize * 3),
                ),

                Container(
                  child: DropdownButton(
                    // value: collection.language,
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
                    value: onSubmitLanguageField,
                    onChanged: (value) {
                      setState(() {
                        onSubmitLanguageField = value;
                      });
                    },
                  ),
                ),
                Flexible(child: SizedBox(height: defaultSize * 0.5)),
                // Words Text Holder
                CollectionTextHolder(
                  titleName: 'words:   ',
                  titleNameValue: widget.collection.wordCount.toString(),
                  fontSize1: defaultSize * 2.5,
                  fontSize2: defaultSize * 2.5,
                ),
                Flexible(child: SizedBox(height: defaultSize * 2.5)),

                Flexible(child: SizedBox(height: defaultSize * 4)),
              ],
            ),
          ),
          Positioned.fill(
            top: defaultSize * 27,
            right: defaultSize * 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            ),
          ),
          Positioned(
            // bottom: 300,
            // left: 50,
            top: defaultSize * 0.5,
            left: defaultSize * 14.5,
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
                              title: onSubmitTitleField,
                              language: onSubmitLanguageField),
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
          ),
        ],
      ),
    );
  }
}
