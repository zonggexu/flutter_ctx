import 'package:flutter/material.dart';
import 'package:flutter_ctx/core/framework/http/http_tool.dart';
import 'package:flutter_ctx/core/utils/log_util.dart';
import 'package:flutter_ctx/data/datasources/server/apis.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => TalkerScreen(talker: LogUtil.talker),
              // ));
              await performNetworkRequest();
            },
            child: const Text('测试2'),
          ),
        ),
      ),
    );
  }

  Future<void> performNetworkRequest() async {
    String url = '/superwords/login';
    Map<String, dynamic> params = {
      'param1': 'value1',
      'param2': 'value2',
    };

    HttpTool.get(
      APIs.health,
      params,
      showLoding: true,
      success: (data) {
        // 处理成功响应
        Slog('Success: $data');
      },
      fail: (code, msg) {
        // 处理失败响应
      },
    );
  }
}
