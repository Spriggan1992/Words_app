import 'package:flutter/material.dart';

class CollapsableFieldBtn extends StatelessWidget {
  const CollapsableFieldBtn({
    Key key,
    @required this.selected,
    this.title,
    this.onPress,
  }) : super(key: key);

  final bool selected;

  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      overflow: Overflow.clip,
      children: <Widget>[
        AnimatedContainer(
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.only(left: 10),
          height: 40,
          width: selected ? 300 : 110,
          duration: Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: Container(
            child: TextField(
              enabled: selected ? true : false,
              textAlign: selected ? TextAlign.center : TextAlign.end,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder:
                      selected ? OutlineInputBorder() : InputBorder.none,
                  border: InputBorder.none,
                  hintText: title,
                  isDense: true,
                  hintStyle: TextStyle(fontSize: 10)),
            ),
          ),
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF34c7b3)),
                color: Color(0xFF34c7b3),
                borderRadius: BorderRadius.circular(40)),
            child: IconButton(
                padding: EdgeInsets.all(7),
                constraints: BoxConstraints(minHeight: 20, minWidth: 20),
                icon: Icon(
                  Icons.add,
                  size: 22,
                  color: Colors.white,
                ),
                onPressed: onPress),
          ),
        ),
      ],
    );
  }
}
