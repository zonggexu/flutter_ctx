import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ctx/core/utils/log_util.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> testData = {
      "id": 1,
      "name": "测试用户",
      "age": 25,
      "isActive": true,
      "tags": ["Flutter", "Dart", "Developer"],
      "address": {"city": "北京", "zip": "100000"},
      "addressz": {"city": "北京", "zip": "100000"},
      "addressf": {"city": "北京", "zip": "100000"},
    };
    var encoder = JsonEncoder.withIndent('  ');
    String prettyPrint = encoder.convert(testData);
    var array = [
      "Flutter",
      "Dart",
      "Developer",
      "Dart",
      "Developer",
      "Dart",
      "Developer",
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("测试1"),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Dlog("这是一条测试");
              Dlog("这是一条测试", mode: FLogMode.error);
              Dlog(prettyPrint, mode: FLogMode.info);
              Dlog(array, mode: FLogMode.warning);
              Dlog("你好", mode: FLogMode.trace);
            },
            child: const Text('测试'),
          ),
        ),
      ),
    );
  }
}
