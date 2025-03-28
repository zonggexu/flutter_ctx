import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 自定义Snackbar错误提示
void ShowErrorSnackbar({
  required String message,
}) {
  ShowSnackbar(
    message: message,
    icon: Icons.highlight_off,
    backgroundColor: Colors.red,
  );
}

/// 自定义Snackbar正确提示
void ShowOkSnackbar({
  required String message,
}) {
  ShowSnackbar(
    message: message,
    icon: Icons.check_circle_outline,
    backgroundColor: Colors.green,
  );
}

/// 自定义Snackbar警告提示
void ShowInfoSnackbar({
  required String message,
}) {
  ShowSnackbar(
    message: message,
    icon: Icons.info,
    backgroundColor: Colors.yellow[700]!,
  );
}

/// 自定义Snackbar提示
void ShowSnackbar({
  required String message,
  required IconData icon,
  required Color backgroundColor,
  Color iconColor = Colors.white,
  double borderRadius = 15.0,
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 15),
  EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
  SnackPosition snackPosition = SnackPosition.TOP,
  Duration animationDuration = const Duration(milliseconds: 0),
  Duration duration = const Duration(milliseconds: 1500),
}) {
  Get.closeCurrentSnackbar();
  Get.rawSnackbar(
    message: message,
    icon: Icon(icon, color: iconColor),
    backgroundColor: backgroundColor,
    borderRadius: borderRadius,
    margin: margin,
    padding: padding,
    snackPosition: snackPosition,
    animationDuration: animationDuration,
    duration: duration,
  );
}

/// 自定义Toast提示
void ShowToast({
  String message = "",
}) {
  Fluttertoast.showToast(msg: message, gravity: ToastGravity.CENTER);
}

/// loading
void ShowHUD() {
  showLoading();
}

void RemoveHUD() {
  hideLoading();
}

// 显示加载框
showLoading() {
  Get.dialog(
    const Center(
      child: SpinKitFadingCircle(
        color: Color(0xFFB39DDB), // 加载指示器颜色
        size: 50.0, // 加载指示器大小
      ),
    ),
    barrierColor: Colors.transparent, // 遮罩颜色
    barrierDismissible: false, // 禁止点击背景关闭
  );
}

// 隐藏加载框
hideLoading() {
  if (Get.isDialogOpen ?? false) {
    Get.back(); // 关闭对话框
  }
}
