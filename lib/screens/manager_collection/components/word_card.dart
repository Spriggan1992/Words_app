import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  const WordCard({
    this.mainWordTitle,
    this.secondWordTitle,
    this.translationTitle,
    this.onTap,
    this.wordPicture,
    this.showOrHidePicture,
    this.showPicture,
  });

  final Function onTap;
  final String mainWordTitle;
  final String secondWordTitle;
  final String translationTitle;
  final String wordPicture;
  final Function showOrHidePicture;
  final bool showPicture;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF878686),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                    offset: Offset(1, 0.5))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Checkbox(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: false,
                          onChanged: null,
                        ),
                      ),
                      //Main word container
                      Container(
                        height: 30,
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(mainWordTitle,
                              style: TextStyle(
                                  fontSize: 25.0, color: Color(0xFFF8b6b6))),
                        ),
                      ),
                    ],
                  ),
                  // Translation word container
                  Expanded(
                    child: Container(
                      child: Text(translationTitle),
                    ),
                  ),
                  // Picture
                  GestureDetector(
                    onTap: showOrHidePicture,
                    child: showPicture
                        ? Icon(Icons.image)
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(wordPicture),
                                  fit: BoxFit.cover),
                            ),
                            // padding: EdgeInsets.all(0),
                            width: 48,
                            height: 48,
                          ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
