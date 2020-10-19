import 'package:flutter/material.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/helpers/functions.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';

class WordsAppbar extends StatelessWidget {
  const WordsAppbar(
      {this.isEditingMode,
      this.collectionTitle,
      this.collectionId,
      this.state,
      Key key})
      : super(key: key);

  final bool isEditingMode;
  final String collectionTitle;
  final String collectionId;
  final WordsSuccess state;

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;
    return Container(
      child: Container(
        color: isEditingMode
            ? kWordsAppbarSelectedColor
            : Theme.of(context).primaryColor,
        width: SizeConfig.blockSizeHorizontal * 100,
        height: defaultSize * 6,
        child: Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            Align(
              child: isEditingMode
                  ? Text('')
                  : Text(
                      "${collectionTitle ?? ''}",
                      style: kAppBarTextStyle,
                    ),
            ),
            isEditingMode
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: defaultSize * 4),
                        child: Text("${state.selectedList?.length ?? 0}",
                            style: TextStyle(fontSize: defaultSize * 1.8)),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            context.bloc<WordsBloc>().add(WordsToggledAll());
                            context
                                .bloc<WordsBloc>()
                                .add(WordsAddSelectedAllToSelectedList());
                          },
                          icon: Icon(Icons.select_all)),
                      IconButton(
                          onPressed: () => showCustomDialog(
                                context: context,
                                title: 'Are you sure?',
                                content: 'Do you want to delete this word?',
                                function: () {
                                  BlocProvider.of<WordsBloc>(context)
                                      .add(WordsDeletedSelectedAll());
                                  Navigator.pop(context);
                                },
                              ),
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            context.bloc<WordsCubit>().toggleEditMode();
                            context
                                .bloc<WordsBloc>()
                                .add(WordsTurnOffIsEditingMode());
                          },
                          icon: Icon(Icons.close)),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableIconBtn(
                        icon: Icons.arrow_back_ios,
                        onPress: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              CollectionsScreen.id,
                              ModalRoute.withName(CollectionsScreen.id));
                          context
                              .bloc<CollectionsBloc>()
                              .add(CollectionsLoaded());
                        },
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          //FIXME: Temp used to populate words  delete it later
                          context
                              .bloc<WordsBloc>()
                              .add(WordsPopulate(id: collectionId));
                          context
                              .bloc<WordsBloc>()
                              .add(WordsLoaded(id: collectionId));
                        },
                      ),
                      IconButton(
                        icon: context.bloc<ThemeBloc>().state.themeData ==
                                Themes.themeData[AppTheme.LightTheme]
                            ? Icon(Icons.brightness_4)
                            : Icon(Icons.brightness_5),
                        color: Colors.white,
                        iconSize: defaultSize * 2.5,
                        onPressed: () =>
                            context.bloc<ThemeBloc>().add(UpdatedTheme()),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
