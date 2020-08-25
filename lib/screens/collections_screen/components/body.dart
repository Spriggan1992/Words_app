import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/repositories/collections_repository.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:words_app/screens/collections_screen/components/collection_card.dart';
import 'package:words_app/screens/words_screen/words_screen.dart';
import 'collection_edit_dialog.dart';

class Body extends StatefulWidget {
  final List<Collection> collections;

  const Body({
    Key key,
    this.collections,
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
    // print(widget.collections);
    return AnimationLimiter(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: CustomScrollView(
          slivers: <Widget>[
            // Provider data, here

            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                /// Delete collection
                void removeCollection() {
                  // providerData.deleteCollection(
                  //     providerData.wordsCollectionData[index]);
                  Navigator.of(context).pop(true);
                }

                String handleSubmitTitle;
                String handleSubmitLanguage;
                // final wordsCollectionData =
                //     providerData.wordsCollectionData[index];
                return AnimationConfiguration.staggeredGrid(
                  columnCount: 3,
                  position: index,
                  duration: Duration(milliseconds: 400),
                  child: ScaleAnimation(
                    // scale: 0.5,
                    child: FadeInAnimation(
                      child: CollectionCard(
                        collections: widget.collections,
                        runAnimation: () {
                          // providerData.toggleBtns();
                          // providerData.runAnimation(_controller);
                        },
                        rotateAnimation: rotateAnimation,
                        index: index,

                        // Remove collection from data
                        /// Show dialog with delete confirmation
                        deleteCollection: () {
                          deleteConfirmation(context, removeCollection,
                              'Do you want to delete your collection?');
                        },
                        goToManagerCollections:
                            (String collectionId, String title) {
                          Navigator.pushNamed(context, WordsScreen.id,
                              arguments: {'id': collectionId, 'title': title});
                          // providerData.checkIsEditingBtns(_controller);
                          setState(() {});
                        },

                        /// Show dialog with add collection
                        showEditDialog: (Collection collection) {
                          showGeneralDialog(
                              barrierColor: Color(0xff906c7a).withOpacity(0.9),
                              transitionBuilder: (context, a1, a2, widget) {
                                final curvedValue =
                                    Curves.easeInOutBack.transform(a1.value) -
                                        1.0;
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
                                          return CollectionsEditDialog(
                                            index: index,
                                            collection: collection,
                                            // Save form
                                            onSaveForm: () {
                                              // providerData
                                              //     .handleSubmitEditTitle(
                                              //         handleSubmitTitle,
                                              //         wordsCollectionData);
                                              // providerData
                                              //     .handleSubmitEditLanguageTitle(
                                              //         handleSubmitLanguage,
                                              //         wordsCollectionData);
                                              
                                            },

                                            // Takes value from [TextField], and stored it in handleSubmiteText
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
                              pageBuilder:
                                  (context, animation1, animation2) {});
                        },
                      ),
                    ),
                  ),
                );
              }, childCount: widget.collections.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
