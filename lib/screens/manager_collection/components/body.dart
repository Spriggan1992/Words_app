import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/models/provider_data.dart';
import 'package:words_app/screens/manager_collection/components/word_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, providerData, child) {
      return Container(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemCount: providerData.wordsData.length,
          itemBuilder: (context, index) {
            final item = providerData.wordsData[index].word1;
            return buildDismissible(item, providerData, index, context);
          },
        ),
      );
    });
  }

  Dismissible buildDismissible(
      String item, ProviderData providerData, int index, BuildContext context) {
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
