import 'package:flutter/material.dart';
import 'package:words_app/components/reusable_main_button.dart';
import 'package:words_app/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/words_provider.dart';

class CardCreater extends StatelessWidget {
  static String id = 'card_creator';

  @override
  Widget build(BuildContext context) {
    // final addData = Provider.of<ProviderData>(context);
    String mainWord;
    String secondWord;
    String translation;
    int id = 3;
    String image = 'images/Spring.jpeg';

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
                color: kMainColorBlue,
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
                        )),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: 300,
                                height: 200,
                                color: Colors.grey[300],
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    icon: Icon(Icons.add), onPressed: null),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Fields(
                                  title: 'First Word',
                                  handleText: (value) => mainWord = value),
                              Fields(
                                  title: 'Second Word',
                                  handleText: (value) => secondWord = value),
                              Fields(
                                  title: 'Translation',
                                  handleText: (value) => translation = value),
                              Fields(title: 'Example'),
                            ],
                          ),
                        ),
                        // SizedBox(height: 80.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: ReusableMainButton(
                            titleText: 'Add',
                            onPressed: () {
                              providerData.addNewWordCard(
                                  mainWord, secondWord, translation, id, image);
                              print(mainWord);
                              print(secondWord);
                              print(translation);
                              print(id);
                              print(image);
                              Navigator.pop(context);
                            },
                            titleColor: kMainColorBlue,
                            backgroundColor: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({this.title, this.handleText});

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
            child: Container(
              width: 30,
              child: Text(title),
            ),
          ),
          Container(
            width: 220,
            child: TextField(
              onChanged: handleText,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(top: 5, right: 10)),
            ),
          ),
        ],
      ),
    );
  }
}
