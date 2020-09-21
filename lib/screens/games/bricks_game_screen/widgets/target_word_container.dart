import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/repositories/bricks_provider.dart';
import 'package:words_app/utils/size_config.dart';

class TargetWordContainer extends StatefulWidget {
  TargetWordContainer({Key key}) : super(key: key);

  @override
  TargetWordContainerState createState() => TargetWordContainerState();
}

class TargetWordContainerState extends State<TargetWordContainer> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context);
    return Container(
      height: defaultSize * 15,
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
                    //
                    providerData.toggleVisible(item);
                  },
                  child: item.isVisible
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [kBoxShadow],
                              color: Colors.white),
                          alignment: Alignment.center,
                          width: 41,
                          // width: shuffledWordArray.listMatches.length < 27 ? 41 : 34.1,
                          height: 42,
                          child: Text(
                            item.targetLangWord,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
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
