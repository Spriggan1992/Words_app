import 'package:flutter/material.dart';

///TODO: need to rewrite;
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
                    title: Text('Are you sure?'),
                    content: Text(title),
                    actions: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Text("NO"),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: remover,
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

void showCustomDialog(BuildContext context, Function confirmFunc) {
  showGeneralDialog(
      barrierColor: Color(0xff906c7a).withOpacity(0.9),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
                  opacity: a1.value,
                  child: new AlertDialog(
                    title: new Text('Some of your card fields are empty!'),
                    content: new Text(
                        'Comeback when you fix it or you can start training without those words!'),
                    actions: <Widget>[
                      new GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Text("Cancel"),
                      ),
                      SizedBox(height: 16),
                      new GestureDetector(
                        onTap: confirmFunc,
                        child: Text("Continue"),
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

Future<bool> onBackPressed(BuildContext context, Function onTap) {
  return showGeneralDialog(
      barrierColor: Color(0xff906c7a).withOpacity(0.9),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
                  opacity: a1.value,
                  child: new AlertDialog(
                    title: new Text('Are you sure?'),
                    content: new Text('Do you want to finish your traning?'),
                    actions: <Widget>[
                      new GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Text("NO"),
                      ),
                      SizedBox(height: 16),
                      new GestureDetector(
                        onTap: onTap,
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
