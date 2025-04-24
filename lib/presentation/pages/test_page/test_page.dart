import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ctx/presentation/pages/test_page/test_byte_video_effects.dart';
import 'package:flutter_ctx/presentation/pages/test_page/test_viedeo.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("神秘空间"),
      ),
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            children: [
              CupertinoButton(
                color: Colors.purple,
                child: const Text("测试一"),
                onPressed: () async {
                  await testGetTo(1);
                },
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.purple,
                child: const Text("测试二"),
                onPressed: () async {
                  await testGetTo(2);
                },
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.purple,
                child: const Text("字体动画特效"),
                onPressed: () async {
                  await testGetTo(3);
                },
              ),
              const SizedBox(height: 20),
              CupertinoButton(
                color: Colors.purple,
                child: const Text("透明视频播放"),
                onPressed: () async {
                  await testGetTo(4);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Future<void> testOne() async {
    // Get.dialog(
    //   AuthCaptcha(onConfirmCallback: (value) {
    //     Get.back();
    //   }),
    // );
    // Get.to(() => const ChangePasswordView(
    //       topTitle: "设置密码",
    //       isFromChangePassword: true,
    //       onlyReadPhone: "13128700789",
    //     ));
  }

  Future<void> testTwo() async {
    Get.to(() => const TransparentVideoDemo());
  }

  Future<void> testGetTo(int index) async {
    switch (index) {
      case 1:
        await testOne();
        break;
      case 2:
        await testTwo();
        break;
      case 3:
        Get.to(() => const TestByteVideoEffects());
        break;
      case 4:
        Get.to(() => const TransparentVideoDemo());
        break;
      default:
        print("Default case executed");
    }
  }
}
