import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_button.dart';

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
      resizeToAvoidBottomPadding: false,
      body: Container(
          color: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Name Your Collection",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  onChanged: (value) {
                    textTitleCollection = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ReusableButton(
                    titleText: 'Add',
                    color1: Colors.grey,
                    color2: Colors.grey[700],
                    onPress: () {
                      setState(() {
                        widget.addCollectionCallBack(textTitleCollection);
                      });
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
