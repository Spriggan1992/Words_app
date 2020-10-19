import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/config/config.dart';

import 'package:words_app/repositories/repositories.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

import 'widgets/text_holder.dart';

class ResultScreen extends StatelessWidget {
  static String id = 'result_screenshot';
  final int correct;
  final int wrong;

  const ResultScreen({Key key, this.correct, this.wrong}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;
    final providerData = Provider.of<Bricks>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, TrainingManager.id,
            ModalRoute.withName(TrainingManager.id));
        providerData.correct = 0;
        providerData.wrong = 0;
        return;
      },
      child: Scaffold(
          appBar: BaseAppBar(
            screenDefiner: ScreenDefiner.result,
            appBar: AppBar(),
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
                            titles: ['Correct: ', correct.toString()],
                          ),
                          SizedBox(height: defaultSize * 3),
                          TextHolder(
                            titles: ['Wrong: ', wrong.toString()],
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TrainingManager()));
                            providerData.correct = 0;
                            providerData.wrong = 0;
                          },
                        ),
                      )
                    ],
                  ),
                )),
          )),
    );
  }
}
