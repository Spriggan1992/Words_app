import 'package:flutter/material.dart';

void deleteConfirmation(BuildContext context, Function remover, String title) {
  showGeneralDialog(
      barrierColor: Color(0xff906c7a).withOpacity(0.9),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                title: new Text('Are you sure?'),
                content: new Text(title),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("NO"),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: remover,
                    child: Text("YES"),
                  ),
                ],
              ),
            ));
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      // ignore: missing_return
      pageBuilder: (context, animation1, animation2) {});
}
