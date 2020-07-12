import 'package:flutter/material.dart';
import 'package:words_app/components/base_appbar.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/screens/result_screen/result_screen.dart';

class Training extends StatelessWidget {
  static String id = 'training_screen';

  @override
  Widget build(BuildContext context) {
    bool showAnswer = false;
    bool alwaysTrue = true;
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: BaseAppBar(
            title: Text('appBar title'),
            appBar: AppBar(),
          ),

//        appBar: AppBar(
//          centerTitle: true,
//          backgroundColor: kMainColorBlue,
//          automaticallyImplyLeading: false,
//          title: Text('Training'),
//        ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            child: Container(
              height: 60.0,
              color: kMainColorBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 55,
                    padding: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        size: 40,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main CardContainer
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF878686),
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                          offset: Offset(1, 3)),
                    ],
                  ),
                  padding: EdgeInsets.only(top: 30),
                  width: 250,
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        // Show Image
                        child: !showAnswer
                            ? Container(
                                alignment: Alignment.center,
                                child:
                                    Text('?', style: TextStyle(fontSize: 40)),
                              )
                            : Container(),
                      ),
                      SizedBox(height: 30.0),
                      TextHolder(title: 'Main word', showAnswer: alwaysTrue),
                      TextHolder(title: 'Second word', showAnswer: showAnswer),
                      TextHolder(title: 'Translation', showAnswer: showAnswer),
                    ],
                  ),
                ),
              ),

              // Icons Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ReusableIconButton(
                      icon: Icons.close, color: Colors.red[400], iconSize: 50),
                  ReusableIconButton(
                      icon: Icons.remove_red_eye,
                      color: Colors.black,
                      iconSize: 50),
                  ReusableIconButton(
                    icon: Icons.done,
                    color: Colors.green[400],
                    iconSize: 50,
                    onPressed: () => Navigator.pushNamed(context, Result.id),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class TextHolder extends StatelessWidget {
  const TextHolder({this.title, this.showAnswer});
  final bool showAnswer;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            color: !showAnswer ? Colors.grey[400] : Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: !showAnswer ? Text('?') : Text(title)),
    );
  }
}

class ReusableIconButton extends StatelessWidget {
  const ReusableIconButton(
      {this.icon, this.color, this.iconSize, this.onPressed});
  final IconData icon;
  final Color color;
  final double iconSize;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      iconSize: iconSize,
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
