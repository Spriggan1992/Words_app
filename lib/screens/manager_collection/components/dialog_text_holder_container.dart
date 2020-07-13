import 'package:flutter/material.dart';

class DialogTextHolderContainer extends StatelessWidget {
  DialogTextHolderContainer({
    this.textTitleName,
    this.fontSize,
    this.isCheckedTitleName,
    this.height = 45,
    this.onPressedEditButton,
    this.editingSubmit,
    this.validator,
  });
  final String textTitleName;
  final double fontSize;
  final bool isCheckedTitleName;
  final double height;
  final Function onPressedEditButton;
  final Function editingSubmit;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
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
                      autofocus: true,
                      textAlign: TextAlign.start,
                      controller: TextEditingController(text: textTitleName),
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        border: InputBorder.none,
                        // errorText: "blabla",
                      ),
                      onSubmitted: editingSubmit,
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
            IconButton(
              icon: isCheckedTitleName
                  ? Icon(Icons.edit)
                  : Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
              onPressed: onPressedEditButton,
            ),
          ],
        ),
      ),
    );
  }
}
