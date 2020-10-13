import 'package:flutter/material.dart';
import 'package:words_app/config/constants.dart';

import 'package:words_app/config/size_config.dart';

class BackContainer extends StatelessWidget {
  const BackContainer({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: SizeConfig.defaultSize * 2,
        left: SizeConfig.defaultSize * 2,
        top: SizeConfig.defaultSize * 2,
      ),
      child: Container(
        height: SizeConfig.blockSizeVertical * 20,
        decoration: innerShadow,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Venäjällä on kylmä talvi.', style: TextStyle(fontSize: 20)),
              Text('Winter is cold in Russia.', style: TextStyle(fontSize: 20)),
              Text('俄罗斯的冬天很冷。', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
