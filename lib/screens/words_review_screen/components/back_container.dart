import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/providers/words_provider.dart';

class BackContainer extends StatelessWidget {
  const BackContainer({
    Key key,
    this.index,

    // this.toggleContainer,
  }) : super(key: key);

  final int index;

  // final Function toggleContainer;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    final wordsData = Provider.of<Words>(context, listen: false).wordsData;

    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Container(
              width: screenWidth * 0.7,
              height: screenHeight * 0.8,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15),
                color: kAppBarsColor,
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        wordsData[index].translation,
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'сущ',
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      SizedBox(height: 30.0),
                      Container(
                        width: screenWidth * 0.4,
                        height: screenHeight * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(wordsData[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Container(
              width: screenWidth * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('В России холодная зима',
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
