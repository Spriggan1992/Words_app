import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';

import 'package:words_app/components/custom_round_btn.dart';
import 'package:words_app/constants/constants.dart';

class DialogAddCollection extends StatefulWidget {
  const DialogAddCollection({
    Key key,
  }) : super(key: key);

  @override
  _DialogAddCollectionState createState() => _DialogAddCollectionState();
}

class _DialogAddCollectionState extends State<DialogAddCollection> {
  FocusNode myFocusNodeCollectionName;
  FocusNode myFocusNodeLanguage;
  String collectionTitle;
  // String collectionLanguage;
  double heightCollectionName = 0;
  double heightLanguage = 1.2;
  bool isTextCollectionNameFiledEmpty = true;
  bool isLanguageTextFileEmpty = true;
  String collectionLanguage;

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
  void initState() {
    super.initState();
    myFocusNodeLanguage = FocusNode();
    myFocusNodeCollectionName = FocusNode();
  }

  @override
  void dispose() {
    myFocusNodeLanguage.dispose();
    myFocusNodeCollectionName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Setup height for [heightCollectionName]
    // myFocusNodeCollectionName.addListener(() {
    //   setState(() {
    //     if (myFocusNodeCollectionName.hasFocus ||
    //         !isTextCollectionNameFiledEmpty) {
    //       heightCollectionName = 0.0;
    //     } else {
    //       heightCollectionName = 1.2;
    //     }
    //   });
    // });
    // Setup height for [heightLanguage]
    // myFocusNodeLanguage.addListener(() {
    //   setState(() {
    //     if (myFocusNodeLanguage.hasFocus || !isLanguageTextFileEmpty) {
    //       heightLanguage = 0;
    //     } else {
    //       heightLanguage = 1.2;
    //     }
    //   });
    // });

    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.43,
      width: size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              CustomRoundBtn(
                fillColor: Color(0xff450920),
                icon: Icons.close,
                onPressed: () => Navigator.of(context).pop(),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: innerShadow,
            child: TextField(
              // focusNode: myFocusNodeCollectionName,
              // autofocus: true,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  // fillColor: Colors.white.withOpacity(0.6),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Color(0xFFDA627D).withOpacity(0.5),
                    fontSize: 20,
                    height: heightCollectionName,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Collection name',
                  isDense: true),
              onChanged: (value) {
                context
                    .bloc<CollectionDetailBloc>()
                    .add(CollectionTitleUpdated(title: value));
              },
            ),
          ),
          SizedBox(height: 20),
          // Container(
          //   decoration: innerShadow,
          //   child: TextFormField(
          //     focusNode: myFocusNodeLanguage,
          //     textAlign: TextAlign.center,
          //     decoration: InputDecoration(
          //       fillColor: Colors.white.withOpacity(0.6),
          //       filled: true,
          //       labelStyle: TextStyle(
          //         color: Colors.grey[500],
          //         fontSize: 18,
          //         height: heightLanguage,
          //       ),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10),
          //           borderSide: BorderSide.none),
          //       labelText: 'Language',
          //       isDense: true,
          //     ),
          //     onChanged: (value) {
          //       collectionLanguage = value;
          //       if (collectionTitle.length > 0) {
          //         isLanguageTextFileEmpty = false;
          //       } else {
          //         isLanguageTextFileEmpty = true;
          //       }
          //     },
          //   ),
          // ),
          // SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            decoration: innerShadow,
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  isEmpty: collectionLanguage == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: collectionLanguage ?? 'english',
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(
                          () {
                            context.bloc<CollectionDetailBloc>().add(
                                CollectionLanguageUpdated(language: newValue));
                            state.didChange(newValue);
                          },
                        );
                      },
                      items: _languages.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Color(0xFFDA627D).withOpacity(0.5),
                              fontSize: 20,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),

          /// Create collection Btn
          RaisedButton(
            highlightElevation: 5,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(0),
            color: Color(0xffDA627D),
            child: Text(
              'CREATE COLLECTION',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // Collection collection = Collection(
              //   language: languageMap[collectionLanguage],
              //   title: collectionTitle,
              // );
              // FIXME: Collection_details
              context.bloc<CollectionDetailBloc>().add(CollectionDetailAdded());
              // context.bloc<WordsBloc>().add(
              //       WordsLoaded(
              //         id: collection.id,
              //       ),
              //     );

              // Navigator.pushNamed(
              //   context,
              //   WordsScreen.id,
              //   arguments: {
              //     "id": collection.id,
              //     'title': collection.title,
              //   },
              // );
              context.bloc<CollectionsBloc>().add(CollectionsLoaded());
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
