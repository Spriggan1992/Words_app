import 'package:flutter/material.dart';
import 'package:words_app/constants/constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = kMainColorBlue;
  final Text title;
  final AppBar appBar;

  const BaseAppBar({Key key, this.title, this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: kAppBarsColor,
      automaticallyImplyLeading: false,
      title: title,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
