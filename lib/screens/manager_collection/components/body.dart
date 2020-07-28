import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/words_provider.dart';
import 'package:words_app/screens/manager_collection/components/word_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //fetch data from db

    return Container(
      padding: EdgeInsets.only(top: 5.0, bottom: 0.0),
      // Here we render only listView
      child: Consumer<Words>(
        builder: (context, words, child) {
          return ListView.builder(
            // itemExtent: 100,
            itemCount: words.wordsData.length,
            // semanticChildCount: 1,
            itemBuilder: (context, index) {
              final item = words.wordsData[index].word1;
              return buildDismissible(item, index, context);
            },
          );
        },
      ),
    );
  }

  Dismissible buildDismissible(String item, int index, BuildContext context) {
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
        index: index,
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:words_app/providers/words_provider.dart';
// import 'package:words_app/screens/manager_collection/components/word_card.dart';

// class Body extends StatelessWidget {
//   const Body({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.only(top: 0, bottom: 60.0),
//         // Here we render only listView
//         child: Consumer<Words>(builder: (context, words, child) {
//           return ListView.builder(
//             itemExtent: 60.0,
//             itemCount: words.wordsData.length,
//             itemBuilder: (context, index) {
//               final item = words.wordsData[index].word1;
//               return buildDismissible(item, index, context);
//             },
//           );
//         }));
//   }

//   Dismissible buildDismissible(String item, int index, BuildContext context) {
//     return Dismissible(
//       background: Container(
//         alignment: Alignment.centerRight,
//         color: Color(0xFFF8b6b6),
//         child: Padding(
//           padding: EdgeInsets.only(right: 20),
//           child: Icon(Icons.delete),
//         ),
//       ),
//       key: Key(item),
//       direction: DismissDirection.endToStart,
//       child: WordCard(
//         index: index,
//       ),
//     );
//   }
// }
