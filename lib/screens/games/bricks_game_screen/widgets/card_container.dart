import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/repositories/bricks_provider.dart';
import 'package:words_app/utils/size_config.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key key,
    this.slideTransitionAnimation,
  }) : super(key: key);

  final Animation slideTransitionAnimation;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultSize * 12, vertical: defaultSize * 1.5),
      height: SizeConfig.blockSizeVertical * 35,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: SlideTransition(
        position: slideTransitionAnimation,
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [kBoxShadow],
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 4,
                  left: SizeConfig.blockSizeHorizontal * 4,
                  top: defaultSize * 3.0,
                  bottom: defaultSize * 15.0,
                ),
                decoration: BoxDecoration(
                  boxShadow: [kBoxShadow],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Text(
                  providerData.initialData.last.ownLang,
                ))),
      ),
    );
  }
}
