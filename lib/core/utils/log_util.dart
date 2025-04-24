import 'dart:convert';

import 'package:talker/talker.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:talker_flutter/talker_flutter.dart';

enum FLogMode {
  trace, // 🟣 TRACE
  debug, // 💚 DEBUG
  warning, // 💛 WARNING
  info, // 💙 INFO
  error, // ❤️ ERROR
}

class LogUtil {
  static final Talker talker = Talker(
      settings: TalkerSettings(
    enabled: true,
    useHistory: true,
    maxHistoryItems: 100,
    useConsoleLogs: true,
    colors: {
      TalkerLogType.debug.key: AnsiPen()..xterm(121),
    },
  ));
  static bool isEnabled = true; // 控制日志开关的标记

  // 通用的日志打印方法
  static void _printLog(Function(String message) logFunction, dynamic message) {
    var chain = Chain.current();
    chain = chain.foldFrames((frame) => frame.isCore || frame.package == "flutter");
    final frames = chain.toTrace().frames;
    final idx = frames.indexWhere((element) => element.member == "Slog");
    if (idx == -1 || idx + 1 >= frames.length) {
      if (isEnabled) logFunction("打印失效 无文件信息 :: $message");
      return;
    }
    final frame = frames[idx + 1];

    if (isEnabled) {
      logFunction("${frame.uri.toString().split("/").last}"
          "(${frame.line})\n$message ");
    }
  }

  static void v(dynamic message) => _printLog(talker.verbose, message);

  static void d(dynamic message) => _printLog(talker.debug, message);

  static void i(dynamic message) => _printLog(talker.info, message);

  static void w(dynamic message) => _printLog(talker.warning, message);

  static void e(dynamic message) => _printLog(talker.error, message);
}

void Slog(dynamic msg, {FLogMode mode = FLogMode.info}) {
  var log = msg;
  if (msg is Map || msg is List) {
    log = const JsonEncoder.withIndent('  ').convert(msg);
  } else {
    log = msg.toString();
  }

  switch (mode) {
    case FLogMode.trace:
      LogUtil.v(log);
      break;
    case FLogMode.debug:
      LogUtil.d(log);
      break;
    case FLogMode.warning:
      LogUtil.w(log);
      break;
    case FLogMode.info:
      LogUtil.i(log);
      break;
    case FLogMode.error:
      LogUtil.e(log);
      break;
  }
}
