import 'package:flutter/material.dart';
import 'package:words_app/config/size_config.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String highlight;
  final TextStyle style;
  final Color highlightColor;

  const HighlightText({
    Key key,
    this.text,
    this.highlight,
    this.style,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    String text = this.text ?? '';
    if ((highlight?.isEmpty ?? true) || text.isEmpty) {
      return Text(text, style: style);
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;
    do {
      indexOfHighlight = text.indexOf(highlight, start);
      if (indexOfHighlight < 0) {
        // no highlight
        spans.add(_normalSpan(
            text.substring(start, text.length), context, defaultSize));
        break;
      }
      if (indexOfHighlight == start) {
        // start with highlight.
        spans.add(_highlightSpan(highlight, defaultSize));
        start += highlight.length;
      } else {
        // normal + highlight
        spans.add(_normalSpan(
            text.substring(start, indexOfHighlight), context, defaultSize));
        spans.add(_highlightSpan(highlight, defaultSize));
        start = indexOfHighlight + highlight.length;
      }
    } while (true);

    return Text.rich(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String content, double defaultSize) {
    return TextSpan(
        text: content,
        style: TextStyle(color: Colors.red, fontSize: defaultSize * 2));
  }

  TextSpan _normalSpan(
      String content, BuildContext context, double defaultSize) {
    return TextSpan(
        text: content,
        style: Theme.of(context).primaryTextTheme.bodyText2.merge(
              TextStyle(fontSize: defaultSize * 2),
            ));
  }
}
