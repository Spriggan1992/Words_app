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
  // AnimationController expandController;
  // Animation<double> animation;

  // @override
  // void initState() {
  //   super.initState();

  //   expandController =
  //       AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  //   animation =
  //       CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
  // }

  // @override
  // void dispose() {
  //   expandController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      // curve: ,
      duration: Duration(milliseconds: 300),
      // curve: Curves.easeOut,
      height: widget.expanded ? widget.expandeHeight : widget.collapseHeight,
      width: screenWidth,
      child: Container(child: widget.child),
    );
  }
}
