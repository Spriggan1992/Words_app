import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/screens/list_collection_screen/components/words_collection.dart';
import 'package:words_app/screens/manager_collection/collection_manager.dart';

import 'list_collection_dialog.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation rotateAnimation;

  static final tweenSequence = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: -0.2)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 2),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 92)
  ]);

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    rotateAnimation = tweenSequence.animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: CustomScrollView(
        slivers: <Widget>[
          // Provider data, here
          Consumer<Collections>(builder: (context, providerData, child) {
            return SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                String handleSubmitTitle;
                String handleSubmitLanguage;
                final wordsCollectionData =
                    providerData.wordsCollectionData[index];
                return WordsCollection(
                  runAnimation: () {
                    // providerData.toggleBtns();
                    providerData.runAnimation(_controller);
                  },
                  rotateAnimation: rotateAnimation,
                  index: index,

                  // Remove collection from data
                  deleteCollection: () {
                    providerData.deleteCollection(wordsCollectionData);
                  },

                  goToManagerCollections: (String collectionId, String title) {
                    Navigator.pushNamed(context, CollectionManager.id,
                        arguments: {'id': collectionId, 'title': title});
                    providerData.checkIsEditingBtns(_controller);
                    setState(() {});
                  },
                  showEditDialog: () {
                    showGeneralDialog(
                        barrierColor: Color(0xff906c7a).withOpacity(0.9),
                        transitionBuilder: (context, a1, a2, widget) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(a1.value) - 1.0;
                          return Transform(
                              transform: Matrix4.translationValues(
                                  0.0, curvedValue * 200, 0.0),
                              child: Opacity(
                                opacity: a1.value,
                                child: AlertDialog(
                                  elevation: 0,
                                  backgroundColor: Colors.transparent,
                                  content: StatefulBuilder(
                                      builder: (context, setState) {
                                    return CollectionListDialog(
                                      index: index,
                                      // Save form
                                      onSaveForm: () {
                                        providerData.handleSubmitEditTitle(
                                            handleSubmitTitle,
                                            wordsCollectionData);
                                        providerData
                                            .handleSubmitEditLanguageTitle(
                                                handleSubmitLanguage,
                                                wordsCollectionData);
                                        Navigator.pop(context);
                                      },
                                      onSubmitLanguageField: (value) {
                                        handleSubmitLanguage = value;
                                      },
                                      // Takes value from [TextField], and stored it in handleSubmiteText
                                      onSubmitTitleField: (value) {
                                        handleSubmitTitle = value;
                                      },
                                    );
                                  }),
                                ),
                              ));
                        },
                        transitionDuration: Duration(milliseconds: 200),
                        barrierDismissible: false,
                        barrierLabel: '',
                        context: context,
                        // ignore: missing_return
                        pageBuilder: (context, animation1, animation2) {});
                  },
                );
              }, childCount: providerData.wordsCollectionData.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 3,
              ),
            );
          })
        ],
      ),
    );
  }
}
