import 'package:flutter/material.dart';
import 'package:words_app/models/fuiltersEnums.dart';

import 'package:words_app/utils/size_config.dart';

class FavoritesBtns extends StatefulWidget {
  FavoritesBtns({Key key}) : super(key: key);

  @override
  _FavoritesBtnsState createState() => _FavoritesBtnsState();
}

class _FavoritesBtnsState extends State<FavoritesBtns> {
  FilterFavorites selectedChoice = FilterFavorites.favorites;

  List<Widget> _buildFavoritesBtns() {
    SizeConfig().init(context);
    final defaultSize = SizeConfig.defaultSize;

    List<Widget> data = FilterFavorites.values.map((item) {
      return Padding(
        padding: const EdgeInsets.only(right: 30),
        child: ChoiceChip(
          backgroundColor: Colors.white,
          labelPadding: EdgeInsets.all(defaultSize * 0.8),
          selectedColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultSize * 0.5)),
          elevation: 5,
          label: Container(
            alignment: Alignment.center,
            width: defaultSize * 3,
            height: defaultSize * 3,
            child: item == FilterFavorites.favorites
                ? Icon(
                    Icons.star_border,
                    color: Colors.black,
                    size: defaultSize * 3,
                  )
                : Text('all',
                    style: TextStyle(
                        fontSize: defaultSize * 2,
                        fontWeight: FontWeight.bold)),
          ),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(
              () {
                selectedChoice = item;
              },
            );
          },
        ),
      );
    }).toList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildFavoritesBtns(),
    );
  }
}
