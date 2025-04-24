import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ctx/core/macro/frame_macro.dart';
import 'package:flutter_ctx/presentation/pages/root_page/root_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fvp/fvp.dart' as fvp;

/// 仅限无需授权的三方初始化, 需用户授权的应等待用户同意
Future<void> loadOtherInit() async {
  fvp.registerWith();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadOtherInit();

  runApp(const MyApp());
}

const phoneSize = Size(375, 812);
const padSize = Size(834, 1194);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.Protocols
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      bool isLandscape = orientation == Orientation.landscape;
      Size deviceSize = IsIpadWithGetX(context: context) ? padSize : phoneSize;
      double w = isLandscape
          ? max(deviceSize.width, deviceSize.height)
          : min(deviceSize.width, deviceSize.height);
      double h = isLandscape
          ? min(deviceSize.width, deviceSize.height)
          : max(deviceSize.width, deviceSize.height);
      return ScreenUtilInit(
        designSize: Size(w, h),
        minTextAdapt: true,
        child: GetMaterialApp(
          title: 'Flutter CTX',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      );
    });
  }
}
