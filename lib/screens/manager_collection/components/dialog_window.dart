import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/models/provider_data.dart';
import 'dialog_text_holder_container.dart';
// import 'package:validators/validators.dart';

class DialogWindow extends StatelessWidget {
  const DialogWindow({
    this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      var wordsData = providerData.wordsData[index];
      return WillPopScope(
        onWillPop: () async =>
            !providerData.isDisableEnableEditingButtons, // Prevent any actions
        child: Container(
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
                          image: AssetImage(wordsData.image),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              // Word1
              DialogTextHolderContainer(
                textTitleName: wordsData.word1,
                fontSize: 20,
                isCheckedTitleName: wordsData.isEditingWord1,
                onPressedEditButton: () {
                  providerData.toggleWord1(wordsData);
                  providerData.toggleEditingDoneButton();
                },
                editingSubmit: (value) {
                  providerData.textValidation(value);
                  providerData.handleSubmitWord1(value, wordsData);
                },
              ),

              SizedBox(height: 10),

              // Word2
              DialogTextHolderContainer(
                textTitleName: wordsData.word2,
                fontSize: 20,
                isCheckedTitleName: wordsData.isEditingWord2,
                onPressedEditButton: () {
                  providerData.toggleWord2(wordsData);
                  providerData.toggleEditingDoneButton();
                },
                editingSubmit: (value) {
                  providerData.handleSubmitWord2(value, wordsData);
                },
              ),
              SizedBox(height: 10.0),

              // Translation word
              DialogTextHolderContainer(
                textTitleName: wordsData.translation,
                fontSize: 18.0,
                isCheckedTitleName: wordsData.isEditingTranslationTitle,
                onPressedEditButton: () {
                  providerData.toggleTranslation(wordsData);
                  providerData.toggleEditingDoneButton();
                },
                editingSubmit: (value) {
                  providerData.textValidation(value);
                  providerData.handleSubmitTranslation(value, wordsData);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
