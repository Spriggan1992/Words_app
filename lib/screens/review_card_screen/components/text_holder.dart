import 'package:flutter/material.dart';

class TextHolder extends StatelessWidget {
  const TextHolder({
    Key key,
    @required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 25.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'n',
            style: TextStyle(fontSize: 20.0, color: Colors.green),
          ),
          SizedBox(
            width: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 140),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
