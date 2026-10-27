import 'dart:math';

import 'package:flutter/material.dart';

class ThemeColors {
  // static const primaryBlueColor = Color(0xff001F3F);
  static const primaryBlueColor = Color(0xff565656);
  static const primaryBlueColor3 = Color(0xff272625);
  // static const primaryBlueColor2 = Color(0xff272625);
  static const primaryBlueColor2 = Colors.black;
  static const primaryRedColor = Color(0xffc4ad7e);
  // static const primaryRedColor = Color(0xff641c24);
  static const primaryDeleteRedColor = Color(0xffa5000f);
  static const primaryGrayColor = Color(0x24001F3F);
  static const primaryGreenColor = Color(0xff158B4B);
  static const white = Colors.white;
  static const black = Colors.black;
  static const grey = Colors.grey;
}

class ThemeGradient {
  static const Gradient gradient = LinearGradient(
    colors: [
      ThemeColors.primaryBlueColor2,
      ThemeColors.primaryBlueColor3,
      // ThemeColors.primaryRedColor
    ],
    stops: [ 0.5,0.8  ],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );
}

class ThemeGradientExe {
  static const Gradient gradient = LinearGradient(
    // colors: [ThemeColors.primaryBlueColor, ThemeColors.primaryRedColor],
    colors: [ThemeColors.primaryBlueColor2, ThemeColors.primaryBlueColor3 ],
    stops: [0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}


Color getRandomReadableColor() {
  final random = Random();
  int red = random.nextInt(200) + 55;   
  int green = random.nextInt(200) + 55;
  int blue = random.nextInt(200) + 55;

  return Color.fromARGB(255, red, green, blue);
}