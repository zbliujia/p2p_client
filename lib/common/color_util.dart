import 'dart:convert';

import 'package:flutter/material.dart';

class ColorUtil {
  static const Color navBlackTitleTextColor = Color(0xFF1F1F1F);
  static const Color mainBgColor = Color(0xFFF5F5F5);
  static const Color greenTextColor = Color(0xFF6BDCB0);
  static const Color greenButtonColor = Color(0xFF6BDCB0);

  ///将16进制的Color字符串转换为Color对象 <br>
  /// @param color 示例：#FF00FF 或 FF00FF
  static Color hexToColor(String color) {
    if(color.length != 6 && color.length != 7) {
      throw const FormatException("color is invalid");
    }
    if(color.startsWith("#")) {
      return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return Color(int.parse(color, radix: 16) + 0xFF000000);
  }
}