import 'package:flutter/material.dart';
import 'package:words_app/components/box_collection.dart';
import 'package:words_app/constants.dart';

class ListCollection extends StatelessWidget {
  static String id = 'ListCollection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: kBoxCollectionBackground,
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            children: <Widget>[
              BoxCollection(),
              BoxCollection(),
              BoxCollection(),
              Center(
                child: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Color(0xFF6beded),
                  child: Icon(Icons.add, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//  @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         decoration: kBoxCollectionBackground,
//         padding: EdgeInsets.all(20.0),
//         child: CustomScrollView(
//           slivers: <Widget>[
//             SliverGrid(
//               delegate: SliverChildBuilderDelegate((context, index) {
//                 return BoxCollection();
//               }, childCount: 1),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: FloatingActionButton(onPressed: null),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
