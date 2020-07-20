import 'package:flutter/material.dart';

class Validation with ChangeNotifier {
  Validation(this.value, this.error);
  final String value;
  final String error;
}
