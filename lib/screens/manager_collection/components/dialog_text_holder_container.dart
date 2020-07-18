import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/models/provider_data.dart';
// import 'package:words_app/models/validation.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';

class DialogTextHolderContainer extends StatelessWidget {
  DialogTextHolderContainer({
    key,
    this.textTitleName,
    this.fontSize,
    this.isCheckedTitleName,
    this.height = 45,
    this.onPressedEditButton,
    this.editingSubmit,
    this.validator,
    this.focus,
  }) : super(key: key);

  final String textTitleName;
  final double fontSize;
  final bool isCheckedTitleName;
  final double height;
  final Function onPressedEditButton;
  final Function editingSubmit;
  final Function validator;
  final FocusNode focus;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return Container(
        // key: UniqueKey(),
        height: height,
        decoration: BoxDecoration(
          border: isCheckedTitleName
              ? null
              : Border.all(
                  color: Colors.green,
                ),
          borderRadius: BorderRadius.circular(10),
          color: isCheckedTitleName ? Colors.grey[200] : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                // Editing title name. Show text field, or just a title name
                child: !isCheckedTitleName
                    ? TextField(
                        focusNode: focus,
                        autofocus: true,
                        textAlign: TextAlign.start,
                        controller: TextEditingController(text: textTitleName),
                        style: TextStyle(fontSize: fontSize),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          border: InputBorder.none,
                          errorText: providerData.word1.error,
                        ),
                        onChanged: editingSubmit,
                      )
                    : SizedBox(
                        width: 200,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            textTitleName,
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ),
              ),
              isCheckedTitleName
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      onPressed:
                          providerData.ignore ? null : onPressedEditButton)
                  : IconButton(
                      icon: Icon(Icons.done, color: Colors.green),
                      onPressed:
                          providerData.ignore ? onPressedEditButton : null),
              // () {

              // setState(() async {
              //   check = !check;
              //   providerData.toggleWord1(wordsData);
              //   providerData.toggleTranslation(wordsData);
              //   providerData.toggleWord2(wordsData);
              // });
              // },
            ],
          ),
        ),
      );
    });
  }
}
