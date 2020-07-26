import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/collapseble_btn_field.dart';
import 'package:words_app/providers/collections_provider.dart';

import 'btns.dart';

class DialogAddCollection extends StatefulWidget {
  const DialogAddCollection({
    Key key,
  }) : super(key: key);

  @override
  _DialogAddCollectionState createState() => _DialogAddCollectionState();
}

class _DialogAddCollectionState extends State<DialogAddCollection> {
  String holderCollectionTitle;
  String holderLanguageTitle;
  bool is2ndLanguage = false;
  bool is3ndLanguage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 310,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // Done btn
                Btns(
                  padding: 5.0,
                  backgroundColor: Colors.grey[100],
                  icon: Icons.done,
                  color: Colors.green[400],
                  onPress: () {
                    Provider.of<Collections>(context, listen: false)
                        .addNewCollection(
                            holderCollectionTitle, holderLanguageTitle);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5.0),
                // Close btn
                Btns(
                    padding: 5.0,
                    backgroundColor: Colors.grey[100],
                    icon: Icons.close,
                    color: Colors.red[400],
                    onPress: () {
                      Navigator.pop(context);
                    })
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  labelText: 'Collection name',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  isDense: true),
              onChanged: (value) => holderCollectionTitle = value,
            ),
            SizedBox(height: 15),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelStyle: TextStyle(),
                  labelText: 'Language',
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  isDense: true),
              onChanged: (value) => holderLanguageTitle = value,
            ),
            SizedBox(height: 20),
            CollapsebleBtnField(
              selected: is2ndLanguage,
              title: '2nd language',
              onPress: () {
                is2ndLanguage = !is2ndLanguage;
                setState(() {});
              },
            ),
            SizedBox(height: 10),
            CollapsebleBtnField(
              selected: is3ndLanguage,
              title: '3rd language',
              onPress: () {
                is3ndLanguage = !is3ndLanguage;
                setState(() {});
              },
            ),
          ],
        ));
  }
}
