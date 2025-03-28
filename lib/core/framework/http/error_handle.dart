import 'dart:io';
import 'package:dio/dio.dart';

/// 定义错误码枚举
enum NetErrorCode {
  netError(1000, '网络异常，请检查你的网络！'),
  parseError(1001, '数据解析错误！'),
  socketError(1002, '网络异常，请检查你的网络！'),
  httpError(1003, '服务器异常，请稍后重试！'),
  connectTimeout(1004, '网络连接超时，请稍后再试'),
  sendTimeout(1005, '网络连接超时，请稍后再试'),
  receiveTimeout(1006, '网络连接超时，请稍后再试'),
  cancelError(1007, '网络请求已取消'),
  badCertificate(1008, '网络连接证书无效'),
  connectionError(1009, '网络连接错误，请检查网络连接'),
  unknownError(9999, '未知异常');

  final int code;
  final String message;

  const NetErrorCode(this.code, this.message);
}

/// 网络错误类
class NetError {
  final int code;
  final String message;

  NetError(this.code, this.message);
}

/// 异常处理工具
class ExceptionHandle {
  /// 处理异常
  static NetError handleException(dynamic e) {
    if (e is DioException) {
      return e.response != null ? _handleHttpError(e) : _handleDioError(e);
    }
    return _handleOtherException(e);
  }

  /// 处理 HTTP 响应错误
  static NetError _handleHttpError(DioException e) {
    final statusCode = e.response?.statusCode ?? 9000;
    final message = "错误码：$statusCode 错误信息：${e.response?.data}";
    return NetError(statusCode, message);
  }

  /// 处理 Dio 连接异常
  static NetError _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return _fromEnum(NetErrorCode.connectTimeout);
      case DioExceptionType.sendTimeout:
        return _fromEnum(NetErrorCode.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return _fromEnum(NetErrorCode.receiveTimeout);
      case DioExceptionType.cancel:
        return _fromEnum(NetErrorCode.cancelError);
      case DioExceptionType.badCertificate:
        return _fromEnum(NetErrorCode.badCertificate);
      case DioExceptionType.connectionError:
        return _fromEnum(NetErrorCode.connectionError);
      case DioExceptionType.unknown:
        return _handleUnknownError(e);
      default:
        return _fromEnum(NetErrorCode.httpError, e.message.toString());
    }
  }

  /// 处理未知错误
  static NetError _handleUnknownError(DioException e) {
    if (e.error != null) {
      if (e.error.toString().contains("HandshakeException")) {
        return _fromEnum(NetErrorCode.connectionError);
      }
      return NetError(NetErrorCode.unknownError.code, e.error.toString());
    }
    return _fromEnum(NetErrorCode.unknownError);
  }

  /// 处理非 Dio 异常
  static NetError _handleOtherException(dynamic error) {
    if (error is SocketException) {
      return _fromEnum(NetErrorCode.socketError);
    }
    if (error is HttpException) {
      return _fromEnum(NetErrorCode.httpError);
    }
    if (error is FormatException) {
      return _fromEnum(NetErrorCode.parseError);
    }
    return _fromEnum(NetErrorCode.unknownError);
  }

  /// 从 `NetErrorCode` 创建 `NetError`
  static NetError _fromEnum(NetErrorCode errorCode, [String? customMessage]) {
    return NetError(errorCode.code, customMessage ?? errorCode.message);
  }
}
