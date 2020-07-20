import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/validation_provider.dart';
import 'package:words_app/providers/words_provider.dart';
// import 'package:words_app/models/validation.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';

class DialogTextHolderContainer extends StatefulWidget {
  DialogTextHolderContainer({
    key,
    this.textTitleName,
    this.fontSize,
    this.isCheckedTitleName,
    this.height = 45,
    this.onPressedEditButton,
    this.editingSubmit,
  }) : super(key: key);

  final String textTitleName;
  final double fontSize;
  final bool isCheckedTitleName;
  final double height;
  final Function onPressedEditButton;
  final Function editingSubmit;

  @override
  _DialogTextHolderContainerState createState() =>
      _DialogTextHolderContainerState();
}

class _DialogTextHolderContainerState extends State<DialogTextHolderContainer> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = widget.textTitleName;
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validation = Provider.of<ValidationForm>(context);
    return Consumer<Words>(builder: (context, providerData, child) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          border: widget.isCheckedTitleName
              ? null
              : Border.all(
                  color: validation.isDisableEditingDoneButton
                      ? Colors.green
                      : Colors.red),
          borderRadius: BorderRadius.circular(10),
          color: widget.isCheckedTitleName ? Colors.grey[200] : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                // Editing title name. Show text field, or just a title name
                child: !widget.isCheckedTitleName
                    ? TextField(
                        autofocus: true,
                        textAlign: TextAlign.start,
                        controller: myController,
                        style: TextStyle(fontSize: widget.fontSize),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
                          border: InputBorder.none,
                          errorText: validation.errorMessage.error,
                        ),
                        onChanged: widget.editingSubmit,
                      )
                    : SizedBox(
                        width: 200,
                        child: FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.textTitleName,
                            style: TextStyle(fontSize: widget.fontSize),
                          ),
                        ),
                      ),
              ),
              // Here we pass condition for check {if isCheckedTitleName = true -> show EditingButton }
              //{if isCheckedTitleName = false -> show DoneButton}
              widget.isCheckedTitleName
                  ? IconButton(
                      icon: Icon(Icons.edit),
                      // Here we check {if isDisableEnableEditingButtons = true -> disable button}
                      // {if isDisableEnableEditingButtons = false -> enable button}
                      onPressed: validation.isDisableEnableEditingButtons
                          ? null
                          : widget.onPressedEditButton)
                  : IconButton(
                      icon: Icon(Icons.done,
                          // Here we check {if value of text field isn't empty -> show green border color}
                          // {if value of text field is empty - > show red border color  }
                          color: validation.isDisableEditingDoneButton
                              ? Colors.green
                              : Colors.red),
                      // Here we check {if isDisableEnableEditingButtons = true and TextField value isn't empty -> enable button}
                      // {if isDisableEnableEditingButtons = false and TextField value is empty -> disable button}
                      onPressed: validation.isDisableEnableEditingButtons &&
                              validation.isDisableEditingDoneButton
                          ? widget.onPressedEditButton
                          : null),
            ],
          ),
        ),
      );
    });
  }
}
