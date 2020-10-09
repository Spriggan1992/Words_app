import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/words/words_bloc.dart';
import 'package:words_app/cubit/words/words_cubit.dart';
import 'package:words_app/models/collection_model.dart';
import '../../../models/word_model.dart';
import '../../../utils/size_config.dart';
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
  });
  final bool isEditingMode;
  final int index;
  final List selectedList;
  final Word word;
  final Collection collection;
  final List<Word> words;
  final String collectionId;

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {
  // AnimationController pageAnimationController;
  // Animation pageAnimation;
  AnimationController expandController;
  Animation<double> animation;
  Animation<double> textAnimation;
  Animation rotationAnimation;
  bool isExpanded = false;
  bool isEditMode = false;
  @override
  void initState() {
    super.initState();

    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation =
        CurvedAnimation(parent: expandController, curve: Curves.fastOutSlowIn);
    textAnimation = Tween(begin: 15.0, end: 20.0).animate(expandController);
    rotationAnimation =
        Tween<double>(begin: 0.0, end: 0.5).animate(expandController);
  }

  void runExpandContainerAnimation() {
    setState(() {
      if (!isExpanded) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
      isExpanded = !isExpanded;
    });
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // widget.words.forEach((item) => print(item.isSelected));
    SizeConfig().init(context);
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
              buildSpeechPart(defaultSize, word),
              buildTargetLangContainer(defaultSize, word, context),
              buildOwnLangContainer(defaultSize, word, context),
              buildSecondWordContainer(defaultSize, word, context),
              buildArrowBtnContainer(defaultSize),
              buildExampleContainer(defaultSize, word)
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildSpeechPart(double defaultSize, Word word) {
    return Positioned(
      // curve: Curves.easeIn,
      top: defaultSize * 2.2,
      left: defaultSize * 1.5,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isExpanded ? defaultSize : defaultSize * 4,
        height: defaultSize * 8,
        child: Text(
          "${word.part.partName}",
          style: TextStyle(
            fontSize: word.part.partName.length > 1
                ? defaultSize * 1.5
                : defaultSize * 2.0,
            color: word.part.partColor,
          ),
        ),
      ),
    );
  }

  AnimatedPositioned buildTargetLangContainer(
    double defaultSize,
    Word word,
    BuildContext context,
  ) {
    return AnimatedPositioned(
      curve: Curves.easeIn,
      left: isExpanded ? defaultSize * 3.7 : defaultSize * 6.0,
      top: defaultSize * 1.7,
      duration: Duration(milliseconds: 300),
      child: Container(
        height: defaultSize * 3,
        width: isExpanded ? defaultSize * 32 : defaultSize * 30,
        child: AutoSizeText(
          // TODO : difficulty problem
          "${word.targetLang}" ?? '',
          maxLines: 2, //Main word
          style: Theme.of(context).primaryTextTheme.bodyText2.merge(TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: defaultSize * 2,
              )),
        ),
      ),
    );
  }

  AnimatedPositioned buildOwnLangContainer(
      double defaultSize, Word word, BuildContext context) {
    return AnimatedPositioned(
      curve: Curves.easeIn,
      left: isExpanded ? defaultSize * 3.7 : defaultSize * 6.0,
      top: defaultSize * 5.3,
      duration: Duration(milliseconds: 300),
      child: Container(
        height: defaultSize * 3,
        width: isExpanded ? defaultSize * 32 : defaultSize * 30,
        child: AutoSizeText(
          word.ownLang ?? '', // Translation
          maxLines: 2,
          style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: defaultSize * 1.6,
                  fontFamily: 'italic',
                  fontStyle: FontStyle.italic,
                ),
              ),
        ),
      ),
    );
  }

  Positioned buildSecondWordContainer(
      double defaultSize, Word word, BuildContext context) {
    return Positioned(
      left: defaultSize * 3.7,
      top: defaultSize * 8.5,
      child: ScaleTransition(
        scale: animation,
        child:
            // Word2
            Container(
          width: isExpanded ? defaultSize * 32 : defaultSize * 30,
          height: defaultSize * 2,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              word.secondLang ?? ' ',
              style: Theme.of(context).primaryTextTheme.bodyText2.merge(
                    TextStyle(
                      color: Colors.black54,
                      fontSize: defaultSize * 1.3,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildArrowBtnContainer(
    double defaultSize,
  ) {
    if (widget.isEditingMode) {
      return Container();
    } else
      return Positioned(
        left: defaultSize * 36,
        top: defaultSize * 0.9,
        child: RotationTransition(
          turns: rotationAnimation,
          child: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 30,
              color: isExpanded ? Color(0xFF34c7b3) : Colors.black,
              onPressed: () {
                runExpandContainerAnimation();
              },
            ),
          ),
        ),
      );
  }

  Positioned buildExampleContainer(double defaultSize, Word word) {
    return Positioned(
      left: defaultSize * 3.7,
      top: defaultSize * 12,
      child: ScaleTransition(
        scale: CurvedAnimation(
            parent: expandController, curve: Curves.fastOutSlowIn),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultSize * 0.5),
            color: Colors.white,
          ),
          width: defaultSize * 32,
          height: defaultSize * 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${word.example}\n${word.exampleTranslations}',
            ),
          ),
        ),
      ),
    );
  }
}
