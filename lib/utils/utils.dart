import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:iron_vault/utils/constants.dart';

class Utils {
  static String generatePassword(int length, bool useSymbols, bool useAlphabet, bool useNumbers) {
    String password = "";
    String passwordCreatorString = "";
    var random = Random();

    if (useSymbols) passwordCreatorString += symbols;
    if (useNumbers) passwordCreatorString += numbers;
    if (useAlphabet) passwordCreatorString += alphabet;

    for (int i = 0; i <= length; i++) {
      String valueHolder = passwordCreatorString[random.nextInt(passwordCreatorString.length - 1)];
      password += valueHolder;
    }

    return password;
  }
}

extension Sized on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}