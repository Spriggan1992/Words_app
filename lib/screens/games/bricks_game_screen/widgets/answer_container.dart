import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/repositories/bricks_provider.dart';
import 'package:words_app/utils/size_config.dart';

class AnswerContainer extends StatefulWidget {
  AnswerContainer(
      {Key key, this.successColorAnimation, this.errorColorAnimation})
      : super(key: key);
  final Animation<dynamic> successColorAnimation;
  final Animation<dynamic> errorColorAnimation;
  @override
  _AnswerContainerState createState() => _AnswerContainerState();
}

class _AnswerContainerState extends State<AnswerContainer> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context);

    return SingleChildScrollView(
      child: Container(
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
                  children: providerData.answerWordArray.map((item) {
                    return Visibility(
                      child: GestureDetector(
                        onTap: providerData.dynamicColor == DynamicColor.wrong
                            ? () {}
                            : () {
                                setState(() {
                                  providerData.returnLetters(item);
                                });
                              },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [kBoxShadow],
                              color: providerData.setUpColor(
                                  widget.successColorAnimation,
                                  widget.errorColorAnimation)),
                          alignment: Alignment.center,
                          width: 41,
                          height: 42,
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
// List<Widget> buildAnswerContainer(
//     setState, context, successColorAnimation, errorColorAnimation) {
//   final providerData = Provider.of<Bricks>(context, listen: false);
//   List<Widget> listWidget = [];
//   for (int i = 0; i < providerData.answerWordArray.length; i++) {
//     listWidget.add(Visibility(
//       child: GestureDetector(
//         onTap: providerData.dynamicColor == DynamicColor.wrong
//             ? () {}
//             : () {
//                 setState(() {
//                   providerData.returnLetters(providerData.answerWordArray[i]);
//                 });
//               },
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               boxShadow: [kBoxShadow],
//               color: providerData.setUpColor(
//                   successColorAnimation, errorColorAnimation)),
//           alignment: Alignment.center,
//           width: 41,
//           height: 42,
//           child: Text(
//             providerData.answerWordArray[i],
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ),
//     ));
//   }
//   return listWidget;
// }
