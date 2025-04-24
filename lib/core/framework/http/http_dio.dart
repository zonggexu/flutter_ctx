// dio 基础
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_ctx/core/framework/http/error_handle.dart';
import 'package:flutter_ctx/core/utils/log_util.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';

enum Method { get, post, put, patch, delete, head }

const _methodValues = {
  Method.get: 'get',
  Method.post: 'post',
  Method.delete: 'delete',
  Method.put: 'put',
  Method.patch: 'patch',
  Method.head: 'head',
};

typedef NetSuccessCallback<T> = Function(T data);
typedef NetSuccessListCallback<T> = Function(List<T> data);
typedef NetErrorCallback = Function(int code, String msg);

class HttpDio {
  static final HttpDio _instance = HttpDio._internal();

  late Dio _dio;

  factory HttpDio() {
    return _instance;
  }

  HttpDio._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://api.swiftmiss.fun", // 默认 BaseUrl
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ));

    /// Fiddler抓包代理配置
    // dio.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     final client = HttpClient();
    //     client.findProxy = (uri) {
    //       // 将请求代理至 localhost:8888。
    //       // 请注意，代理会在你正在运行应用的设备上生效，而不是在宿主平台生效。
    //       return 'PROXY localhost:8888';
    //     };
    //     // 抓Https包设置
    //     client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   },
    // );

    /// 忽略证书校验
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    final talker = Talker();
    _dio.interceptors.add(TalkerDioLogger(talker: talker));
  }

  Future request<T>(
    Method method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    isAuth = true,
    NetSuccessCallback? onSuccess,
    NetErrorCallback? onError,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      bool connectivityResult = await checkDeviceNetType();
      if (!connectivityResult) {
        // 没有网络
        _onError(NetErrorCode.netError.code, NetErrorCode.netError.message, onError);
        return;
      }

      final Response response = await _dio.request<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(_methodValues[method], options),
        cancelToken: cancelToken,
      );
      onSuccess?.call(response.data);
    } on DioException catch (e) {
      _cancelLogPrint(e, url);
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.message, onError);
    } catch (e) {
      _onError(NetErrorCode.unknownError.code, NetErrorCode.unknownError.message, onError);
    }
  }

  Future<bool> checkDeviceNetType() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }

  Options _checkOptions(String? method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }

  void _cancelLogPrint(dynamic e, String url) {
    if (e is DioException && CancelToken.isCancel(e)) {
      Slog('取消请求接口： $url');
    }
  }

  void _onError(int? code, String msg, NetErrorCallback? onError) {
    if (code == null) {
      code = NetErrorCode.unknownError.code;
      msg = '未知异常';
    }
    Slog('接口请求异常： code: $code, mag: $msg');
    onError?.call(code, msg);
  }

  Map<String, dynamic> parseData(String data) {
    return json.decode(data) as Map<String, dynamic>;
  }
}
