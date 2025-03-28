import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 主题色
Color MainColor() {
  return Get.theme.primaryColor;
}

// 获取一个随机颜色值
Color RandomColor() {
  final Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
    1, // Alpha
  );
}
