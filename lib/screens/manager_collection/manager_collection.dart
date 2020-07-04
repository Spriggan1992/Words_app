import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:words_app/constnts/constants.dart';
import 'package:words_app/components/reusable_float_action_button.dart';
import 'package:words_app/models/words_data.dart';
import 'package:words_app/models/provier_data.dart';
import 'package:provider/provider.dart';

class ManagerCollection extends StatefulWidget {
  static String id = 'collection_manager_screen';

  @override
  _ManagerCollectionState createState() => _ManagerCollectionState();
}

class _ManagerCollectionState extends State<ManagerCollection> {
  @override
  Widget build(BuildContext context) {
    bool isCheckedSecondWord = true;

    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColorBlue,
          automaticallyImplyLeading: false,
          title: Text('Collection Name'),
        ),
        floatingActionButton: ReusableFloatActionButton(),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 60.0,
            color: kMainColorBlue,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.grey[800].withOpacity(0.1),
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 200.0,
                  child: ListView(
                    itemExtent: 200,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FlatButton(
                        onPressed: null,
                        // Navigator.pushNamed(context, CollectionManager.id),
                        child: Text('Treining',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                      ),
                      FlatButton(
                        onPressed: null,
                        // Navigator.pushNamed(context, LoginScreen.id),
                        child: Text('Loging',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                      ),
                      FlatButton(
                        onPressed: null,
                        // Navigator.pushNamed(context, RegistrationScreen.id),
                        child: Text('Registration',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Container(
          padding: EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: providerData.wordsData.length,
            itemBuilder: (context, index) {
              final item = providerData.wordsData[index].mainWordTitle;
              final secondWordId =
                  providerData.wordsData[index].secondWordTitle;

              // final item = temporaryData[index];
              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Color(0xFFF8b6b6),
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete),
                  ),
                ),
                key: Key(item),
                direction: DismissDirection.endToStart,
                child: WordCard(
                  //Main word

                  titleMainWords: providerData.wordsData[index].mainWordTitle,
                  isCheckedTitleMainWords:
                      providerData.wordsData[index].checkMainWordTitle,
                  submitMainWord: (value) {
                    providerData.handleSubmitTextWords(
                        value, providerData.wordsData[index]);
                  },
                  toggleMainWord: () {
                    providerData
                        .editWordMainText(providerData.wordsData[index]);
                  },

                  //Second word
                  isCheckedSecondWord: isCheckedSecondWord,
                  secondWordTitle:
                      providerData.wordsData[index].secondWordTitle,
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

class WordCard extends StatefulWidget {
  const WordCard({
    this.isCheckedSecondWord,
    this.toggleMainWord,
    this.titleMainWords,
    this.submitMainWord,
    this.isCheckedTitleMainWords,
    this.secondWordTitle,
  });

  final bool isCheckedSecondWord;
  final String titleMainWords;
  final bool isCheckedTitleMainWords;
  final Function submitMainWord;
  final Function toggleMainWord;
  //secondWordTitle
  final String secondWordTitle;
  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  var myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController = TextEditingController(text: widget.titleMainWords);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF878686),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: Offset(1, 0.5))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: widget.toggleMainWord,
                          child: !widget.isCheckedTitleMainWords
                              ? SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: TextField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    // enableSuggestions: true,
                                    onSubmitted: widget.submitMainWord,
                                    controller: TextEditingController(
                                        text: widget.titleMainWords),
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Color(0xFFF8b6b6),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 30,
                                  width: 100,
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      widget.titleMainWords,
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        color: Color(0xFFF8b6b6),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        widget.isCheckedSecondWord
                            ? Container(child: Text(widget.secondWordTitle))
                            : Container(),
                        Container(
                          child: FittedBox(
                              alignment: Alignment.center,
                              child: Text('50%',
                                  style: TextStyle(
                                      fontSize: 3.0,
                                      color: Colors.red.withOpacity(0.5)))),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.5, 0.5],
                                colors: [Colors.green, Color(0xFFf0f3f8)],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text('Translation',
                            style: TextStyle(
                                fontSize: 15.0, color: Color(0xFFc9c97e))),
                      ),
                      Checkbox(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: false,
                        onChanged: null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

// class CollectionManager extends StatelessWidget {
//   static String id = 'collection_manager_screen';
//   @override
//   Widget build(BuildContext context) {
//     List<String> temporaryData = [
//       'First',
//       'second',
//       'Third',
//       '212',
//       '231321',
//       'dsadsa',
//       '22222',
//       'dsadsa',
//       'fdsfds'
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: kMainColorBlue,
//         automaticallyImplyLeading: false,
//         title: Text('Collection Name'),
//       ),
//       floatingActionButton: ReusableFloatActionButton(),
//       bottomNavigationBar: BottomAppBar(
//         child: Container(
//           height: 60.0,
//           color: kMainColorBlue,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 color: Colors.grey[800].withOpacity(0.1),
//                 alignment: Alignment.center,
//                 height: 50.0,
//                 width: 200.0,
//                 child: ListView(
//                   itemExtent: 200,
//                   scrollDirection: Axis.horizontal,
//                   children: <Widget>[
//                     FlatButton(
//                       onPressed: null,
//                       // Navigator.pushNamed(context, CollectionManager.id),
//                       child: Text('Treining',
//                           style:
//                               TextStyle(fontSize: 30.0, color: Colors.white)),
//                     ),
//                     FlatButton(
//                       onPressed: null,
//                       // Navigator.pushNamed(context, LoginScreen.id),
//                       child: Text('Loging',
//                           style:
//                               TextStyle(fontSize: 30.0, color: Colors.white)),
//                     ),
//                     FlatButton(
//                       onPressed: null,
//                       // Navigator.pushNamed(context, RegistrationScreen.id),
//                       child: Text('Registration',
//                           style:
//                               TextStyle(fontSize: 30.0, color: Colors.white)),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       body: Container(
//         padding: EdgeInsets.only(top: 30.0),
//         child: ListView.builder(
//           itemCount: temporaryData.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   // border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//                 child: ListTile(
//                   // isThreeLine: true,
//                   leading: Text('Second Word'),
//                   subtitle: Text('Somthingd dsadsadsadas fdsffffffffff'),
//                   // title: Text('dsadsa'),

//                   title: Text(
//                     (temporaryData[index]),
//                   ),
//                   trailing: Checkbox(
//                     value: false,
//                     onChanged: null,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
