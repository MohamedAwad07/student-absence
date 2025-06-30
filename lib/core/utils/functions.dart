import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(printer: PrettyPrinter());

extension PasswordValidation on String? {
  bool isNotNullOrBlank() => this != null && this!.trim().isNotEmpty;
  bool hasNumericDigit() => this?.contains(RegExp(r'[0-9]')) == true;
  bool hasSmallLetter() => this?.contains(RegExp(r'[a-z]')) == true;
  bool hasCapitalLetter() => this?.contains(RegExp(r'[A-Z]')) == true;
  bool hasSpecialLetters() =>
      this?.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) == true;
  bool isAtLeast8Digits() => (this?.length ?? 0) >= 8;
}

Color getColorFromString(String colorString) {
  if (_isValidHexCode(colorString)) {
    return Color(int.parse('FF$colorString', radix: 16));
  } else {
    switch (colorString.toLowerCase()) {
      case 'black':
        return Colors.black;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'white':
        return Colors.white;
      case 'grey':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

bool _isValidHexCode(String code) {
  final RegExp hexCodeRegExp = RegExp(r'^([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');
  return hexCodeRegExp.hasMatch(code);
}

class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'[!@#\$%^&*()<>?/|}{~:]').hasMatch(password);
  }

  static bool isMinLength(String password) {
    return RegExp(r'.{8,15}').hasMatch(password);
  }
}
