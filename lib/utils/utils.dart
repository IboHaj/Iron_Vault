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

  static int determinePasswordStrength(String password) {
    int strenthLvl = 0;
    if(password.contains(RegExp(r'\d'))) strenthLvl += 1;
    if(password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) strenthLvl += 1;
    if(password.contains(RegExp(r'[a-zA-Z]'))) strenthLvl += 1;
    if(password.length > 25) strenthLvl += 1;

    return strenthLvl;
  }
}

extension Sized on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isSmallScreen => screenWidth < 400;
  bool get isMediumScreen => screenWidth > 400 && screenWidth < 600;
  bool get isTablet => screenWidth > 600;
  double get scaled => isSmallScreen ? 0.75 : isMediumScreen ? 1 : 2;
}
