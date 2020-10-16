import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/bloc/blocs.dart';
import 'package:words_app/config/config.dart';
import 'package:words_app/models/models.dart';
import 'package:words_app/screens/screens.dart';
import 'package:words_app/widgets/widgets.dart';
import 'widgets/widgets.dart';

class ReviewCard extends StatefulWidget {
  static String id = 'review_card_screen';
  final int index;
  final List<Word> words;
  final String collectionId;
  final String collectionTitle;
  ReviewCard({this.index, this.words, this.collectionId, this.collectionTitle});

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  /// Initial index of page;
  int _initialPage;

  /// If `true` show front - examples text
  bool _isFront = true;
  String _selectedChoice = '';

  /// Initial page from index
  int _page;
  List<Difficulty> _difficultyList = DifficultyList().difficultyList;

  @override
  void initState() {
    super.initState();
    getCurrInd();
    _pageController =
        PageController(viewportFraction: 0.8, initialPage: _initialPage);

    _page = widget.index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Set up [_isFront] `true` or `false`
  void toggleIsFront() {
    _isFront = !_isFront;
    setState(() {});
  }

  /// Pass throught [_initialPage] what we get from [screens/manager_collection/components/word_card.dart]
  void getCurrInd() {
    _initialPage = widget.index;
    Timer(Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(
          widget.collectionTitle,
        ),
        actions: <Widget>[],
        appBar: AppBar(),
      ),
      bottomSheet: BaseBottomAppbar(
          goToCollection: () =>
              Navigator.pushNamed(context, CollectionsScreen.id),
          screenDefiner: ScreenDefiner.reviewCard,
          trainingsWordCounter: "${widget.words?.length ?? 0}",
          goToTrainings: () {
            context.bloc<TrainingManagerBloc>().add(TrainingManagerLoaded(
                words: widget.words, collectionId: widget.collectionId));
            Navigator.pushNamed(
              context,
              TrainingManager.id,
            );
          }),
      body: buildBody(context),
    );
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: PageView.builder(
              onPageChanged: (value) {
                setState(
                  () {
                    _initialPage = value;
                    _page = _pageController.page.round();
                    _selectedChoice = '';
                  },
                );
              },
              controller: _pageController,
              itemCount: widget.words.length,
              itemBuilder: (context, index) {
                bool active = index == _page;
                return FlipCard(
                  onFlip: () {
                    setState(() {
                      toggleIsFront();
                    });
                  },
                  direction: FlipDirection.HORIZONTAL,
                  speed: 400,
                  front: WordCard(
                    word: widget.words[index],
                    side: 'front',
                    index: index,
                    part: widget.words[index].part.partColor,
                    active: active,
                  ),
                  back: WordCard(
                    word: widget.words[index],
                    index: index,
                    part: widget.words[index].part.partColor,
                    active: active,
                  ),
                );
              },
            ),
          ),
        ),
        buildDifficulties(context)
      ],
    );
  }

  Container buildDifficulties(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      margin: EdgeInsets.only(bottom: defaultSize * 6),
      height: defaultSize * 5,
      width: SizeConfig.blockSizeHorizontal * 78,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            _difficultyList.length,
            (index) => Container(
              padding: const EdgeInsets.all(5.0),
              child: ChoiceChip(
                labelPadding:
                    EdgeInsets.symmetric(horizontal: defaultSize * 0.7),
                elevation: 5,
                padding: EdgeInsets.symmetric(
                  horizontal: defaultSize * 0.6,
                  vertical: defaultSize,
                ),
                label: Text(_difficultyList[index].name),
                labelStyle: Theme.of(context).primaryTextTheme.bodyText2.merge(
                      TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                backgroundColor: _difficultyList[index].color,
                selected: _selectedChoice == _difficultyList[index].name,
                onSelected: (selected) {
                  setState(
                    () {
                      _selectedChoice = _difficultyList[index].name;
                    },
                  );
                  context.bloc<WordsBloc>().add(
                        WordsUpdatedWord(
                          word: widget.words[_page].copyWith(
                              difficulty: _difficultyList[index].difficulty),
                        ),
                      );
                  context.bloc<WordsBloc>().add(WordsLoaded());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
