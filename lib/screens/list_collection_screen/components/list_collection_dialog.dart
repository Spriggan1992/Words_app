import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/screens/list_collection_screen/components/btns.dart';
import 'package:words_app/components/my_separator.dart';
import 'package:words_app/screens/list_collection_screen/components/text_holder.dart';

class CollectionListDialog extends StatelessWidget {
  const CollectionListDialog({
    this.index,
    this.deleteCollection,
    this.onSubmit,
    this.onSaveForm,
    this.onSubmitLanguageField,
    Key key,
  }) : super(key: key);

  final int index;

  final Function deleteCollection;
  final Function onSubmit;
  final Function onSaveForm;
  final Function onSubmitLanguageField;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Collections>(context, listen: false)
        .wordsCollectionData[index];
    return Container(
        height: 350,
        width: 80,
        child: Column(
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
                    onPress: onSaveForm),

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
            // Title Text Field
            TextField(
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(border: InputBorder.none),
                controller: TextEditingController(text: providerData.title),
                onChanged: onSubmit),
            SizedBox(height: 15),
            MySeparator(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              dWidth: 3.0,
              dCount: 5.0,
              color: Colors.grey,
              height: 3.0,
            ),
            Flexible(child: SizedBox(height: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('language:  ', style: TextStyle(fontSize: 20.0)),
                Container(
                  width: 60,
                  child: TextField(
                      style: TextStyle(fontSize: 25, color: Color(0xFF34c7b3)),
                      controller:
                          TextEditingController(text: providerData.language),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(border: InputBorder.none),
                      onChanged: onSubmitLanguageField),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            // Words Text Holder
            TextHolder(
              titleName: 'words:   ',
              titleNameValue: '   16',
              fontSize1: 20.0,
              fontSize2: 25.0,
            ),
            SizedBox(height: 25.0),
            // Learned Text Holder
            TextHolder(
              titleName: 'learned:   ',
              titleNameValue: '  11',
              fontSize1: 20.0,
              fontSize2: 25.0,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Delete btn
                Flexible(
                  child: Btns(
                    padding: 8.0,
                    backgroundColor: Colors.grey[100],
                    icon: Icons.delete,
                    color: Colors.red[400],
                    onPress: deleteCollection,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
