import 'package:flutter/material.dart';
import '../models/validation.dart';

class ValidationForm with ChangeNotifier {
  Validation _errorMessage = Validation(null, null);
  Validation get errorMessage => _errorMessage;
  bool isDisableEnableEditingButtons = false;
  bool isDisableEditingDoneButton = true;

  void toggleEditingDoneButton() {
    isDisableEnableEditingButtons = !isDisableEnableEditingButtons;
    notifyListeners();
  }

  void textValidation(String value) {
    if (value.isNotEmpty) {
      _errorMessage = Validation(value, null);
      isDisableEditingDoneButton = true;
    } else {
      _errorMessage = Validation(null, 'This field cannot be empty.');
      isDisableEditingDoneButton = false;
    }
    notifyListeners();
  }
}
