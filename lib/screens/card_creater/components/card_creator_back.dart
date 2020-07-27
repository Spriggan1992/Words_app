import 'package:flutter/material.dart';

class CardCreatorBack extends StatefulWidget {
  final Function turnFront;

  const CardCreatorBack(this.turnFront);
  @override
  _CardCreatorBackState createState() => _CardCreatorBackState();
}

class _CardCreatorBackState extends State<CardCreatorBack> {
  bool _secondLangSelect = false;
  bool _thirdLangSelect = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  WordCard(
                    size: size,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 36),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'main word in your language',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black),
                              ),
                            ),
                          ),
                          FoldingBtnField(
                            selected: _secondLangSelect,
                            title: 'Enter a language',
                            onPress: () {
                              setState(
                                () {
                                  _secondLangSelect = !_secondLangSelect;
                                },
                              );
                            },
                          ),
                          FoldingBtnField(
                            selected: _thirdLangSelect,
                            title: 'Enter a language',
                            onPress: () {
                              setState(
                                () {
                                  _thirdLangSelect = !_thirdLangSelect;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: IconButton(
                        icon: Icon(
                          Icons.repeat,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: widget.turnFront,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black87),
                maxLines: 5,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'add comments to example',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  const WordCard({
    Key key,
    @required this.size,
    this.child,
  }) : super(key: key);

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.6,
      decoration: BoxDecoration(
        color: Color(0xFF720d5d).withOpacity(0.40),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: child,
    );
  }
}

class FoldingBtnField extends StatelessWidget {
  const FoldingBtnField({
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
                color: Theme.of(context).primaryColor,
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
