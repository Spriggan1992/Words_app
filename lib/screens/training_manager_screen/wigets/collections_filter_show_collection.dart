import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';

class CollectionsFuilterShowColldection extends StatelessWidget {
  const CollectionsFuilterShowColldection({
    Key key,
    @required this.state,
  }) : super(key: key);

  final TrainingManagerState state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Expanded(
        child: Container(
      decoration: innerShadow,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: SingleChildScrollView(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            clipBehavior: Clip.hardEdge,
            child: state.selectedCollections.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'You have to choose Collection',
                    ),
                  )
                : Wrap(
                    spacing: defaultSize * 0.3,
                    alignment: WrapAlignment.center,
                    children: state.selectedCollections.map((item) {
                      return Chip(
                        label: Text(item.title, style: TextStyle(fontSize: 10)),
                      );
                    }).toList(),
                  ),
          )),
    ));
  }
}
