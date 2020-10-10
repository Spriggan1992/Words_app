import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  const ExpandableContainer({
    Key key,
    this.child,
    this.collapseHeight = 100.0,
    this.expandeHeight = 240.0,
    this.expanded = true,
  }) : super(key: key);

  final Widget child;
  final double collapseHeight;
  final double expandeHeight;
  final bool expanded;

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.expanded ? widget.expandeHeight : widget.collapseHeight,
      width: screenWidth,
      child: Container(child: widget.child),
    );
  }
}
