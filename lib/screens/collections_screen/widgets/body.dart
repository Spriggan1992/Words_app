import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:words_app/bloc/collections/collections_bloc.dart';
import '../../../models/collection.dart';
import '../../words_screen/words_screen.dart';
import 'collection_card.dart';
import 'collection_edit_dialog.dart';

class Body extends StatelessWidget {
  final List<Collection> collections;

  const Body({
    Key key,
    this.collections,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(widget.collections);
    return GestureDetector(
      onTap: () {
        context.bloc<CollectionsBloc>().add(CollectionsSetToFalse());
      },
      child: AnimationLimiter(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    columnCount: 3,
                    position: index,
                    duration: Duration(milliseconds: 400),
                    child: ScaleAnimation(
                      // scale: 0.5,
                      child: FadeInAnimation(
                        child: CollectionCard(
                          collections: collections,
                          index: index,
                          goToManagerCollections:
                              (String collectionId, String title) {
                            Navigator.pushNamed(
                              context,
                              WordsScreen.id,
                              arguments: {
                                'id': collectionId,
                                'title': title,
                                'lang': collections[index].language
                              },
                            );
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
                              pageBuilder: (context, animation1, animation2) {},
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }, childCount: collections.length),
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
      ),
    );
  }
}
