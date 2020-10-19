import 'package:flutter/material.dart';

Future<void> showCustomDialog({
  BuildContext context,
  String content,
  String title,
  Function function,
}) async {
  showGeneralDialog(
      barrierColor: Color(0xff906c7a).withOpacity(0.9),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    title: Text(title),
                    content: Text(content),
                    actions: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Text("NO"),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: function,
                        child: Text("YES"),
                      ),
                    ],
                  ),
                ) ??
                false);
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return;
      });
}

void goToResultScreen(List data, BuildContext context, dynamic path) {
  if (data.isEmpty) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => path));
  }
}
