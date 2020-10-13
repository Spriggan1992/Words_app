import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/models/collection.dart';
import 'package:words_app/screens/words_screen/widgets/widgets.dart';
import '../../../models/word.dart';
import '../../../config/size_config.dart';
import '../../review_card_screen/review_card.dart';
import 'expandable_container.dart';

class WordCard extends StatefulWidget {
  const WordCard({
    this.index,
    this.selectedList,
    this.collection,
    this.word,
    this.isEditingMode,
    this.words,
    this.collectionId,
    this.collectionTitle,
  });
  final bool isEditingMode;
  final int index;
  final List selectedList;
  final Word word;
  final Collection collection;
  final List<Word> words;
  final String collectionId;
  final String collectionTitle;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {
  AnimationController _expandController;
  Animation<double> _animation;
  Animation<double> textAnimation;
  Animation rotationAnimation;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();

    _expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation =
        CurvedAnimation(parent: _expandController, curve: Curves.fastOutSlowIn);
    textAnimation = Tween(begin: 15.0, end: 20.0).animate(_expandController);
    rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.5).animate(_expandController);
  }

  void runExpandContainerAnimation() {
    setState(() {
      if (!isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultSize = SizeConfig.defaultSize;

    /// Receiving word data from[ words_screen], using index to extract single item from array
    final word = widget.word;

    return ExpandableContainer(
      collapseHeight: defaultSize * 9,
      expandeHeight: defaultSize * 23,
      expanded: isExpanded,
      child: GestureDetector(
        // onLongPress: providerData.isEditingMode
        onLongPress: widget.isEditingMode
            ? () {}
            : () {
                context.bloc<WordsCubit>().toggleEditMode();
                context.bloc<WordsBloc>().add(WordsToggled(word: word));

                context
                    .bloc<WordsBloc>()
                    .add(WordsAddToSelectedList(word: word));
              },
        onTap: widget.isEditingMode
            ? () {
                context.bloc<WordsBloc>().add(WordsToggled(word: word));
                context
                    .bloc<WordsBloc>()
                    .add(WordsAddToSelectedList(word: word));
              }
            : () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ReviewCard(
                      index: widget.index,
                      words: widget.words,
                      collectionId: widget.collectionId,
                      collectionTitle: widget.collectionTitle,
                    ),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = 0.0;
                      var end = 1.0;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return ScaleTransition(
                        scale: animation.drive(tween),
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  ),
                );
              },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: isExpanded ? Colors.black26 : Colors.transparent),
            ),
            color: isExpanded
                ? Color(0xFFCFD8DC)
                : word.isSelected ? Colors.grey[400] : Colors.transparent,
          ),
          width: SizeConfig.blockSizeHorizontal * 100,
          child: Stack(
            alignment: Alignment.topLeft,
            overflow: Overflow.clip,
            children: <Widget>[
              SpeechPart(
                isExpanded: isExpanded,
                word: word,
              ),
              TargetLang(
                isExpanded: isExpanded,
                word: word,
              ),
              OwnLang(
                isExpanded: isExpanded,
                word: word,
              ),
              SecondLang(
                  animation: _animation, isExpanded: isExpanded, word: word),
              ArrowBtn(
                isExpanded: isExpanded,
                isEditingMode: widget.isEditingMode,
                rotationAnimation: rotationAnimation,
                runAnimation: runExpandContainerAnimation,
              ),
              Example(
                expandController: _expandController,
                word: word,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
