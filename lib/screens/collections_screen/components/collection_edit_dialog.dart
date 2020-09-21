import 'package:flutter/material.dart';
import 'package:words_app/bloc/collections/collections_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:words_app/widgets/custom_round_btn.dart';
import 'package:words_app/models/collection.dart';

import 'package:words_app/widgets/my_separator.dart';
import 'package:words_app/screens/collections_screen/components/text_holder.dart';

class CollectionsEditDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String onSubmitTitleField;
    String onSubmitLanguageField;
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
                      controller: TextEditingController(text: collection.title),
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
                  child: SizedBox(height: 5.0),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    style: TextStyle(fontSize: 20, color: Color(0xFF34c7b3)),
                    controller:
                        TextEditingController(text: collection.language),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      onSubmitLanguageField = value;
                    },
                  ),
                ),
                Flexible(child: SizedBox(height: 10.0)),
                // Words Text Holder
                TextHolder(
                  titleName: 'words:   ',
                  titleNameValue: '   16',
                  fontSize1: 20.0,
                  fontSize2: 20.0,
                ),
                Flexible(child: SizedBox(height: 25.0)),
                // Learned Text Holder
                TextHolder(
                  titleName: 'learned:   ',
                  titleNameValue: '  11',
                  fontSize1: 20.0,
                  fontSize2: 25.0,
                ),
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
                              id: collection.id,
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
