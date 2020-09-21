import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> actions;

  const BaseAppBar({Key key, this.title, this.appBar, this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
