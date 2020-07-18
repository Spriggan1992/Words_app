import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/models/provider_data.dart';
import 'dialog_text_holder_container.dart';
// import 'package:validators/validators.dart';

class DialogWindow extends StatefulWidget {
  const DialogWindow({
    this.index,
  });
  final int index;

  @override
  _DialogWindowState createState() => _DialogWindowState();
}

class _DialogWindowState extends State<DialogWindow> {
  bool check = false;
  FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String word1Value;
  String textValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      var wordsData = providerData.wordsData[widget.index];
      return Container(
        height: 400.0,
        width: 380.0,
        child: Builder(
          builder: (context) => Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(wordsData.image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                // Word1
                DialogTextHolderContainer(
                  // validator: (String value) {
                  //   if (value.isEmpty) {
                  //     return 'Required field';
                  //   } else
                  //     return null;
                  // },
                  focus: focusNode,
                  textTitleName: wordsData.word1,
                  fontSize: 20,
                  isCheckedTitleName: wordsData.isEditingWord1,
                  onPressedEditButton: () {
                    setState(() {
                      providerData.toggleWord1(
                        wordsData,
                      );
                      providerData.ignorePointer();

                      // formState.save();
                    });
                  },
                  editingSubmit: (value) {
                    setState(() async {
                      word1Value = await value;
                      // if (word1Value == '') {
                      //   focusNode.requestFocus();
                      // }
                      providerData.changeWord1(word1Value);
                      providerData.handleSubmitWord1(word1Value, wordsData);
                      // if (!focusNode.hasFocus) {}
                    });
                  },
                ),

                // RaisedButton(
                //     child: Text('Add'),
                //     onPressed: () {
                //       setState(() {
                //         final form = _formKey.currentState;
                //         if (form.validate()) {
                //           // form.save();
                //           providerData.handleSubmitWord1(word1Value, wordsData);
                //         }
                //       });
                //     }),

                SizedBox(height: 10),

                // Word2
                DialogTextHolderContainer(
                  textTitleName: wordsData.word2,
                  fontSize: 20,
                  isCheckedTitleName: wordsData.isEditingWord2,
                  onPressedEditButton: () {
                    setState(() {
                      providerData.toggleWord2(
                        wordsData,
                      );
                      providerData.ignorePointer();
                    });
                  },
                  editingSubmit: (value) {
                    setState(() {
                      providerData.handleSubmitWord2(value, wordsData);
                    });
                  },
                ),
                SizedBox(height: 10.0),

                // Translation word
                DialogTextHolderContainer(
                  textTitleName: wordsData.translation,
                  fontSize: 18.0,
                  isCheckedTitleName: wordsData.isEditingTranslationTitle,
                  onPressedEditButton: () {
                    setState(() {
                      providerData.toggleTranslation(wordsData);
                    });
                    providerData.ignorePointer();
                  },
                  editingSubmit: (value) {
                    setState(() {
                      providerData.handleSubmitTranslation(value, wordsData);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/models/provider_data.dart';
// import 'dialog_text_holder_container.dart';
// // import 'package:validators/validators.dart';

// class DialogWindow extends StatefulWidget {
//   const DialogWindow({
//     this.index,
//   });
//   final int index;

//   @override
//   _DialogWindowState createState() => _DialogWindowState();
// }

// class _DialogWindowState extends State<DialogWindow> {
//   bool check = false;
//   FocusNode focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//   String word1Value;
//   String textValue;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProviderData>(builder: (context, providerData, child) {
//       var wordsData = providerData.wordsData[widget.index];
//       return Container(
//         height: 400.0,
//         width: 380.0,
//         child: Builder(
//           builder: (context) => Form(
//             key: formKey,
//             child: Column(
//               children: <Widget>[
//                 Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: Container(
//                       height: 150,
//                       width: 150,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(wordsData.image),
//                             fit: BoxFit.cover),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Word1
//                 DialogTextHolderContainer(
//                   // validator: (String value) {
//                   //   if (value.isEmpty) {
//                   //     return 'Required field';
//                   //   } else
//                   //     return null;
//                   // },
//                   focus: focusNode,
//                   textTitleName: wordsData.word1,
//                   fontSize: 20,
//                   isCheckedTitleName: wordsData.isEditingWord1,
//                   onPressedEditButton: () {
//                     setState(() {
//                       providerData.toggleWord1(
//                         wordsData,
//                       );

//                       // formState.save();
//                     });
//                   },
//                   editingSubmit: (value) {
//                     setState(() async {
//                       word1Value = await value;
//                       // if (word1Value == '') {
//                       //   focusNode.requestFocus();
//                       // }
//                       providerData.changeWord1(word1Value);
//                       providerData.handleSubmitWord1(word1Value, wordsData);
//                       // if (!focusNode.hasFocus) {}
//                     });
//                   },
//                 ),

//                 // RaisedButton(
//                 //     child: Text('Add'),
//                 //     onPressed: () {
//                 //       setState(() {
//                 //         final form = _formKey.currentState;
//                 //         if (form.validate()) {
//                 //           // form.save();
//                 //           providerData.handleSubmitWord1(word1Value, wordsData);
//                 //         }
//                 //       });
//                 //     }),

//                 SizedBox(height: 10),

//                 // Word2
//                 DialogTextHolderContainer(
//                   textTitleName: wordsData.word2,
//                   fontSize: 20,
//                   isCheckedTitleName: wordsData.isEditingWord2,
//                   onPressedEditButton: () {
//                     setState(() {
//                       providerData.toggleWord2(
//                         wordsData,
//                       );
//                     });
//                   },
//                   editingSubmit: (value) {
//                     setState(() {
//                       providerData.handleSubmitWord2(value, wordsData);
//                     });
//                   },
//                 ),
//                 SizedBox(height: 10.0),

//                 // Translation word
//                 DialogTextHolderContainer(
//                   textTitleName: wordsData.translation,
//                   fontSize: 18.0,
//                   isCheckedTitleName: wordsData.isEditingTranslationTitle,
//                   onPressedEditButton: () {
//                     setState(() {
//                       providerData.toggleTranslation(wordsData);
//                     });
//                   },
//                   editingSubmit: (value) {
//                     setState(() {
//                       providerData.handleSubmitTranslation(value, wordsData);
//                     });
//                   },
//                 ),
//                 RaisedButton(onPressed: null
//                     // setState(() {

//                     //   (!providerData.isValid) ? null : providerData.submitData;
//                     // });
//                     // },
//                     )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
