import 'package:flutter/material.dart';

class ColorApp {
  static Color titleColor = HexColor.fromHex('#303841');

  static Color introColor = HexColor.fromHex('#777777');
  static Color yellowButton = HexColor.fromHex('#f6c90e');
  static Color whiteButton = HexColor.fromHex('#EEEEEE');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = HexColor.fromHex('#000000');
  static Color greyPrimary = HexColor.fromHex('#2F3845');
  static Color greySecondary = HexColor.fromHex('#444F66');
}

extension HexColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = "FF$hex"; // 8 char with opacity 100%
    }
    return Color(int.parse(hex, radix: 16));
  }
}