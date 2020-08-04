import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = kMainColorBlue;
  final Text title;
  final AppBar appBar;
  final List<Widget> actions;

  const BaseAppBar({Key key, this.title, this.appBar, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
