import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ordering_app/core/exceptions/auth_exception.dart';
import 'package:ordering_app/core/storage/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:ordering_app/models/auth_model.dart';

import 'package:ordering_app/services/api_client/api.dart';

class AuthRequest {
  Future<AuthModel> login(authData) async {
    log(authData.toString());
    try {
      final response = await Api().postRequest('login', jsonEncode(authData));
      final authModel = AuthModel.fromJson(response.data);
      writeToStorage('jt', authModel.token);
      return authModel;
    } on DioError catch (err) {
      if (kDebugMode) {
        print(err.message);
      }
      throw AuthenticationException(
              message: err.response!.data['msg'].toString())
          .exceptionMsg();
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      var data = await readFromStorage('jt');
      final response = await Api().getRequest('auth/verify', {'tkn': data});
      if (kDebugMode) {
        print(response);
      }
      return true;
    } on DioError catch (e) {
      return false;
    }
    return false;
  }

  logout() {}
}
