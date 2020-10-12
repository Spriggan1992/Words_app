import 'package:flutter/material.dart';

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;
  final double dWidth;
  final double dCount;
  final EdgeInsetsGeometry padding;

  const MySeparator(
      {this.height = 1,
      this.color = Colors.black,
      this.dWidth,
      this.dCount,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          final dashWidth = dWidth;
          final dashHeight = height;
          final dashCount = (boxWidth / (dCount * dashWidth)).floor();
          return Flex(
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
          );
        },
      ),
    );
  }
}
