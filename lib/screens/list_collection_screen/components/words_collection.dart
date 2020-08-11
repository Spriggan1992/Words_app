import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/providers/collection_data.dart';
import 'package:words_app/providers/collections_provider.dart';
import 'package:words_app/screens/list_collection_screen/components/btns.dart';
import 'package:words_app/screens/list_collection_screen/components/list_collection_dialog.dart';

import 'package:words_app/components/my_separator.dart';
import 'package:words_app/screens/list_collection_screen/components/text_holder.dart';

class WordsCollection extends StatefulWidget {
  WordsCollection({
    this.goToManagerCollections,
    this.onSubmitTitleField,
    this.onChanged,
    this.deleteCollection,
    this.index,
    this.onSaveForm,
    this.onSubmitLanguageField,
  });

  final Function goToManagerCollections;

  final Function onSubmitTitleField;
  final Function onChanged;
  final Function deleteCollection;
  final Function onSubmitLanguageField;
  final int index;
  final Function onSaveForm;

  @override
  _WordsCollectionState createState() => _WordsCollectionState();
}

class _WordsCollectionState extends State<WordsCollection>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation rotateAnimation;
  bool isEditing = true;

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

    _controller.addListener(() {
      setState(() {});
      _controller.addStatusListener((status) {
        print(status);
      });
    });

    // runAnimation();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void runAnimation() {
  //   setState(() {
  //     final showBtnsdata = Provider.of<Collections>(context, listen: false);

  //     if (showBtnsdata.wordsCollectionData[widget.index].showBtns) {
  //       _controller.repeat(reverse: true);
  //     } else {
  //       _controller.reset();
  //     }
  //   });
  // }
  void runAnimation() {
    setState(() {
      if (isEditing) {
        _controller.repeat(reverse: true);
      } else {
        _controller.reset();
      }
    });
  }

  void toggleIsEditing() {
    setState(() {});
    isEditing = !isEditing;
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Collections>(context, listen: false)
        .wordsCollectionData[widget.index];
    final showBtnsdata = Provider.of<Collections>(context);

    // print(providerData.title);
    return GestureDetector(
        onTap: () => widget.goToManagerCollections(
            providerData.id, providerData.title), // Go to managerCollection
        onLongPress: () {
          setState(() {});
          showBtnsdata.toggleBtns();
          // globals.toggleShowAnimation();

          // runAnimation();

          // toggleIsEditing();
          // if (isEditing) {
          //   _controller.repeat(reverse: true);
          // } else {
          //   _controller.reset();
          // }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            overflow: Overflow.visible,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, right: 5, left: 5),
                child: Container(
                  key: ValueKey(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          height: 30.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 1, right: 1, bottom: 1, left: 1),
                              child: Text(
                                providerData.title ?? '',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        MySeparator(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          dWidth: 2.0,
                          dCount: 4.0,
                          color: Colors.grey,
                          height: 2.0,
                        ),
                        SizedBox(height: 5.0),
                        FittedBox(
                          child: TextHolder(
                            titleNameValue: providerData.language,
                            fontSize1: 9.0,
                            fontSize2: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        TextHolder(
                          titleName: 'words: ',
                          titleNameValue: '16',
                          fontSize1: 9.0,
                          fontSize2: 15.0,
                        ),
                        SizedBox(height: 5.0),
                        TextHolder(
                          titleName: 'learned: ',
                          titleNameValue: '11',
                          fontSize1: 9.0,
                          fontSize2: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              providerData.showBtns
                  ? Positioned(
                      top: -1,
                      left: 75,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: rotateAnimation.value,
                            child: child,
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            // Edit btn
                            Btns(
                              backgroundColor: Colors.white,
                              icon: Icons.edit,
                              color: Colors.black54,
                              onPress: () {
                                // Open Dialog Window
                                showEditDialog(
                                  context,
                                  widget.index,
                                  widget.deleteCollection,
                                  widget.onSaveForm,
                                  widget.onSubmitTitleField,
                                  widget.onSubmitLanguageField,
                                );
                              },
                            ),
                            Btns(
                              backgroundColor: Colors.white,
                              icon: Icons.delete,
                              color: Colors.black54,
                              onPress: () {},
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ))
                  : Container()
            ],
          ),
        ));
  }

  Future showEditDialog(
    BuildContext context,
    index,
    deleteCollection,
    onSaveForm,
    onSubmitTitleField,
    onSubmitLanguageField,
  ) {
    return showGeneralDialog(
        barrierColor: Color(0xff906c7a).withOpacity(0.9),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  content: StatefulBuilder(builder: (context, setState) {
                    return CollectionListDialog(
                        index: index,
                        deleteCollection: deleteCollection,
                        onSubmit: onSubmitTitleField,
                        onSaveForm: onSaveForm,
                        onSubmitLanguageField: onSubmitLanguageField);
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
  }
}
