import 'package:flutter/material.dart';
import 'package:words_app/constnts/constants.dart';

class BoxCollection extends StatefulWidget {
  BoxCollection({
    this.textTitle,
    this.deleteColection,
    this.onTap,
    this.isChecked,
    this.onSubmite,
    this.onChanged,
  });

  final String textTitle;
  final Function deleteColection;
  final Function onTap;
  final bool isChecked;
  final Function onSubmite;
  final Function onChanged;

  @override
  _BoxCollectionState createState() => _BoxCollectionState();
}

class _BoxCollectionState extends State<BoxCollection> {
  TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.deleteColection,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // padding: EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF878686),
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(1, 0.5))
            ],
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: widget.isChecked
                    ? FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.textTitle,
                            style: TextStyle(
                                fontSize: 25.0, color: kMainColorBlue),
                          ),
                        ),
                      )
                    : TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 0, left: 20.0, bottom: 8.0, right: 20.0)),
                        cursorColor: kMainColorBlue,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kMainColorBlue,
                          fontSize: 25.0,
                        ),
                        autofocus: true,
                        onSubmitted: widget.onSubmite,
                        controller: TextEditingController(
                          text: widget.textTitle,
                        ),
                      ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 30.0, right: 10.0, bottom: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Learned: 3'),
                    SizedBox(height: 20),
                    Text('In Progress: 4'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, right: 5),
                    child: Text('En'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
