import 'package:flutter/material.dart';
import 'package:words_app/constants.dart';
import 'package:words_app/components/reusable_main_button.dart';

class CreateBoxCollections extends StatefulWidget {
  CreateBoxCollections(this.addCollectionCallBack);
  final Function addCollectionCallBack;

  @override
  _CreateBoxCollectionsState createState() => _CreateBoxCollectionsState();
}

String textTitleCollection;

class _CreateBoxCollectionsState extends State<CreateBoxCollections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Name Your Collection",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        top: 10.0,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    autofocus: true,
                    onChanged: (value) {
                      textTitleCollection = value;
                    },
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ReusableLogingRegestrationButtons(
                      backgroundColor: kMainColorBlue,
                      titleText: 'Add',
                      titleColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          widget.addCollectionCallBack(textTitleCollection);
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
