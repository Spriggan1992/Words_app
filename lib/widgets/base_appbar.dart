import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/screenDefiner.dart';
import 'package:words_app/config/themes.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final AppBar appBar;
  final List<Widget> actions;
  final ScreenDefiner screenDefiner;
  final Function back;

  const BaseAppBar(
      {Key key,
      this.title,
      this.appBar,
      this.actions,
      this.screenDefiner,
      this.back})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: title,
      actions: screenDefiner == ScreenDefiner.cardCreator
          ? actions
          : [_buildThemeIconButton(context)],
      leading: _buildBackBtn(context, screenDefiner),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  IconButton _buildThemeIconButton(BuildContext context) {
    final bool isLightTheme = context.bloc<ThemeBloc>().state.themeData ==
        Themes.themeData[AppTheme.LightTheme];
    return IconButton(
      icon: isLightTheme ? Icon(Icons.brightness_4) : Icon(Icons.brightness_5),
      color: Colors.white,
      iconSize: 25.0,
      onPressed: () => context.bloc<ThemeBloc>().add(UpdatedTheme()),
    );
  }

  Widget _buildBackBtn(BuildContext context, ScreenDefiner screenDefiner) {
    if (screenDefiner == ScreenDefiner.collections) {
      return Transform.rotate(
        angle: 180 * pi / 180,
        child: ReusableIconBtn(
          color: Theme.of(context).accentColor,
          icon: Icons.exit_to_app,
          onPress: () => SystemNavigator.pop(),
        ),
      );
    } else if (screenDefiner == ScreenDefiner.trainingManager) {
      return ReusableIconBtn(
          color: Theme.of(context).accentColor,
          icon: Icons.arrow_back_ios,
          onPress: () => Navigator.pop(context));
    } else if (screenDefiner == ScreenDefiner.result) {
      return SizedBox.shrink();
    } else if (screenDefiner == ScreenDefiner.trainings) {
      return ReusableIconBtn(
        color: Theme.of(context).accentColor,
        icon: Icons.arrow_back_ios,
        onPress: () => showCustomDialog(
            context: context,
            title: 'Are you sure?',
            content: 'Do you want to finish your traning?',
            function: () {
              Navigator.pushNamedAndRemoveUntil(context, TrainingManager.id,
                  ModalRoute.withName(TrainingManager.id));
            }),
      );
    } else if (screenDefiner == ScreenDefiner.bricks) {
      return ReusableIconBtn(
          color: Theme.of(context).accentColor,
          icon: Icons.arrow_back_ios,
          onPress: back);
    } else {
      return ReusableIconBtn(
        color: Theme.of(context).accentColor,
        icon: Icons.arrow_back_ios,
        onPress: () => Navigator.pop(context),
      );
    }
  }
}
