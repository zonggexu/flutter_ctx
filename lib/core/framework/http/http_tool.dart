// 二次封装 可拓展 上传下载等请求
import 'dart:io';

import 'package:flutter_ctx/core/framework/http/http_dio.dart';
import 'package:flutter_ctx/core/popup/popup_widget.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

class HttpTool {
  static final HttpTool _instance = HttpTool._internal();

  factory HttpTool() {
    return _instance;
  }
  HttpTool._internal();

  /// get 请求
  static void get<T>(
    String url,
    Map<String, dynamic>? params, {
    bool showLoding = false,
    bool isAuth = true,
    Success? success,
    Fail? fail,
  }) {
    _request(Method.get, url, params,
        showLoding: showLoding, isAuth: isAuth, success: success, fail: fail);
  }

  /// post 请求
  static void post<T>(
    String url,
    params, {
    bool showLoding = false,
    bool isAuth = true,
    Success? success,
    Fail? fail,
  }) {
    _request(Method.post, url, params,
        showLoding: showLoding, isAuth: isAuth, success: success, fail: fail);
  }

  /// _request 请求
  static void _request<T>(
    Method method,
    String url,
    params, {
    bool showLoding = false,
    bool isAuth = true,
    Success? success,
    Fail? fail,
  }) {
    // 加密
    // 公参
    // 是否加载loading

    Object? data;
    Map<String, dynamic>? queryParameters;
    if (method == Method.get) {
      queryParameters = params;
    } else {
      data = params;
    }

    if (showLoding) {
      ShowHUD();
    }
    HttpDio().request(method, url, data: data, queryParameters: queryParameters, isAuth: isAuth,
        onSuccess: (result) async {
      /// 等待3.5
      await Future.delayed(const Duration(milliseconds: 3500));

      if (showLoding) {
        RemoveHUD();
      }

      /// 根据 服务器情况自定义
      if (result['success'] == true) {
        success?.call(result);
      } else {
        ShowToast(message: result['message']);
        fail?.call(-1, result['message']);
      }
    }, onError: (code, msg) {
      if (showLoding) {
        RemoveHUD();
      }
      ShowToast(message: msg);
      fail?.call(code, msg);
    });
  }
}
