import 'package:equatable/equatable.dart';
import 'package:words_app/models/word.dart';

class WordsList extends Equatable {
  final List<Word> words;

  WordsList({this.words});

  WordsList copyWith({List<Word> words}) {
    return WordsList(words: words ?? this.words);
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
