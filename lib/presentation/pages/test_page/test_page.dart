import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("测试1"),
      ),
      resizeToAvoidBottomInset: false,
      body: const SafeArea(
        child: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
