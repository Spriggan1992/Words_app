import 'package:flutter/material.dart';
import 'package:words_app/config/config.dart';

class ArrowBtn extends StatelessWidget {
  final bool isEditingMode;
  final bool isExpanded;
  final Animation rotationAnimation;
  final Function runAnimation;

  const ArrowBtn(
      {Key key,
      this.isEditingMode,
      this.rotationAnimation,
      this.runAnimation,
      this.isExpanded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: isEditingMode
          ? SizedBox.shrink()
          : Positioned(
              left: defaultSize * 36,
              top: defaultSize * 0.9,
              child: RotationTransition(
                turns: rotationAnimation,
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    color: isExpanded ? Color(0xFF34c7b3) : Colors.black,
                    onPressed: runAnimation,
                  ),
                ),
              ),
            ),
    );
  }
}
