import 'package:flutter/material.dart';

import 'back.dart';
import 'front.dart';

class WordsCollection extends StatefulWidget {
  WordsCollection(
      {this.collectionTitleName,
      this.chooseFrontBackContainers,
      this.goToManagerCollections,
      this.isCheckedTextEditing,
      this.isFront,
      this.onSubmit,
      this.onChanged,
      this.editingText,
      this.deleteCollection});

  final String collectionTitleName;
  final Function chooseFrontBackContainers;
  final Function goToManagerCollections;
  final bool isCheckedTextEditing;
  final bool isFront;
  final Function onSubmit;
  final Function onChanged;
  final Function editingText;
  final Function deleteCollection;

  @override
  _WordsCollectionState createState() => _WordsCollectionState();
}

class _WordsCollectionState extends State<WordsCollection>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offsetAnimation;
  Animation colorAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInBack,
    ));

    colorAnimation =
        ColorTween(begin: Color(0xFFF8B6b6), end: Color(0xFF878686))
            .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.goToManagerCollections, // Go to managerCollection
      onLongPress:
          widget.chooseFrontBackContainers, // ChooseFrontBackContainers
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        transitionBuilder: (widget, animation) {
          return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, -0.06),
                end: Offset.zero,
              ).animate(animation),
              child: widget);
        },
        child: widget
                .isFront // Check if isCheckedFrontBackContainers true or false
            ? Front(widget: widget)
            : Back(widget: widget),
      ),
    );
  }
}
