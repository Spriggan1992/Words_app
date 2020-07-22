import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/words_provider.dart';
q
enum PartOfSpeech { verb, noun, adjective, adverb, pronoun }
const Color color = Color(0xff03DAC6);

class CardCreater extends StatelessWidget {
  static String id = 'card_creator';

  @override
  Widget build(BuildContext context) {
    // final addData = Provider.of<ProviderData>(context);
    String mainWord;
    String secondWord;
    String translation;
    int id = 3;
    String image = 'images/3.jpeg';
    String dropdownValue = 'One';
    String part = 'n';

    return Consumer<Words>(
      builder: (context, providerData, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
            // backgroundColor: kSecondColorPink,
            // resizeToAvoidBottomInset: false,
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 60.0,
                color: kAppBarsColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 55,
                      padding: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Field(
                              title: 'First Word',
                              handleText: (value) => mainWord = value),
                          Field(
                              title: 'Second Word',
                              handleText: (value) => secondWord = value),
                          Field(
                              title: 'Translation',
                              handleText: (value) => translation = value),
                          Field(title: 'Example'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 36,
                                color: Color(0xff03DAC6),
                              ),
                              onPressed: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    RadioButtonGroup(),
                    // SizedBox(height: 80.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: ReusableMainButton(
                        titleText: 'ADD WORD',
                        onPressed: () {
                          providerData.addNewWordCard(mainWord, secondWord,
                              translation, id, image, part);
//                          print(mainWord);
//                          print(secondWord);
//                          print(translation);
//                          print(id);
//                          print(image);
                          Navigator.pop(context);
                        },
                        textColor: Colors.white,
                        backgroundColor: Color(0xff03DAC6),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}

class Field extends StatelessWidget {
  const Field({this.title, this.handleText});

  final String title;
  final Function handleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: handleText,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  labelText: title,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(top: 5, right: 10)),
            ),
          ),
        ],
      ),
    );
  }
}

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
