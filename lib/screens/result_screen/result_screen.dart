import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';
import 'package:words_app/widgets/reusable_main_button.dart';
import 'package:words_app/utils/size_config.dart';

class Result extends StatelessWidget {
  static String id = 'result_screenshot';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Result'),
        ),
        body: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: defaultSize * 4, vertical: defaultSize * 9),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultSize * 0.5),
                color: Colors.white,
                boxShadow: [kBoxShadow],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextHolder(
                          titles: ['Correct: ', '0'],
                        ),
                        SizedBox(height: defaultSize * 3),
                        TextHolder(
                          titles: ['Wrong: ', '0'],
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(defaultSize * 0.5),
                      child: ReusableMainButton(
                        titleText: 'Replay',
                        backgroundColor: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}

class TextHolder extends StatelessWidget {
  const TextHolder({
    Key key,
    @required this.titles,
  }) : super(key: key);

  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          2,
          (index) => Text(
            titles[index].toString(),
            style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                  TextStyle(
                    fontSize: defaultSize * 3,
                  ),
                ),
          ),
        )
      ],
    );
  }
}
