import 'package:flutter/material.dart';

class CollectionManager extends StatelessWidget {
  static String id = 'collection_manager_screen';
  @override
  Widget build(BuildContext context) {
    List<String> temporaryData = ['First', 'second', 'Third'];
    return Scaffold(body: Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
            (temporaryData[index]),
          ));
        },
      ),
    ));
  }
}
