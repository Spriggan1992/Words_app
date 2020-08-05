import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final Function getPart;
  final Function getColor;
  static const id = 'custom_radio';

  const CustomRadio({this.getPart, this.getColor});
  @override
  createState() {
    return CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> radioButtonList = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: radioButtonList.length,
      itemBuilder: (BuildContext context, int index) {
        return new InkWell(
          //highlightColor: Colors.red,
//            splashColor: mintColor,
          radius: 30,
          onTap: () {
            setState(
              () {
                radioButtonList
                    .forEach((element) => element.isSelected = false);
                radioButtonList[index].isSelected = true;
                widget.getPart(radioButtonList[index].buttonText);
                widget.getColor(radioButtonList[index].color);
              },
            );
          },
          child: new RadioItem(radioButtonList[index]),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 30,
            width: 30,
            child: new Center(
              child: Text(
                _item.buttonText,
                style: TextStyle(
                    color: _item.isSelected ? Colors.white : Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected
                  ? Theme.of(context).primaryColor
                  : _item.color,
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
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final Color color;

  RadioModel(this.isSelected, this.buttonText, this.color);
}
