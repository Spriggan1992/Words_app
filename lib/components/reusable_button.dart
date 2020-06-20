import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({this.titleText, this.color1, this.color2});

  final String titleText;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.01, 1],
          colors: [color1, color2],
        ),
      ),
      child: MaterialButton(
        child: Text(titleText, style: TextStyle(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }
}

// Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Material(
//         color: Color(0xFF01a9b4),
//         borderRadius: BorderRadius.circular(30.0),
//         child: MaterialButton(
//           child: Text(
//             titleText,
//           ),
//           onPressed: () {},
//         ),
//       ),
//     );
