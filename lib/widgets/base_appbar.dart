import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/widgets/widgets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> actions;
  final ScreenDefiner screenDefiner;

  const BaseAppBar(
      {Key key, this.title, this.appBar, this.actions, this.screenDefiner})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
      leading: buildBackBtn(context, screenDefiner),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  Widget buildBackBtn(BuildContext context, ScreenDefiner screenDefiner) {
    if (screenDefiner == ScreenDefiner.collections) {
      return Transform.rotate(
        angle: 180 * pi / 180,
        child: ReusableIconBtn(
          color: Theme.of(context).accentColor,
          icon: Icons.exit_to_app,
          onPress: () => SystemNavigator.pop(),
        ),
      );
    } else {
      return ReusableIconBtn(
        color: Theme.of(context).accentColor,
        icon: Icons.arrow_back_ios,
        onPress: () => Navigator.pop(context),
      );
    }
  }
}
