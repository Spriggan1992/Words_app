import 'package:flutter/material.dart';
import 'package:words_app/models/models.dart';

class CustomRadio extends StatefulWidget {
  final Function getPart;
  final Function getColor;
  final double defaultSize;
  static const id = 'custom_radio';

  const CustomRadio({this.getPart, this.getColor, this.defaultSize});
  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> radioButtonList = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    radioButtonList.add(new RadioModel(false, '', Color(0xffF3F3F3)));
    radioButtonList.add(new RadioModel(false, 'n', Color(0xffB6D7A8)));
    radioButtonList.add(new RadioModel(false, 'pron', Color(0xffB6D7A8)));
    radioButtonList.add(new RadioModel(false, 'v', Color(0xffEB7676)));
    radioButtonList.add(new RadioModel(false, 'adv', Color(0xffEB7676)));
    radioButtonList.add(new RadioModel(false, 'adj', Color(0xffFFE599)));
    radioButtonList.add(new RadioModel(false, 'conj', Color(0xff9FC5F8)));
    radioButtonList.add(new RadioModel(false, 'prep', Color(0xffB4A7D6)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        radioButtonList.length,
        (index) => InkWell(
          //highlightColor: Colors.red,
//            splashColor: mintColor,
          radius: 30,
          onTap: () {
            setState(
              () {
                radioButtonList
                    .forEach((element) => element.isSelected = false);
                radioButtonList[index].isSelected = true;
                Part part = Part(
                    partName: radioButtonList[index].buttonText,
                    partColor: radioButtonList[index].color);
                widget.getPart(part);
              },
            );
          },
          child: new RadioItem(
            radioButtonList[index],
            defaultSize: widget.defaultSize,
          ),
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final double defaultSize;
  final RadioModel _item;
  RadioItem(this._item, {this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return new Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          height: defaultSize * 3.3,
          width: defaultSize * 3.3,
          child: new Center(
            child: Text(
              _item.buttonText,
              style: TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: defaultSize * 1.2,
                  fontWeight: FontWeight.bold),
            ),
          ),
          decoration: BoxDecoration(
            color:
                _item.isSelected ? Theme.of(context).primaryColor : _item.color,
            boxShadow: [
              BoxShadow(
                color: Color(0xff382F266D),
                offset: Offset(1, 1),
                blurRadius: 4,
              )
            ],
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final Color color;

  RadioModel(this.isSelected, this.buttonText, this.color);
}
