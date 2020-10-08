import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/models/models.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 340,
      width: 80,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 300,
            width: screenWidth * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Title Text Field
                Container(
                  alignment: Alignment.center,
                  width: 200,
                  child: TextField(
                      expands: false,
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller:
                          TextEditingController(text: widget.collection.title),
                      onChanged: (value) {
                        onSubmitTitleField = value;
                      }),
                ),
                Flexible(child: SizedBox(height: 10)),
                Flexible(
                  child: MySeparator(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    dWidth: 3.0,
                    dCount: 5.0,
                    color: Colors.grey,
                    height: 3.0,
                  ),
                ),
                Flexible(
                  child: SizedBox(height: 30.0),
                ),
                // Container(
                //   width: 200,
                //   child: TextField(
                //     style: TextStyle(fontSize: 25, color: Color(0xFF34c7b3)),
                //     controller:
                //         TextEditingController(text: collection.language),
                //     textAlign: TextAlign.center,
                //     decoration: InputDecoration(border: InputBorder.none),
                //     onChanged: (value) {
                //       onSubmitLanguageField = value;
                //     },
                //   ),
                // ),
                Container(
                  child: DropdownButton(
                    // value: collection.language,
                    items: _languages
                        .map(
                          (language) => DropdownMenuItem(
                            value: language,
                            child: Text(languageMap[language],
                                style: TextStyle(
                                    fontSize: 25, color: Color(0xFF34c7b3))),
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
                Flexible(child: SizedBox(height: 5.0)),
                // Words Text Holder
                CollectionTextHolder(
                  titleName: 'words:   ',
                  titleNameValue: widget.collection.wordCount.toString(),
                  fontSize1: 25.0,
                  fontSize2: 25.0,
                ),
                Flexible(child: SizedBox(height: 25.0)),
                // Learned Text Holder
                // CollectionTextHolder(
                //   titleName: 'learned:   ',
                //   titleNameValue: '  11',
                //   fontSize1: 20.0,
                //   fontSize2: 25.0,
                // ),
                Flexible(child: SizedBox(height: 40)),
              ],
            ),
          ),
          Positioned.fill(
            top: 270,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[],
            ),
          ),
          Positioned(
            // bottom: 300,
            // left: 50,
            top: 5.0,
            left: 138,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Done btn

                CustomRoundBtn(
                  icon: Icons.check,
                  fillColor: Color(0xffDA627D),
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
                  fillColor: Color(0xff450920),
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
