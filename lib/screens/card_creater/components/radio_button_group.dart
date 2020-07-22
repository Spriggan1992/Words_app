import 'package:flutter/material.dart';

enum PartOfSpeech { verb, noun, adjective, adverb, pronoun }

class RadioButtonGroup extends StatefulWidget {
  RadioButtonGroup({Key key}) : super(key: key);

  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  PartOfSpeech _part = PartOfSpeech.verb;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('v'),
                Radio(
                  value: PartOfSpeech.verb,
                  groupValue: _part,
                  onChanged: (PartOfSpeech value) {
                    setState(
                      () {
                        _part = value;
                      },
                    );
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('n'),
                Radio(
                  value: PartOfSpeech.noun,
                  groupValue: _part,
                  onChanged: (PartOfSpeech value) {
                    setState(
                      () {
                        _part = value;
                      },
                    );
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('adj'),
                Radio(
                  value: PartOfSpeech.adjective,
                  groupValue: _part,
                  onChanged: (PartOfSpeech value) {
                    setState(
                      () {
                        _part = value;
                      },
                    );
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('adv'),
                Radio(
                  value: PartOfSpeech.adverb,
                  groupValue: _part,
                  onChanged: (PartOfSpeech value) {
                    setState(
                      () {
                        _part = value;
                      },
                    );
                  },
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('pron'),
                Radio(
                  value: PartOfSpeech.pronoun,
                  groupValue: _part,
                  onChanged: (PartOfSpeech value) {
                    setState(
                      () {
                        _part = value;
                      },
                    );
                  },
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
