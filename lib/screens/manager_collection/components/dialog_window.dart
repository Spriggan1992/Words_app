import 'package:flutter/material.dart';
import 'dialog_text_holder_container.dart';

class DialogWindow extends StatelessWidget {
  const DialogWindow({
    this.word1Title,
    this.word2Title,
    this.translationTitle,
    this.wordPicture,
    this.isCheckedWord1,
    this.isCheckedWord2,
    this.isCheckedTranslation,
    this.isCheckExampleTitle,
    this.toggleWord1,
    this.submitWord1,
    this.submitSecondWord,
    this.toggleword2,
    this.toggleTranslation,
    this.submitTranslation,
    this.validator,
    this.onSave,
  });
  // Word1
  final String word1Title;
  final bool isCheckedWord1;
  final Function toggleWord1;
  final Function submitWord1;

  // Word2
  final String word2Title;
  final bool isCheckedWord2;
  final Function submitSecondWord;
  final Function toggleword2;
  // Translation
  final String translationTitle;
  final bool isCheckedTranslation;
  final Function toggleTranslation;
  final Function submitTranslation;
  // Example field
  final bool isCheckExampleTitle;
  // Picture
  final String wordPicture;

  final Function validator;
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    // final formState = Form.of(context);
    return Container(
      height: 400.0,
      width: 380.0,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(wordPicture), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Main word
          DialogTextHolderContainer(
            validator: validator,
            textTitleName: word1Title,
            fontSize: 20,
            isCheckedTitleName: isCheckedWord1,
            onPressedEditButton: toggleWord1,
            editingSubmit: submitWord1,
          ),
          SizedBox(height: 10.0),

          // Second Word
          DialogTextHolderContainer(
            textTitleName: word2Title,
            fontSize: 20,
            isCheckedTitleName: isCheckedWord2,
            onPressedEditButton: toggleword2,
            editingSubmit: submitSecondWord,
          ),
          SizedBox(height: 10.0),

          // Translation word
          DialogTextHolderContainer(
            textTitleName: translationTitle,
            fontSize: 18.0,
            isCheckedTitleName: isCheckedTranslation,
            onPressedEditButton: toggleTranslation,
            editingSubmit: submitTranslation,
          ),
          SizedBox(height: 15.0),

          //Example Container
          // Container(
          //     height: 80,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Colors.grey[200],
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         // Container(
          //         //   padding: EdgeInsets.only(top: 10, left: 10),
          //         //   child: Text('Example: ', style: TextStyle(fontSize: 7)),
          //         // ),
          //         // DialogTextHolderContainer(
          //         //   textTitleName: 'It was an amazing summer',
          //         //   isCheckedTitleName: isCheckExampleTitle,
          //         // )
          // ],
          // ))
        ],
      ),
    );
  }
}
