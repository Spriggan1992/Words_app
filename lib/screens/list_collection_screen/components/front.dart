// Front side of WordsCollection
import 'package:flutter/material.dart';
import 'package:words_app/screens/list_collection_screen/components/my_separator.dart';

import 'words_collection.dart';

class Front extends StatelessWidget {
  const Front({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final WordsCollection widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Container(
        key: ValueKey(1),
        decoration: BoxDecoration(
          // boxShadow: [kBoxShadow],
          borderRadius: BorderRadius.circular(05.0),
          color: Colors.white, // Color Front container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                child: widget
                        .isCheckedTextEditing // Check if isCheckedTextEditing true or false
                    // Text with collectionTitleName
                    ? Expanded(
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1, right: 1, bottom: 1, left: 1),
                            child: Text(
                              widget.collectionTitleName,
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    // TextField Container
                    : Expanded(
                        child: Container(
                          width: 60,
                          child: TextField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 5.0, bottom: 10.0, right: 5.0)),
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            autofocus: true,
                            onSubmitted: widget.onSubmit,
                            controller: TextEditingController(
                              text: widget.collectionTitleName,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MySeparator(
                color: Colors.grey,
                height: 2,
              ),
            ),
            Container(
              child: Text.rich(
                TextSpan(text: 'language: '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Text.rich(
//   TextSpan(
//     text: 'My name is ',
//     style: TextStyle(color: Colors.black),
//     children: <InlineSpan>[
//       WidgetSpan(
//         alignment: PlaceholderAlignment.baseline,
//         baseline: TextBaseline.alphabetic,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxWidth: 100),
//           child: TextField(),
//         )
//       ),
//       TextSpan(
//         text: '.',
//       ),
//     ],
//   ),
// )
//  // Indicator amount of words in collection
//                     Padding(
//                       padding: EdgeInsets.only(left: 5),
//                       child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                               stops: [0.3, 0.7],
//                               colors: [Colors.green, Colors.red[400]],
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           height: 60,
//                           width: 30,
//                           child: Center(
//                               child:
//                                   Text('5', style: TextStyle(fontSize: 17)))),
//                     ),
