import 'package:flutter/material.dart';

const Color mintColor = Color(0xff03dac6);

class CustomRadio extends StatefulWidget {
  static const id = 'custom_radio';
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> radioButtonList = new List<RadioModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    radioButtonList.add(new RadioModel(false, 'n'));
    radioButtonList.add(new RadioModel(false, 'pron'));
    radioButtonList.add(new RadioModel(false, 'adj'));
    radioButtonList.add(new RadioModel(false, 'v'));
    radioButtonList.add(new RadioModel(false, 'adv'));
    radioButtonList.add(new RadioModel(false, 'prep'));
    radioButtonList.add(new RadioModel(false, 'conj'));
    radioButtonList.add(new RadioModel(false, 'inter'));
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
              child: new Text(
                _item.buttonText,
                style: new TextStyle(
                  color: _item.isSelected ? Colors.white : Colors.black,
                  //fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              border: new Border.all(
                width: 1.0,
                color: _item.isSelected
                    ? Colors.black
                    : Theme.of(context).primaryColor,
              ),
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

  RadioModel(this.isSelected, this.buttonText);
}
