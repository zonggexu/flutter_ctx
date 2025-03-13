import 'package:flutter/material.dart';

class TestPageOne extends StatelessWidget {
  const TestPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("测试2"),
      ),
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: Center(
          child: Text("data2"),
        ),
      ),
    );
  }
}
