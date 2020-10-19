import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/animations/shake_animation.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/collections_screen/widgets/btns.dart';

class CollectionCardEditDeleteBtns extends StatelessWidget {
  final bool isEditingBtns;
  final Function showDialog;
  final String id;
  const CollectionCardEditDeleteBtns(
      {Key key, this.isEditingBtns, this.showDialog, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double defaultSize = SizeConfig.defaultSize;

    return isEditingBtns
        ? Positioned(
            top: defaultSize * (-0.1),
            left: defaultSize * 7.6,
            child: Container(
              child: Row(
                children: <Widget>[
                  // Edit btn
                  Btns(
                      backgroundColor: Colors.white,
                      icon: Icons.edit,
                      color: Colors.black54,
                      onPress: () {
                        BlocProvider.of<CollectionsBloc>(context)
                            .add(CollectionsToggleAll());
                        showDialog();
                      }),

                  Btns(
                    backgroundColor: Colors.white,
                    icon: Icons.delete,
                    color: Colors.black54,
                    onPress: () {
                      showCustomDialog(
                        context: context,
                        title: 'Are you sure?',
                        content: 'Do you want to delete your collection?',
                        function: () {
                          BlocProvider.of<CollectionsBloc>(context)
                            ..add(CollectionsDeleted(id: id));
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                  SizedBox(width: defaultSize * 0.5),
                ],
              ),
            ).shakeAnimation,
          )
        : Container();
  }
}

extension AnimationExtension on Widget {
  Widget get shakeAnimation {
    return ShakeAnimation(child: this);
  }
}
