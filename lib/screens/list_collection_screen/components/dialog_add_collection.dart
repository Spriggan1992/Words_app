import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/components/custom_round_btn.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/collections_provider.dart';

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
  String holderCollectionTitle;
  String holderLanguageTitle;
  bool is2ndLanguage = false;
  bool is3ndLanguage = false;
  double heightCollectionName = 0;
  double heightLanguage = 1.2;

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
    myFocusNodeCollectionName.addListener(() {
      setState(() {
        if (myFocusNodeCollectionName.hasFocus) {
          heightCollectionName = 0;
        } else {
          heightCollectionName = 1.2;
        }
      });
    });
    // Setup height for [heightLanguage]
    myFocusNodeLanguage.addListener(() {
      setState(() {
        if (myFocusNodeLanguage.hasFocus) {
          heightLanguage = 0;
        } else {
          heightLanguage = 1.2;
        }
      });
    });

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
                // Done btn
                // CustomRoundBtn(
                //   icon: Icons.check,
                //   fillColor: Color(0xffDA627D),
                //   onPressed: () {},
                // ),
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
                focusNode: myFocusNodeCollectionName,
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.6),
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                      height: heightCollectionName,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Collection name',
                    isDense: true),
                onChanged: (value) => holderCollectionTitle = value,
              ),
            ),
            SizedBox(height: 30),
            Container(
              decoration: innerShadow,
              child: TextField(
                focusNode: myFocusNodeLanguage,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.6),
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 18,
                      height: heightLanguage,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    labelText: 'Language',
                    isDense: true),
                onChanged: (value) => holderLanguageTitle = value,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
                highlightElevation: 5,
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(0),
                color: Color(0xffDA627D),
                child: Text('CREATE COLLECTION',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Provider.of<Collections>(context, listen: false)
                      .addNewCollection(
                          holderCollectionTitle, holderLanguageTitle);
                  Navigator.pop(context);
                })
          ],
        ));
  }
}
