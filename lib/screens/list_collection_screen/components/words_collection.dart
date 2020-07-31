import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/screens/list_collection_screen/components/btns.dart';
import 'package:words_app/screens/list_collection_screen/components/list_collection_dialog.dart';

import 'package:words_app/screens/list_collection_screen/components/my_separator.dart';
import 'package:words_app/screens/list_collection_screen/components/text_holder.dart';

class WordsCollection extends StatelessWidget {
  WordsCollection({
    this.goToManagerCollections,
    this.onSubmitTitleField,
    this.onChanged,
    this.deleteCollection,
    this.index,
    this.onSaveForm,
    this.onSubmitLanguageField,
  });

  final Function goToManagerCollections;

  final Function onSubmitTitleField;
  final Function onChanged;
  final Function deleteCollection;
  final Function onSubmitLanguageField;
  final int index;

  final Function onSaveForm;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Collections>(context, listen: false)
        .wordsCollectionData[index];
    return GestureDetector(
        onTap: () => goToManagerCollections(providerData.id), // Go to managerCollection
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            overflow: Overflow.visible,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
                child: Container(
                  key: ValueKey(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          height: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, right: 1, bottom: 1, left: 1),
                              child: Text(
                                providerData.title ?? '',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        MySeparator(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          dWidth: 2.0,
                          dCount: 4.0,
                          color: Colors.grey,
                          height: 2.0,
                        ),
                        TextHolder(
                          titleName: 'language: ',
                          titleNameValue: providerData.language,
                          fontSize1: 9.0,
                          fontSize2: 15.0,
                        ),
                        SizedBox(height: 5.0),
                        TextHolder(
                          titleName: 'words: ',
                          titleNameValue: '16',
                          fontSize1: 9.0,
                          fontSize2: 15.0,
                        ),
                        SizedBox(height: 5.0),
                        TextHolder(
                          titleName: 'learned: ',
                          titleNameValue: '11',
                          fontSize1: 9.0,
                          fontSize2: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -1,
                left: 83,
                child: Container(
                  child: Row(
                    children: <Widget>[
                      // Edit btn
                      Btns(
                          backgroundColor: Colors.white,
                          icon: Icons.edit,
                          color: Colors.green[300],
                          onPress: () {
                            // Open Dialog Window
                            showEditDialog(
                              context,
                              index,
                              deleteCollection,
                              onSaveForm,
                              onSubmitTitleField,
                              onSubmitLanguageField,
                            );
                          }),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future showEditDialog(
    BuildContext context,
    index,
    deleteCollection,
    onSaveForm,
    onSubmitTitleField,
    onSubmitLanguageField,
  ) {
    return showGeneralDialog(
        barrierColor: Color(0xFFb48484).withOpacity(0.9),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  content: StatefulBuilder(builder: (context, setState) {
                    return CollectionListDialog(
                        index: index,
                        deleteCollection: deleteCollection,
                        onSubmit: onSubmitTitleField,
                        onSaveForm: onSaveForm,
                        onSubmitLanguageField: onSubmitLanguageField);
                  }),
                ),
              ));
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {});
  }
}
