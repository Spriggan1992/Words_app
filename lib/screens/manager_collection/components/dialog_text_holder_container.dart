import 'package:flutter/material.dart';

class DialogTextHolderContainer extends StatelessWidget {
  DialogTextHolderContainer({
    this.textTitleName,
    this.fontSize,
    this.isCheckedTitleName,
    this.height = 45,
    this.onPressedEditButton,
    this.editingSubmit,
  });
  final String textTitleName;
  final double fontSize;
  final bool isCheckedTitleName;
  final double height;
  final Function onPressedEditButton;
  final Function editingSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              // Editing title name. Show text field, or just a title name
              child: !isCheckedTitleName
                  ? TextFormField(
                      autofocus: true,
                      textAlign: TextAlign.start,
                      controller: TextEditingController(text: textTitleName),
                      style: TextStyle(fontSize: fontSize),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onFieldSubmitted: editingSubmit,
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
            IconButton(icon: Icon(Icons.edit), onPressed: onPressedEditButton),
          ],
        ),
      ),
    );
  }
}
