import 'package:flutter/material.dart';
import 'dialog_text_holder_container.dart';

class DialogWindow extends StatelessWidget {
  const DialogWindow({
    this.mainWordTitle,
    this.secondWordTitle,
    this.translationTitle,
    this.wordPicture,
    this.isCheckedTitleMainWords,
    this.isCheckedSecondWord,
    this.isCheckedTranslation,
    this.isCheckExampleTitle,
    this.toggleMainWord,
    this.submitMainWord,
    this.submitSecondWord,
    this.toggleSecondWord,
    this.toggleTranslation,
    this.submitTranslation,
  });
  // MainWord
  final String mainWordTitle;
  final bool isCheckedTitleMainWords;
  final Function toggleMainWord;
  final Function submitMainWord;

  // SecondWord
  final String secondWordTitle;
  final bool isCheckedSecondWord;
  final Function submitSecondWord;
  final Function toggleSecondWord;
  // Translation
  final String translationTitle;
  final bool isCheckedTranslation;
  final Function toggleTranslation;
  final Function submitTranslation;
  // Example field
  final bool isCheckExampleTitle;
  // Picture
  final String wordPicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
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
            textTitleName: mainWordTitle,
            fontSize: 20,
            isCheckedTitlNameWords: isCheckedTitleMainWords,
            onPressedEditWordButton: toggleMainWord,
            editingSubmit: submitMainWord,
          ),
          SizedBox(height: 10.0),

          // Second Word
          DialogTextHolderContainer(
            textTitleName: secondWordTitle,
            fontSize: 20,
            isCheckedTitlNameWords: isCheckedSecondWord,
            onPressedEditWordButton: toggleSecondWord,
            editingSubmit: submitSecondWord,
          ),
          SizedBox(height: 10.0),

          // Translation word
          DialogTextHolderContainer(
            textTitleName: translationTitle,
            fontSize: 18.0,
            isCheckedTitlNameWords: isCheckedTranslation,
            onPressedEditWordButton: toggleTranslation,
            editingSubmit: submitTranslation,
          ),
          SizedBox(height: 15.0),

          //Example Container
          Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text('Example: ', style: TextStyle(fontSize: 7)),
                  ),
                  DialogTextHolderContainer(
                    textTitleName: 'It was an amazing summer',
                    isCheckedTitlNameWords: isCheckExampleTitle,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
