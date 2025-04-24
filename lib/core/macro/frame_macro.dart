import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 屏幕宽度
double ScreenWidth() {
  return Get.mediaQuery.size.width;
}

double ScreenHeight() {
  return Get.mediaQuery.size.height;
}

double ZsWidth(double width) {
  return width * 1.0 / 375 * ScreenWidth();
}

double ZsHeight(double height) {
  return height * 1.0 / 812 * ScreenHeight();
}

/// 平板横屏
double IpadWidth(double width) {
  return width * 1.0 / 1194 * ScreenWidth();
}

double IpadHeight(double height) {
  return height * 1.0 / 834 * ScreenHeight();
}

/// 字体
double ZsFont(double fontSize) {
  return fontSize * ScreenWidth() / 375.0;
}

double ZsPadFont(double fontSize) {
  return fontSize * ScreenWidth() / 834.0;
}

double ZsHpadfont(double fontSize) {
  return fontSize * ScreenWidth() / 1194.0;
}

bool IsIpadWithGetX({BuildContext? context}) {
  // 判断最短边 >= 600 则认为是平板
  if (Get.context == null) {
    if (context == null) {
      return false;
    }
    var size = MediaQuery.of(context).size;
    return min(size.width, size.height) >= 600;
  }
  bool isTablet = Get.mediaQuery.size.shortestSide >= 600;
  return isTablet;
}

bool IsLandscapeWithGetX() {
  var orientation = Get.mediaQuery.orientation;
  return orientation == Orientation.landscape;
}

bool IsIpadLandscape() {
  return IsIpadWithGetX() && IsLandscapeWithGetX();
}

/// 逻辑像素点 取最短边
extension AdaptScreenUtil on num {
  double pr({double? padSize}) {
    if (Get.context == null) {
      return toDouble();
    }
    return IsIpadWithGetX() ? (padSize ?? this * (1194 / 812).r) : r;
  }
}
