import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/core/defaults/constants.dart';
import 'package:ordering_app/core/storage/secure_storage.dart';

class AppInterceptors extends Interceptor {
  /// Base Config For Dio
  Dio createDio() {
    return Dio(BaseOptions(
        connectTimeout: requestTimeOutDuration,
        receiveTimeout: requestTimeOutDuration,
        baseUrl: baseUrl));
  }

  /// Add Dio Interceptor
  Dio addInterceptor(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) => requestInterceptor(options, handler),
          onResponse: (Response response, handler) =>
              responseInterceptor(response, handler),
          onError: (DioError dioError, handler) =>
              errorInterceptor(dioError, handler)));
  }

  FutureOr<dynamic> requestInterceptor(RequestOptions options, handler) async {
    var token = await readFromStorage('jt');
    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    options.headers.addAll({"Content-Type": "application/json"});
    options.path = options.path;
    return handler.next(options);
  }

  FutureOr<dynamic> responseInterceptor(Response options, handler) async {
    if (kDebugMode) {
      print(options.statusCode);
    }
    return handler.next(options);
  }

  void errorInterceptor(DioError dioError, handler) {
    // ignore: void_checks
    return handler.next(dioError);
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = "Request to API Server was cancelled";
        break;
      default:
        errorDescription = "Something Wrong in connection";
    }
    return errorDescription;
  }
}
