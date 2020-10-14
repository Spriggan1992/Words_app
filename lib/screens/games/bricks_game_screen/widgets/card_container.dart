import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/repositories/repositories.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    Key key,
    this.slideTransitionAnimation,
  }) : super(key: key);

  final Animation slideTransitionAnimation;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultSize * 12, vertical: defaultSize * 1.5),
      height: SizeConfig.blockSizeVertical * 31,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: SlideTransition(
        position: slideTransitionAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [kBoxShadow],
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
            ),
            Positioned(
              top: defaultSize * 4,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 35,
                height: SizeConfig.blockSizeVertical * 5,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: defaultSize),
                decoration: BoxDecoration(
                  boxShadow: [kBoxShadow],
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Text(
                  providerData.initialData.last.ownLang,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
