import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/repositories/validation_provider.dart';
import 'package:words_app/repositories/words_repository.dart';
import 'dialog_text_holder_container.dart';
// import 'package:validators/validators.dart';

class DialogWindow extends StatelessWidget {
  const DialogWindow({
    this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    // return Consumer<Words>(builder: (context, providerData, child) {
    final wordsDataIndex =
        Provider.of<WordsRepository>(context, listen: false).wordsData[index];
    final wordsData = Provider.of<WordsRepository>(context, listen: false);
    final validation = Provider.of<ValidationForm>(context);
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
                    image: FileImage(wordsDataIndex.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Word1
          DialogTextHolderContainer(
            textTitleName: wordsDataIndex.targetLang,
            fontSize: 20,
            isCheckedTitleName: wordsDataIndex.isEditingTargetLang,
            onPressedEditButton: () {
              wordsData.toggleTargetLang(wordsDataIndex);
              validation.toggleEditingDoneButton();
            },
            onChange: (value) {
              validation.textValidation(value);
              wordsData.targetLangHandleSubmit(value, wordsDataIndex);
            },
          ),

          SizedBox(height: 10),

          // Word2
          DialogTextHolderContainer(
            textTitleName: wordsDataIndex.secondLang,
            fontSize: 20,
            isCheckedTitleName: wordsDataIndex.isEditingSecondLang,
            onPressedEditButton: () {
              wordsData.toggleSecondLang(wordsDataIndex);
              validation.toggleEditingDoneButton();
            },
            onChange: (value) {
              wordsData.secondLangHandleSubmit(value, wordsDataIndex);
            },
          ),
          SizedBox(height: 10.0),

          // Translation word
          DialogTextHolderContainer(
            textTitleName: wordsDataIndex.ownLang,
            fontSize: 20.0,
            isCheckedTitleName: wordsDataIndex.isEditingOwnLang,
            onPressedEditButton: () {
              wordsData.toggleOwnLang(wordsDataIndex);
              validation.toggleEditingDoneButton();
            },
            onChange: (value) {
              validation.textValidation(value);
              wordsData.ownLangHandleSubmit(value, wordsDataIndex);
            },
          ),
        ],
      ),
    );
    // });
  }
}
