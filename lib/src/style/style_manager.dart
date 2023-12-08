import 'package:flutter/material.dart';

class TextStylesApp {
  //Add default color.
  static TextStyle regular({
    double fontSize = 16.0,
    required Color color,
    String fontFamily = 'Rubik',
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  static TextStyle medium({
    double fontSize = 16.0,
    required Color color,
    String fontFamily = 'Rubik',
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }

  static TextStyle bold({
    double fontSize = 18.0,
    required Color color,
    String fontFamily = 'Rubik',
    double? lineHeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
      height: lineHeight != null ? lineHeight / fontSize : null,
    );
  }
}
