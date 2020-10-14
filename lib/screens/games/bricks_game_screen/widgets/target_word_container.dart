import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/repositories/repositories.dart';
import 'widgets.dart';

class TargetWordContainer extends StatefulWidget {
  TargetWordContainer({Key key}) : super(key: key);

  @override
  TargetWordContainerState createState() => TargetWordContainerState();
}

class TargetWordContainerState extends State<TargetWordContainer> {
  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context);
    return Container(
      height: defaultSize * 17,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: defaultSize * 20),
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 2,
              spacing: 2,
              direction: Axis.horizontal,
              children: providerData.listBricks.map((item) {
                return Visibility(
                    child: GestureDetector(
                  onTap: () {
                    providerData.addLetter(item.targetLangWord);
                    providerData.toggleVisible(item);
                  },
                  child: item.isVisible
                      ? BrickContainer(letter: item.targetLangWord)
                      : Container(width: 40, height: 40),
                ));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
