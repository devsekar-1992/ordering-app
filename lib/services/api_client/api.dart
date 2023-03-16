import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'interceptors.dart';

class Api {
  postRequest(path, postData) {
    Dio dio;
    dio = AppInterceptors().createDio();
    dio = AppInterceptors().addInterceptor(dio);
    return dio.post(path, data: postData);
  }

  putRequest(path, postData) {
    Dio dio;
    dio = AppInterceptors().createDio();
    dio = AppInterceptors().addInterceptor(dio);
    return dio.put(path, data: postData);
  }

  deleteRequest(path, postData) {
    Dio dio;
    dio = AppInterceptors().createDio();
    dio = AppInterceptors().addInterceptor(dio);
    return dio.delete(path, data: postData);
  }

  getRequest(path, getData) {
    if (kDebugMode) {
      print(getData);
    }
    Dio dio;
    dio = AppInterceptors().createDio();
    dio = AppInterceptors().addInterceptor(dio);
    if (getData != '') {
      return dio.get(path, queryParameters: getData);
    } else {
      return dio.get(path);
    }
  }
}
