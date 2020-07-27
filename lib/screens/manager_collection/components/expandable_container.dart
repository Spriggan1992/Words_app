import 'package:flutter/material.dart';

class ExpandableContainer extends StatelessWidget {
  const ExpandableContainer({
    Key key,
    this.child,
    this.collapseHeight = 70.0,
    this.expandeHeight = 230.0,
    this.expanded = true,
  }) : super(key: key);

  final Widget child;
  final double collapseHeight;
  final double expandeHeight;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      height: expanded ? expandeHeight : collapseHeight,
      width: screenWidth,
      child: Container(child: child),
    );
  }
}
